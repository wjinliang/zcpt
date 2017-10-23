(function ( $, window, document, undefined ){
	// 构造函数
	var MetroMenu = function(options){
		// 菜单数据
		this._options = options;
		// 初始化属性
		SetAttribute(options,this);
		if(this._data!=undefined){
			// 初始化
			this._init();
		}else{
			// 异步加载
			this._load();
		}
	};
	var SetAttribute = function(options,that){
		that._type = options.type;
		if(that._type=="side"){
			that.$element = $("#sidebar");
		}else if(that._type=="vertical"){
			that.$element = $("#vertical");
		}
		if(options.data!=undefined){
			// 菜单数据
			if (typeof(options.data)=="object"){
				that._data=options.data;
	        }else{
	        	that._data = eval("("+options.data+")");
	        }
		}
		// 选中菜单id
		that._activeId = options.activeId;
		// 事件监听
		that._event = options.events;
		// 加载菜单路径
		that._ajax_url = options.url;
		// 菜单默认图标
		that._default_icon_css = options.default_icon_css;
	};
	// 默认构造参数
	MetroMenu.defaults = {
		default_icon_css : "icon-folder-open",
		url : undefined,
		activeId : undefined,
		data : undefined,
		type :　"vertical",
		events : [{
			type : 'click',
			handle : function(id,url){
				if(url.indexOf("#")==-1){
					window.location.href=dm_root+url;
				}								
			}
		}]
	};
	// 继承属性
	MetroMenu.prototype = {
		// 外部调用方法：重新加载菜单
		reload : function(options){
			this._remove();
			if (options != undefined) {
				this._options = $.extend({}, this._options, options);
				SetAttribute(this._options, this);
			}
			if(this._url!=undefined){
				this._load();
			}else{
				this._init();
			}
		},
		// 外部调用方法：设置菜单选中
		activeMenu : function(id){
			this._clearActive();
			this._active(id);
		},
		// 初始化
		_init : function(){
			if(this._type=="vertical"){
				this._renderVerticalMenus();
				this._renderVerticalSideMenus();
			}else if(this._type=="side"){
				this._renderSideMenus();
			}else{
				return;
			}
			this._initEventLisener();
			var id = this._getActiveId();
			if(id!=undefined){
				this._active(id);
				$.cookie('active_id_dm', id, {
					expires : 7,
					path : '/',
					secure : false
				});
			}else{
				id = $.cookie('active_id_dm');
				this._active(id);
			}
		},
		// 异步加载菜单
		_load : function(){
			var that = this;
			$.post(that._ajax_url, {}, function(res) {
				if (typeof res=="object"){
					that._data=res;
                }else{
                	var json = eval("("+res+")");
 					that._data = json;	
                }
				that._init();
			});		
		},
		// 渲染侧边菜单
		_renderSideMenus : function(){
			$("body").removeClass("page-full-width");
			var that = this;
			var ul = $('<ul class="page-sidebar-menu"></ul>');
			this.$element.append(ul);
			ul.append('<li><div data-type="sidebar-icon" class="sidebar-toggler hidden-phone"></div></li>');
			$.each(this._data,function(index,content){			
				if(content.pId==0){		
					var url = ';';
					that.$element.find('.page-sidebar-menu').append('<li id="li_'+content.id+'" title="'+content.name+'" ><a data-type="menu" data-id="'+content.id+'" data-url="'+content.url+'" id="a_'+content.id+'" href=\'javascript:'+url+'\' ><i class="'+content.icon+'"></i><span class="title">'+content.name+'</span>'
							+'<span id="span_'+content.id+'"></span></a></li>');	
					that._renderSideSubMenus(content.id);
				}
				
			});
		},
		// 渲染侧边子菜单
		_renderSideSubMenus : function(eleId){
			var that = this;
			$.each(this._data,function(index,content){
				if(content.pId==eleId){
					if($('#ul_'+eleId).length<=0){
						$('#a_'+eleId).append('<span class="arrow"></span>');
						$('#li_'+eleId).append('<ul id="ul_'+eleId+'" class="sub-menu"></ul>');
					}
					var url = ';';
					$('#ul_'+eleId).append('<li id="li_'+content.id+'"  title="'+content.name+'" ><a data-type="menu" data-id="'+content.id+'" data-url="'+content.url+'" id="a_'+content.id+'" href=\'javascript:'+url+'\'><i class="'+content.icon+'"></i><span class="title">'+content.name+'</span>'
							+'<span id="span_'+content.id+'"></span></a></li>');
					that._renderSideSubMenus(content.id);
				}
				
			});
		},
		// 渲染垂直菜单
		_renderVerticalMenus: function(){
			$("body").addClass("page-full-width");
			var that = this;
			var inner = $('<div class="navbar-inner"></div>');
			this.$element.append(inner);
			inner.append('<ul class="nav"></ul>');
			$.each(this._data,function(index,content){	
				if(content.pId==0){
					var url = ';';
					var extra = '';
					if(!content.isLeaf){
						extra = 'data-toggle="dropdown" class="dropdown-toggle"';
					}
					that.$element.find('.nav').append('<li id="li_'+content.id+'" title="'+content.name+'" ><a data-type="menu" data-id="'+content.id+'" data-url="'+content.url+'" data="top_a" id="a_'+content.id+'" '+extra+' href=\'javascript:'+url+'\' >'+content.name
							+'<span id="span_'+content.id+'"></span></a></li>');	
					that._renderVerticalSubMenus(content.id);
				}
			});
		},
		// 渲染垂直子菜单
		_renderVerticalSubMenus: function(eleId){
			var that = this;
			$.each(this._data,function(index,content){
				if(content.pId==eleId){
					if($('#ul_'+eleId).length<=0){
						$('#a_'+eleId).append('<span class="arrow"></span>');
						$('#li_'+eleId).append('<ul id="ul_'+eleId+'" class="dropdown-menu"></ul>');
					}
					var url = ';';
					var extra = '';
					if(!content.isLeaf){
						extra = 'data-toggle="dropdown" class="dropdown-toggle"';
					}
					$('#ul_'+eleId).append('<li id="li_'+content.id+'"  title="'+content.name+'" ><a data-type="menu" data-id="'+content.id+'" data-url="'+content.url+'" id="a_'+content.id+'" '+extra+' href=\'javascript:'+url+'\'>'+content.name
							+'<span id="span_'+content.id+'"></span></a></li>');
					that._renderVerticalSubMenus(content.id);
				}
			});
		},
		//渲染水平菜单状态时的侧边菜单
		_renderVerticalSideMenus : function(){
			var that = this;
			var ul = $('<ul class="page-sidebar-menu"></ul>');
			$("#v-sidebar").append(ul);
			$.each(this._data,function(index,content){			
				if(content.pId==0){		
					var url = ';';
					$("#v-sidebar").find('.page-sidebar-menu').append('<li id="v_li_'+content.id+'" title="'+content.name+'" ><a data-type="menu" data-id="'+content.id+'" data-url="'+content.url+'" id="v_a_'+content.id+'" href=\'javascript:'+url+'\' ><i class="'+content.icon+'"></i><span class="title">'+content.name+'</span>'
							+'<span id="v_span_'+content.id+'"></span></a></li>');	
					that._renderVerticalSideSubMenus(content.id);
				}
				
			});
		},
		// 渲染水平菜单状态时的侧边子菜单
		_renderVerticalSideSubMenus : function(eleId){
			var that = this;
			$.each(this._data,function(index,content){
				if(content.pId==eleId){
					if($('#v_ul_'+eleId).length<=0){
						$('#v_a_'+eleId).append('<span class="arrow"></span>');
						$('#v_li_'+eleId).append('<ul id="v_ul_'+eleId+'" class="sub-menu"></ul>');
					}
					var url = ';';
					$('#v_ul_'+eleId).append('<li id="v_li_'+content.id+'"  title="'+content.name+'" ><a data-type="menu" data-id="'+content.id+'" data-url="'+content.url+'" id="v_a_'+content.id+'" href=\'javascript:'+url+'\'><i class="'+content.icon+'"></i><span class="title">'+content.name+'</span>'
							+'<span id="v_span_'+content.id+'"></span></a></li>');
					that._renderVerticalSideSubMenus(content.id);
				}
				
			});
		},
		// 选中菜单
		_active : function(id){
			$('#li_'+id).addClass("active");
			$('#li_'+id).parents('li').addClass("active");
			$('#li_'+id).parents('li').find('.arrow:first').addClass("open");
			if(this._type == "side")
	    	{
				$('#li_'+id).parents('li').find('a').append("<span class='selected'></span>");
				$('#li_'+id).find('a').find("#span_"+id).addClass("selected");
	    	}else if(this._type == "vertical"){
	    		if($('#li_'+id).parents('li').length==0){
	    			$('#li_'+id).find('a').find("#span_"+id).addClass("selected");
	    		}else{
	    			$('#li_'+id).parents('li').find('a[data="top_a"]').append("<span class='selected'></span>");
	    		}
	    		$('#v_li_'+id).addClass("active");
	    		$('#v_li_'+id).parents('li').addClass("active");
	    		$('#v_li_'+id).parents('li').find('.arrow:first').addClass("open");
	    		$('#v_li_'+id).parents('li').find('a').append("<span class='selected'></span>");
				$('#v_li_'+id).find('a').find("#v_span_"+id).addClass("selected");
	    	}else{
	    		return;
	    	}
		},
		// 取消选中
		_clearActive : function(){
			this.$element.find('li').removeClass('active');
		},
		_getActiveId : function(){
			var active_id=undefined;
			$.each(this._data,function(index,content){
				var url = window.location.href;
				var r = url.indexOf(content.url);
				if (r != -1){
					active_id = content.id;
					return false;
				} 
			});
			return active_id;
		},
		// 初始事件
		_initEventLisener : function(){
			var that = this;
			if(that._event){
				$.each(that._event,function(index,content){
					var handle = content.handle;
					that.$element.find('a[data-type="menu"]').bind(content.type,function(){
						handle($(this).attr("data-id"),$(this).attr("data-url"));
					});
					if(that._type=="vertical"){
						$("#v-sidebar").find('a[data-type="menu"]').bind(content.type,function(){
							handle($(this).attr("data-id"),$(this).attr("data-url"));
						});
					}
				});
			}
			
		},
		// 清除
		_remove : function(){
			this.$element.html("");
		}
	};
	// 为jquery元素实例添加实例方法
	var menu = function(options){
		options = $.extend({}, MetroMenu.defaults, options);
		var menu = new MetroMenu(options);
		return menu;	
	};
	$.extend({
		'MetroMenu':menu
	});
})(jQuery, window,document);