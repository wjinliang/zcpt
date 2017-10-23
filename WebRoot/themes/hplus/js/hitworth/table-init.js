var Table = function() {

	var table_setting = new Array();
	var table_data = new Array();
	var column_data = new Array();
	var checkbox_mode = new Array();
	

	var getTotalPage = function(pagesize,totalcount){
			var totalpage = 0;
			if(totalcount%pagesize!=0){
					totalpage = Math.floor(totalcount/pagesize) + 1;
			}else{
					totalpage = Math.floor(totalcount/pagesize);
			}
			return totalpage;
	}

	var initThead = function(table_id,table_columns){
		var checkbox_str = '';
		if(checkbox_mode[table_id]==true){
			checkbox_str = '<td style="width:3%;"><input id="'+table_id+'_checkbox_all" data-title="'+table_id+'_checkbox_all" data-set="#'+table_id+' .i-checks" class="i-checks" type="checkbox"/></td>';
		}
		$('#'+table_id).append('<thead><tr>'+checkbox_str+'</tr></thead>');
		$('#'+table_id+' > thead > tr').append('<td style="width:3%;">#</td>');
		$.each(table_columns,function(index,content){
			var style = "";
			if (typeof(content.width) != "undefined") {
				style = ' style="width:'+content.width+'"';
			}
			$('#'+table_id+' > thead > tr').append('<td '+style+'>'+content.title+'</td>');
		});
	}

	var initTbody = function(table_id,table_cloumns,body_json){
		$('#'+table_id).append('<tbody></tbody>');
		var head_array = [];
		$.each(table_cloumns,function(index,content){
			head_array.push(content.filed);
		});
		var id_filed = table_setting[table_id].id_filed;
		$.each(body_json,function(index,content){
			var thispage = table_setting[table_id].thispage;
			var pagesize = table_setting[table_id].pagesize;

			var str = "";
			str+=('<tr>');
			var num = (thispage-1)*pagesize+index+1;		
			for(var i = 0; i < head_array.length;i++){				
				if(i==0){
					if(checkbox_mode[table_id]==true){
						str+=('<td><input class="i-checks" name="'+table_id+'_ids" data-title="'+table_id+'_checkbox" type="checkbox" value="'+content[id_filed]+'"/></td>');
					}							
					str+=('<td>'+num+'</td>');
				}
				
				str+=('<td>'+content[head_array[i]]+'</td>');
			}
			str+=('</tr>');
			$('#'+table_id+' > tbody').append(str);			
		});

	}

	var initPageTools = function(table_id,thispage,pagesize,totalcount){	
		var totalpage = getTotalPage(pagesize,totalcount);
		var pre_disabled = false;
		var next_disabled = false;
		if(thispage==1){
			pre_disabled=true;
		}
		if(thispage==totalpage){
			next_disabled=true;
		}
		var page_tool_str='<div id="'+table_id+'_page_tool" class="row">'
			+'<div id="'+table_id+'_page_info" class="col-sm-6"></div>'
			+'<div class="col-sm-6">'
			+'<div id="'+table_id+'_paginate" class="dataTables_paginate paging_simple_numbers">'
			+'<ul class="pagination">'
			+'<li id="'+table_id+'_page_pre" tabindex="0" aria-controls="DataTables_Table_0" class="paginate_button previous">'
			+'<a href="javascript:void(0)">上一页</a>'
			+'</li>'
			+'<li id="'+table_id+'_page_next" tabindex="0" aria-controls="DataTables_Table_0" class="paginate_button next">'
			+'<a href="javascript:void(0)">下一页</a>'
			+'</li>'
			+'</ul>'
			+'</div>'
			+'</div>'
			+'</div>';
		$('#'+table_id).after(page_tool_str);
		$("#"+table_id+"_page_info").html(thispage+"/"+totalpage+"("+totalcount+")");

		if(pre_disabled){
			$("#"+table_id+"_page_pre").addClass("disabled");
			$("#"+table_id+"_page_pre").attr("disabled",true);
		}
		if(next_disabled){
			$("#"+table_id+"_page_next").addClass("disabled");
			$("#"+table_id+"_page_next").attr("disabled",true)
		}
		
	}


	var all_checked = function(table_id){		
		var flag = false;
		var checkboxs = document.getElementsByName(table_id+"_ids");
		for(var i = 0 ; i < checkboxs.length; i++){
			if(checkboxs[i].checked == false){
				flag = true;
			}
		}
		if(flag){
			document.getElementById(table_id+"_checkbox_all").checked = false;
		}else{
			document.getElementById(table_id+"_checkbox_all").checked = true;
		}
	}

	var checkboxInit = function(table_id){

		$('input[data-title="'+table_id+'_checkbox_all"]').change(function(e){
			var check = document.getElementById(table_id+"_checkbox_all").checked;
			var checkboxs = document.getElementsByName(table_id+"_ids");	
			for(var i = 0 ; i < checkboxs.length; i++){
				checkboxs[i].checked = check;
			}
			
		});

		$('input[data-title="'+table_id+'_checkbox"]').change(function(e){
			all_checked(table_id);
		});

		$('#'+table_id+' > tbody > tr').click(function(e){
			$(this).find('input[name="'+table_id+'_ids"]').trigger("click");
		});
		
	}

	var randerTable = function(table_id,table_json,table_columns){
		initThead(table_id,table_columns);
		
		initTbody(table_id,table_columns,table_json.data);
		
		var thispage = table_setting[table_id].thispage;
		var pagesize = table_setting[table_id].pagesize;
		var totalcount = table_json.totalcount;
		
		initPageTools(table_id,thispage,pagesize,totalcount);
		
		
	}

	var cleanTable = function(table_id){
		$('#'+table_id).html('');
		$('#'+table_id+'_page_tool').remove();
		
	}

	var buildTable = function(table_id,data_json,column_json,checkbox){
			
			cleanTable(table_id);
			randerTable(table_id,data_json,column_json);
			checkboxInit(table_id);
			initGoPage(table_id);
	}

	var refreshTable = function(table_id){
		buildTable(table_id,table_data[table_id],column_data[table_id],checkbox_mode[table_id]);
	}


	var initGoPage = function(table_id){
		$("#"+table_id+"_page_next").click(function(e){	
			if(!$(this).attr("disabled")){
				nextPage(table_id);
			}
		});

		$("#"+table_id+"_page_pre").click(function(e){	
			if(!$(this).attr("disabled")){
				prePage(table_id);
			}
			
		});
	}

	var nextPage = function(table_id){
		table_setting[table_id].thispage++;
		ajaxLoad(table_id);
	}

	var prePage = function(table_id){
		table_setting[table_id].thispage--;
		ajaxLoad(table_id);
	}

	var ajaxLoad = function(table_id){
		$.post(table_setting[table_id].url, {
				thispage : table_setting[table_id].thispage,
				pagesize : table_setting[table_id].pagesize
			}, function(res) {
				var json = $.parseJSON(res);
				table_data[table_id] = json;
				buildTable(table_id,json,column_data[table_id]);
		});
	}

	var getCheckedIds = function(table_id){
		var ids = [];
		var checkboxs = document.getElementsByName(table_id+"_ids");	
		for(var i = 0 ; i < checkboxs.length; i++){
			if(checkboxs[i].checked){
				ids.push(checkboxs[i].value);
			}
		}
		return ids;
	}

	return {
		init : function(table_id,data_json,column_json,setting,checkbox){
			if(typeof(checkbox) != "undefined"){
				checkbox_mode[table_id] = checkbox;
			}else{
				checkbox_mode[table_id] = true;
			}

			table_data[table_id] = data_json;
			column_data[table_id] = column_json;
			table_setting[table_id]=setting;
			buildTable(table_id,data_json,column_json,checkbox);
		},
		load : function(table_id,setting,column_json,checkbox){
			if(typeof(checkbox) != "undefined"){
				checkbox_mode[table_id] = checkbox;
			}else{
				checkbox_mode[table_id] = true;
			}

			
			column_data[table_id] = column_json;
			table_setting[table_id]=setting;
			
			$.post(setting.url, {
				thispage : setting.thispage,
				pagesize : setting.pagesize
			}, function(res) {
				var json = $.parseJSON(res);
				table_data[table_id] = json;
				buildTable(table_id,json,column_json);
			});
		},
		currentCheckeds : function(table_id){
			return getCheckedIds(table_id);
		}
	}  
}();