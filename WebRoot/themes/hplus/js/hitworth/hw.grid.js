;(function ( $, window, document, undefined ){
	var HwGrid = function(element,options){
		//jquery元素变量
		this.$element = $(element);
		//js元素对象
		this._element = element;
		//id
		this._elementId = this._element.id;	
		
		this._tableId = 'hw_table_'+this._elementId;
		
		this.$table = new Object;
		//grid数据
		this._data = options.data;		
		//grid各列属性
		this._cloums = options.cloums;
		//ajax路径
		this._url = options.url;
		//当前页
		this._thispage = options.page;
		//每页条数
		this._pagesize = options.pagesize;
		//id域
		this._id_filed = options.id_filed;
		//checkbox
		this._show_check = options.show_check;
		//box元素
		this._box = options.box;
		//表格按钮
		this._buttons = options.box.buttons;
		//box是否初始化
		this.boxInited = false;
		
		if(this._data!=undefined){
			//初始化
			this._init();
		}else{
			//异步加载
			this._load();
		}
	}

	//默认构造参数
	HwGrid.defaults = {
		box :{
			tools : {
				collapse : true,
				close : true
			}
		},
		page : 1,
		pagesize : 20,
		show_check : true
	}

	//继承属性
	HwGrid.prototype = {
		//初始化
		_init : function(){
			if(this._box!=undefined){
				this.renderBox();
			}else{
				this.renderTable();
			}			
			this.renderThead();
			this.renderTbody();
			this.randerPaging();
			this.checkboxInit();
			this.initPageEvent();
		},
		//渲染包裹box
		renderBox : function(){
			if(this.boxInited){
				return;
			}
			var ibox = $('<div class="ibox float-e-margins"></div>');
			var title = $('<div class="ibox-title"></div>')
			var h5 = $('<h5>'+this._box.title+'</h5>');
			var tools = $('<div class="ibox-tools"></div>');
			if(this._box.tools.collapse){
				tools.append('<a class="collapse-link"><i class="fa fa-chevron-up"></i></a>');
			}
			if(this._box.tools.close){
				tools.append(' <a class="close-link"><i class="fa fa-times"></i></a>');
			}
			title.append(h5);
			title.append(tools);			
			var content = $('<div class="ibox-content"></div>');
			var gridwrapper = $('<div class="dataTables_wrapper form-inline" role="grid"></div>');
			var p = $('<p></p>');
			p = this.initButtons(p);
			var table = $('<table id="'+this._tableId+'" class="table table-striped table-bordered table-hover dataTables-example"></table>');			
			gridwrapper.append(p);
			gridwrapper.append(table);
			content.append(gridwrapper);
			ibox.append(title);
			ibox.append(content);
			this.$element.append(ibox);			
			this.$table = table;
			this.boxInited = true;
		},
		initButtons : function(p){
			$.each(this._buttons,function(index,content){
				var button = 
					$('<button type="button" class="btn btn-w-m btn-default">'+content.text+'</button>');
				button.click(content.handle);
				p.append(button);
				p.append('&nbsp;');
			});
			return p;
		},
		//渲染表格
		renderTable : function(){
			var table = $('<table id="'+this._tableId+'" class="table table-striped table-bordered table-hover dataTables-example"></table>');
			this.$element.append(table);
			this.$table = table;
		},
		//渲染头部
		renderThead : function(){
			var checkbox_str = '';
			if(this._show_check==true){
				checkbox_str = '<td style="width:3%;"><input id="'+this._elementId+'_checkbox_all" data-title="'+this._elementId+'_checkbox_all" data-set="#'+this._elementId+' .i-checks" class="i-checks" type="checkbox"/></td>';
			}
			this.$table.append('<thead><tr>'+checkbox_str+'</tr></thead>');
			$('#'+this._tableId+' > thead > tr').append('<td style="width:3%;">#</td>');
			var that = this;
			$.each(that._cloums,function(index,content){
			var style = "";
			if (content.width != undefined) {
				style = ' style="width:'+content.width+'"';
			}
			$('#'+that._tableId+' > thead > tr').append('<td '+style+'>'+content.title+'</td>');
			});
		
		},
		//渲染主体
		renderTbody : function(){
			this.$table.append('<tbody></tbody>');
			var head_array = [];
			var formate_array = [];
			var that = this;
			$.each(that._cloums,function(index,content){
				head_array.push(content.filed);
				formate_array.push(content.format);
			});
			var id_filed = that._id_filed;
			$.each(that._data.data,function(index,content){
				var thispage = that._thispage;
				var pagesize = that._pagesize;
				var str = "";
				str+=('<tr>');
				var num = (thispage-1)*pagesize+index+1;		
				for(var i = 0; i < head_array.length;i++){				
					if(i==0){
						if(that._show_check==true){
							str+=('<td><input class="i-checks" name="'+that._elementId+'_ids" data-title="'+that._elementId+'_checkbox" type="checkbox" value="'+content[id_filed]+'"/></td>');
						}							
						str+=('<td>'+num+'</td>');
					}
				var value = content[head_array[i]];
				if(formate_array[i]!=undefined)
				{
					var fun = formate_array[i];
					value = fun(content[head_array[i]]);
				}
				str+=('<td>'+value+'</td>');
			}
			str+=('</tr>');
			$('#'+that._tableId+' > tbody').append(str);			
		});		
		},
		//渲染翻页组件
		randerPaging : function(){
			var totalpage = this.getTotalPage();
			var pre_disabled = false;
			var next_disabled = false;
			if(this._thispage==1){
				pre_disabled=true;
			}
			if(this._thispage==totalpage){
				next_disabled=true;
			}
			var page_tool_str='<div id="'+this._elementId+'_page_tool" class="row">'
			+'<div id="'+this._elementId+'_page_info" class="col-sm-6"></div>'
			+'<div class="col-sm-6">'
			+'<div id="'+this._elementId+'_paginate" class="dataTables_paginate paging_simple_numbers">'
			+'<ul class="pagination">'
			+'<li id="'+this._elementId+'_page_pre" tabindex="0" aria-controls="DataTables_Table_0" class="paginate_button previous">'
			+'<a href="javascript:void(0)">上一页</a>'
			+'</li>'
			+'<li id="'+this._elementId+'_page_next" tabindex="0" aria-controls="DataTables_Table_0" class="paginate_button next">'
			+'<a href="javascript:void(0)">下一页</a>'
			+'</li>'
			+'</ul>'
			+'</div>'
			+'</div>'
			+'</div>';
			this.$table.after(page_tool_str);
			$("#"+this._elementId+"_page_info").html(this._thispage+"/"+totalpage+"("+this._data.total+")");

			if(pre_disabled){
				$("#"+this._elementId+"_page_pre").addClass("disabled");
				$("#"+this._elementId+"_page_pre").attr("disabled",true);
			}
			if(next_disabled){
				$("#"+this._elementId+"_page_next").addClass("disabled");
				$("#"+this._elementId+"_page_next").attr("disabled",true)
			}
		},
		//加载翻页事件
		initPageEvent : function(){
			var that = this;
			$("#"+this._elementId+"_page_next").click(function(e){	
				if(!$(this).attr("disabled")){
					that.nextPage();
				}
			});

			$("#"+this._elementId+"_page_pre").click(function(e){	
				if(!$(this).attr("disabled")){
					that.prePage();
				}			
			});

		},
		//下一页
		nextPage : function(table_id){
			this._thispage++;
			this._load();
		},
		//上一页
		prePage : function(table_id){
			this._thispage--;
			this._load();
		},
		//获取总页数
		getTotalPage : function(){
			var totalpage = 0;
			var totalcount = this._data.total;
			var pagesize = this._pagesize;
			if(totalcount%pagesize!=0){
					totalpage = Math.floor(totalcount/pagesize) + 1;
			}else{
					totalpage = Math.floor(totalcount/pagesize);
			}
			return totalpage;
		},
		//checkbox事件初始化
		checkboxInit : function(){
			var that = this;
			$('input[data-title="'+that._elementId+'_checkbox_all"]').change(function(e){
				var check = document.getElementById(that._elementId+"_checkbox_all").checked;
				var checkboxs = document.getElementsByName(that._elementId+"_ids");	
				for(var i = 0 ; i < checkboxs.length; i++){
					checkboxs[i].checked = check;
				}			
			});

			$('input[data-title="'+that._elementId+'_checkbox"]').change(function(e){
				that.allCheck();
			});

			$('#'+that._tableId+' > tbody > tr').click(function(e){
				$(this).find('input[name="'+that._elementId+'_ids"]').trigger("click");
			});
		
			$('#'+that._tableId+' > tbody > tr').find('input[name="'+that._elementId+'_ids"]').click(function(e){
				e.stopPropagation();
			});
		},
		allCheck : function(){
			var flag = false;
			var checkboxs = document.getElementsByName(this._elementId+"_ids");
			for(var i = 0 ; i < checkboxs.length; i++){
				if(checkboxs[i].checked == false){
					flag = true;
				}
			}
			if(flag){
				document.getElementById(this._elementId+"_checkbox_all").checked = false;
			}else{
				document.getElementById(this._elementId+"_checkbox_all").checked = true;
			}
		},
		currentCheckeds : function(){
			var ids = [];
			var checkboxs = document.getElementsByName(this._elementId+"_ids");	
			for(var i = 0 ; i < checkboxs.length; i++){
				if(checkboxs[i].checked){
					ids.push(checkboxs[i].value);
				}
			}
			return ids;
		},
		_remove : function(){
			$('#'+this._tableId).html('');
			$('#'+this._elementId+'_page_tool').remove();
		},
		_load : function(){
			var that = this;
			
			$.post(that._url, {
				thispage : that._thispage,
				pagesize : that._pagesize
			}, function(res) {			
				 if (typeof res=="object")
                 {
					 that._data=res;
                 }
                 else
                 {
                	var json = eval("("+res+")");
 					that._data = json;	
                 }
				that._remove();
				that._init();
			});		
		}
	}

	//为jquery元素实例添加实例方法
	var fun = function(options){
		options = $.extend({}, HwGrid.defaults, options);
		var eles = [];
		this.each(function() {
			var self = this;
			var grid = new HwGrid(self,options);
			eles.push(grid);
		});
		return eles[0];	
	};

	$.fn.extend({
		'HwGrid':fun
	});
})(jQuery, window,document);