;
(function($, window, document, undefined) {

	var MetroGrid = function(element, options) {
		// jquery元素变量
		this.$element = $(element);
		// js元素对象
		this._element = element;
		// id
		this._elementId = this._element.id;
		// 表id
		this._tableId = 'metro_table_' + this._elementId;
		// 表jquery元素
		this.$table = new Object();
		// box是否初始化
		this.boxInited = false;
		// 搜索栏是否初始化
		this.searchInited = false;
		// 工具栏是否初始化
		this.toolsInited = false;
		// 当前属性
		this._options = options;
		// 初始化属性
		SetAttribute(this._options, this);
		if (this._data != undefined) {
			// 初始化
			this._init();
		} else {
			// 异步加载
			this._load();
		}
	};
	// 设置属性函数
	var SetAttribute = function(options, that) {
		// grid数据
		that._data = options.data;
		// grid各列属性
		that._cloums = options.cloums;
		// ajax路径
		that._url = options.url;
		// 当前页
		that._pageNum = options.pageNum;
		// 每页条数
		that._pageSize = options.pageSize;
		// id域
		that._id_filed = options.id_filed;
		// td样式变量
		that._td_style = new Array();
		// checkbox
		that._show_check = options.show_check;
		//显示序号
		that._show_index = options.show_index;
		
		that._showPaging = options.showPaging;

		if (options.box != undefined) {
			// box元素
			that._box = options.box;
		}
		if (options.tools != undefined) {
			// 工具栏
			that._tools = options.tools;
		}
		if (options.dropDowns != undefined) {
			// 工具栏
			that._dropDowns = options.dropDowns;
		}
		if (options.search != undefined) {
			// 搜索元素
			that._search = options.search;
			// 表格按钮
			that._search_items = options.search.items;
		}
		if (options.actionCloums != undefined) {
			// 操作栏
			that._actionCloums = options.actionCloums;
		}
		if (options.actionWidth != undefined) {
			// 操作栏宽度
			that._actionWidth = options.actionWidth;
		}
		// 操作栏显示文本
		that._actionCloumText = options.actionCloumText;
	};

	// 默认构造参数
	MetroGrid.defaults = {
		actionCloumText : "操作",
		actionWidth　: "20%",
		pageNum : 1,
		pageSize : 5,
		show_check : true,
		show_index : false,
		showPaging : true
	};

	// 继承属性
	MetroGrid.prototype = {
		// 重新加载grid
		reload : function(options) {
			if (options != undefined) {
				this._options = $.extend({}, this._options, options);
				SetAttribute(this._options, this);
			}
			this._load();
		},
		// 下一页
		nextPage : function() {
			if (this._pageNum < this._getTotalPage()) {
				this._pageNum++;
				this._load();
			}
		},
		// 上一页
		prePage : function() {
			if (this._pageNum > 1) {
				this._pageNum--;
				this._load();
			}
		},
		// 跳转页面
		goPage : function(num) {
			var reg = /^[0-9]*[1-9][0-9]*$/;
			if (reg.test(num) && num <= this._getTotalPage()) {
				this._pageNum = num;
				this._load();
			}
		},
		// 获取当前选中节点id
		currentCheckeds : function() {
			var ids = [];
			var checkboxs = $("#" + this._tableId).find("[name='checkboxes']");
			// var checkboxs = document
			// .getElementsByName(this._elementId + "_ids");
			for ( var i = 0; i < checkboxs.length; i++) {
				if ($(checkboxs[i]).is(':checked')) {
					ids.push($(checkboxs[i]).val());
				}
			}
			return ids;
		},
		// 初始化
		_init : function() {
			if (this._box != undefined) {
				this._renderBox();
			} else {
				if (this._tools != undefined && !this.toolsInited) {
					this._renderTools();
					this.toolsInited = true;
				}
				if (this._search != undefined && !this.searchInited) {
					this._renderSearch();
					this.searchInited = true;
				}
				this._renderTable();
			}
			this._renderColgroup();
			this._renderThead();
			this._renderTbody();
			if (this._show_check) {
				this._checkboxInit();
			}
			if (this._showPaging) {
				this._randerPaging();
				this._initPageEvent();
			}
			this._uniform();
		},
		// 异步加载
		_load : function() {
			try {
				App.blockUI(this.$element);
				var that = this;
				var form_data = "";
				if (this.$searchForm != undefined) {
					if (that._url.indexOf("?") != -1) {
						form_data = "&"
					} else {
						form_data = "?"
					}
					form_data += $("#" + this._elementId + "_search_form")
							.serialize();
				}
				$.post(that._url + form_data, {
					pageNum : that._pageNum,
					pageSize : that._pageSize
				}, function(res) {
					if (typeof res == "object") {
						that._data = res;
					} else {
						var json = eval("(" + res + ")");
						that._data = json;
					}
					that._remove();
					that._init();
				});
				App.unblockUI(this.$element);
			} catch (e) {
				App.unblockUI(this.$element);
			}
		},
		// 删除
		_remove : function() {
			$("#" + this._tableId + "_wrapper").remove();
		},
		// 异步刷新表格
		_refresh : function() {
			this._load();
		},
		_uniform : function() {
			if (!$().uniform) {
				return;
			}
			var test = $("input[type=checkbox]:not(.toggle), input[type=radio]:not(.toggle, .star)");
			if (test.size() > 0) {
				test.each(function() {
					$(this).show();
					$(this).uniform();
				});
			}
		},
		// 渲染工具栏
		_renderTools : function() {
			var row = $('<div class="clearfix"></div>');
			var span = this._initTools();
			var drop_downs = this._initDropDowns();
			row.append(span);
			row.append(drop_downs);
			this.$element.append(row);
			this.$element.append('<hr>');
		},
		// 初始工具栏
		_initTools : function() {
			var span = $('<div class="span8"></div>');
			$.each(this._tools, function(index, content) {
				var button = $('<button type="button" class="btn '
						+ content.cls + '">' + content.text + '</button>');
				button.click(content.handle);
				span.append(button);
				span.append('&nbsp;');
			});
			return span;
		},
		_initDropDowns : function() {
			if(this._dropDowns!=undefined){
				var that = this;
				var span = $('<div class="span4"></div>');
				$.each(this._dropDowns, function(index, content) {
					var btn_group = $('<div class="btn-group pull-right"></div>');
					var button = $('<button class="btn green dropdown-toggle" data-toggle="dropdown">'+content.buttonText+'<i class="icon-angle-down"></i></button>');
					var drop_down = $('<ul class="dropdown-menu"></ul>');
					$.each(content.items, function(i, content) {
						var li = $('<li><a href="javascript:;">'+content.text+'</a></li');
						drop_down.append(li);
						li.bind("click",function(){
							content.handle();
						});
					});
					btn_group.append(button);
					btn_group.append(drop_down);
					span.append(btn_group)
				});
				return span;
			}else{
				return "";
			}
		},
		// 渲染搜索
		_renderSearch : function() {
			var that = this;
			var searchForm = $('<form id="' + that._elementId
					+ '_search_form"></form>');
			var row = $('<div class="row-fluid"></div>');
			this.$searchForm = searchForm;
			this.$searchForm.append(row);
			$.each(this._search_items, function(index, content) {
				that._initSearchItems(content);
			});
			var search_row = $('<div class="row-fluid"></div>');
			var search_span = $('<div class="span6"></div>');
			var searchBtn = $('<button type="button" class="btn green"> 搜 索 </button>');
			search_span.append(searchBtn);
			search_span.append("&nbsp;");
			var fun = this._search.submitHandle;
			searchBtn.click(function() {
				that._pageNum = 1;
				that._load();
				if(that._search.submitHandle!=undefined)
					fun();
			});
			var resetBtn = $('<button type="reset" class="btn"> 重 置 </button>');
			search_span.append(resetBtn);
			search_row.append(search_span);
			this.$searchForm.append(search_row);
			this.$element.append(this.$searchForm);
			this.$element.append("<hr>");
		},
		// 初始搜索
		_initSearchItems : function(content) {
			if (content.type == 'text') {
				this.$searchForm.find(".row-fluid").append(
						this._getText(content));
			}
			if (content.type == 'select') {
				this.$searchForm.find(".row-fluid").append(
						this._getSelect(content));
			}
			if (content.type == 'radioGroup') {
				this.$searchForm.find(".row-fluid").append(
						this._getRadioGroup(content));
			}
			if (content.type == 'checkboxGroup') {
				this.$searchForm.find(".row-fluid").append(
						this._getCheckboxGroup(content));
			}
			// 待增加别的类型
		},
		// 搜索元素之text
		_getText : function(content) {
			var str = '<div class="span3"><div class="control-group">';
			str += '<label class="control-label">' + content.label + '</label>';
			str += '<div class="controls"><input type="text" name="'
					+ content.name + '" class="m-wrap span12"></div>';
			str += '</div></div>';
			return str;
		},
		// 搜索元素之select的option
		_getOptions : function(items) {
			var str = '';
			$.each(items, function(index, content) {
				str += '<option value="' + content.value + '">' + content.text
						+ '</option>';
			});
			return str;
		},
		// 搜索元素之select
		_getSelect : function(content) {
			var that = this;
			var str = '<div class="span3"><div class="control-group">';
			str += '<label class="control-label">' + content.label + '</label>';
			str += '<select class="m-wrap span12" name="' + content.name
					+ '" id="' + content.id + '">';
			if (content.items != undefined) {
				var items = content.items;
				str += this._getOptions(items);
			}
			if (content.itemsUrl != undefined) {
				$.post(content.itemsUrl, {}, function(res) {
					var urlItems;
					if (typeof res == "object") {
						urlItems = res;
					} else {
						var json = eval("(" + res + ")");
						urlItems = json;
					}
					var urlOptions = that._getOptions(urlItems);
					that.$searchForm.find("#" + content.id).append(urlOptions);
				});
			}
			str += '</select></div></div>';
			return str;
		},
		_getRadios : function(items) {
			var str = '';
			$.each(items, function(index, content) {
				str += '<label class="radio inline">';
				str += '<input type="radio" name="' + content.name
						+ '" value="' + content.value + '">' + content.text
						+ '</label>';
			});
			return str;
		},
		_getAjaxRadios : function(items) {
			var str = '';
			$.each(items, function(index, content) {
				str += '<label class="radio">';
				str += '<input type="radio" name="' + content.name
						+ '" value="' + content.value + '">' + content.text
						+ '</label>';
			});
			return str;
		},
		_getRadioGroup : function(element_data) {
			var that = this;
			var str = '<div class="span3"><div id="' + element_data.id
					+ '" class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			if (element_data.items != undefined) {
				var items = element_data.items;
				str += this._getRadios(items);
			}
			if (element_data.itemsUrl != undefined) {
				$.post(element_data.itemsUrl, {}, function(res) {
					var urlItems;
					if (typeof res == "object") {
						urlItems = res;
					} else {
						var json = eval("(" + res + ")");
						urlItems = json;
					}
					var urlRadios = that._getAjaxRadios(urlItems);
					that.$searchForm.find("#" + element_data.id).append(
							urlRadios);
				});
			}
			str += '</div></div>'
			return str;
		},
		// checkbox渲染
		_getCheckboxs : function(items) {
			var str = '';
			$.each(items, function(index, content) {
				str += '<label class="checkbox inline">';
				str += '<input type="checkbox" name="' + content.name
						+ '" value="' + content.value + '">' + content.text
						+ '</label>';
			});
			return str;
		},
		// ajax异步加载checkbox
		_getAjaxCheckboxs : function(items) {
			var str = '';
			$.each(items, function(index, content) {
				str += '<label class="checkbox inline">';
				str += '<input type="checkbox" name="' + content.name
						+ '" value="' + content.value + '">' + content.text
						+ '</label>';
			});
			return str;
		},
		_getCheckboxGroup : function(element_data) {
			var that = this;
			var str = '<div class="span3"><div id="' + element_data.id
					+ '" class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';

			if (element_data.items != undefined) {
				var items = element_data.items;
				str += this._getCheckboxs(items);
			}
			if (element_data.itemsUrl != undefined) {
				$.post(element_data.itemsUrl, {}, function(res) {
					var urlItems;
					if (typeof res == "object") {
						urlItems = res;
					} else {
						var json = eval("(" + res + ")");
						urlItems = json;
					}
					var urlCheckboxs = that._getAjaxCheckboxs(urlItems);
					that.$searchForm.find("#" + element_data.id).append(
							urlCheckboxs);
				});
			}
			str += '</div></div>'
			return str;
		},
		// 渲染包裹grid的box
		_renderBox : function() {
			if (this.boxInited) {
				return;
			}
			var ibox = $('<div class="portlet box green"></div>');
			var title = $('<div class="portlet-title"></div>')
			var caption = $('<div class="caption">' + this._box.title
					+ '</div>');
			var tools = $('<div class="tools"></div>');
			if (this._box.tools.collapse) {
				tools.append('<a href="javascript:;" class="collapse"></a>');
			}
			if (this._box.tools.close) {
				tools.append('<a href="javascript:;" class="remove"></a>');
			}
			title.append(caption);
			title.append(tools);
			var content = $('<div class="portlet-body"></div>');
			var gridwrapper = $('<div id="' + this._tableId
					+ '_wrapper" class="dataTables_wrapper form-inline"></div>');
			var table = $('<table id="' + this._tableId
					+ '" class="table table-striped table-hover"></table>');
			gridwrapper.append(table);
			content.append(gridwrapper);
			ibox.append(title);
			ibox.append(content);
			this.$element.append(ibox);
			this.$element = content;
			this.$table = table;
			this.boxInited = true;
		},
		// 渲染表格
		_renderTable : function() {
			var gridwrapper = $('<div id="' + this._tableId
					+ '_wrapper" class="dataTables_wrapper form-inline"></div>');
			var table = $('<table id="' + this._tableId
					+ '" class="table table-striped table-hover"></table>');
			this.$table = table;
			gridwrapper.append(table);
			this.$element.append(gridwrapper);
		},
		_renderColgroup : function() {
			var colgroup = $('<colgroup></colgroup>');
			if (this._show_check == true) {
				colgroup.append('<col width="2%"></col>');
			}
			if (this._show_index == true) {
				colgroup.append('<col width="3%"></col>');
			}
			var that = this;
			$.each(that._cloums,
					function(index, content) {
						if (content.width != undefined) {
							colgroup.append('<col width="' + content.width
									+ '"></col>');
						} else {
							colgroup.append('<col></col>');
						}
					});
			if (that._actionCloums != undefined) {
				colgroup.append('<col width="'+this._actionWidth+'%"></col>');
			}
			this.$table.append(colgroup);
		},
		// 渲染表格头部
		_renderThead : function() {
			var checkbox_str = '';
			if (this._show_check == true) {
				checkbox_str = '<th><input class="group-checkable" data-set="#'
						+ this._tableId
						+ ' .checkboxes" type="checkbox"/></th>';
			}
			this.$table.append('<thead><tr>' + checkbox_str + '</tr></thead>');
			if (this._show_index == true) {
				$('#' + this._tableId + ' > thead > tr').append('<th>#</th>');
			}
			var that = this;
			$.each(that._cloums,
					function(index, content) {
						var style = "";
						if (content.align != undefined) {
							style += "text-align:" + content.align + ";";
						}
						style += "vertical-align: middle;";
						// 记录表头各个列的样式
						that._td_style[index] = style;
						$('#' + that._tableId + ' > thead > tr').append(
								'<th style="' + style + '">' + content.title
										+ '</th>');
					});
			// 操作栏
			if (that._actionCloums != undefined) {
				$('#' + this._tableId + ' > thead > tr').append(
						'<th>' + this._actionCloumText + '</th>');
			}
		},
		// 渲染表格主体
		_renderTbody : function() {
			this.$table.append('<tbody></tbody>');
			var head_array = [];
			var head_index = [];
			var formate_array = [];
			var that = this;
			$.each(that._cloums, function(index, content) {
				head_array.push(content.filed);
				head_index.push(index);
				formate_array.push(content.format);
			});
			var id_filed = that._id_filed;
			if (that._data.data != undefined && that._data.data != null) {
				$
						.each(
								that._data.data,
								function(index, content) {
									var current_data = content;
									var thispage = that._pageNum;
									var pagesize = that._pageSize;
									var tr = $('<tr></tr>')
									var str = "";
									var num = (thispage - 1) * pagesize + index
											+ 1;
									for ( var i = 0; i < head_array.length; i++) {
										if (i == 0) {
											if (that._show_check == true) {
												str += ('<td><input class="checkboxes" name="checkboxes" type="checkbox" value="'
														+ content[id_filed] + '"/></td>');
											}
											if (that._show_index == true) {
												str += ('<td>' + num + '</td>');
											}
										}
										var format_str = "";
										if (formate_array[i] != undefined) {
											var fun = formate_array[i];
											format_str = fun(num, current_data);
											str += ('<td style='
													+ that._td_style[head_index[i]]
													+ '>' + format_str + '</td>');
										} else {
											var value = content[head_array[i]];
											str += ('<td style='
													+ that._td_style[head_index[i]]
													+ '>' + value + '</td>');
										}

									}
									tr.append(str);
									if (that._actionCloums != undefined) {
										var cltd = $('<td></td>');
										tr.append(cltd);
										$
												.each(
														that._actionCloums,
														function(index, content) {
															var text = '';
															if (content.text != undefined) {
																text = content.text;
															}
															if (content.textHandle != undefined) {
																text = content
																		.textHandle(
																				num,
																				current_data);
															}
															var button = $('<button class="btn '
																	+ content.cls
																	+ '">'
																	+ text
																	+ '</button>');
															button
																	.click(function(
																			e) {
																		content
																				.handle(
																						num,
																						current_data);
																		e
																				.stopPropagation();
																	});
															cltd.append(button);
															cltd
																	.append('&nbsp;');
														});
									}
									$('#' + that._tableId + ' > tbody').append(
											tr);
								});
			}
		},
		// 渲染翻页组件
		_randerPaging : function() {
			var totalpage = this._getTotalPage();
			var pre_disabled = false;
			var next_disabled = false;
			if (this._pageNum == 1) {
				pre_disabled = true;
			}
			if (this._pageNum == totalpage) {
				next_disabled = true;
			}
			var page_tool_str = '<hr><div id="'
					+ this._elementId
					+ '_page_tool" class="row-fluid">'
					+ '<div class="span6">'
					+ '<div id="'
					+ this._elementId
					+ '_page_info" class="dataTables_info"></div></div>'
					+ '<div class="span6">'
					+ '<div id="'
					+ this._elementId
					+ '_paginate" class="dataTables_paginate paging_bootstrap pagination">'
					+ '<ul>'
					+ '<li id="'
					+ this._elementId
					+ '_page_first"'
					+ 'class="prev"><a href="javascript:;"><span class="hidden-480">首页</span></a></li>'
					+ '<li id="'
					+ this._elementId
					+ '_page_pre" class="prev">'
					+ '<a href="javascript:void(0)"><span class="hidden-480">上一页</span></a>'
					+ '</li>'
					+ '<li id="'
					+ this._elementId
					+ '_page_next" class="next">'
					+ '<a href="javascript:void(0)"><span class="hidden-480">下一页</a></span>'
					+ '</li>'
					+ '<li id="'
					+ this._elementId
					+ '_page_last"'
					+ 'class="next"><a href="javascript:;"><span class="hidden-480">尾页</span></a></li>'
					+ '<li><input type="text" value="'
					+ this._pageNum
					+ '" id="'
					+ this._elementId
					+ '_num" style="width:20px;height:20px;float:left"/>'
					+ '<a id="'
					+ this._elementId
					+ '_go" href="javascript:;"><span class="hidden-480">跳转</span></a></li>'
					+ '</ul>' + '</div>' + '</div>' + '</div>';
			this.$table.after(page_tool_str);
			var pageStr = '<label class="span6">第'
					+ (totalpage==0?0:this._pageNum)
					+ '/'
					+ totalpage
					+ '页  共'
					+ this._data.total
					+ '条数据  <select id="'
					+ this._elementId
					+ '_page_length" class="m-wrap span3"><option value="5">5</option><option value="15">15</option><option value="50">50</option></select>'
					+ '条每页</label>';
			$("#" + this._elementId + "_page_info").html(pageStr);
			$("#" + this._elementId + "_page_length").val(this._pageSize);
			if (pre_disabled) {
				$("#" + this._elementId + "_page_pre").addClass("disabled");
				$("#" + this._elementId + "_page_pre").attr("disabled", true);
			}
			if (next_disabled) {
				$("#" + this._elementId + "_page_next").addClass("disabled");
				$("#" + this._elementId + "_page_next").attr("disabled", true)
			}
		},
		// 加载翻页事件
		_initPageEvent : function() {
			var that = this;
			$("#" + this._elementId + "_page_next").click(function(e) {
				if (!$(this).attr("disabled")) {
					that.nextPage();
				}
			});

			$("#" + this._elementId + "_page_pre").click(function(e) {
				if (!$(this).attr("disabled")) {
					that.prePage();
				}
			});

			$("#" + this._elementId + "_page_first").click(function(e) {
				that.goPage(1);
			});

			$("#" + this._elementId + "_page_last").click(function(e) {
				var lastPage = that._getTotalPage();
				if (lastPage == 0) {
					lastPage == 1;
				}
				that.goPage(lastPage);
			});

			$("#" + this._elementId + "_go").click(function() {
				var num = $("#" + that._elementId + "_num").val();
				if (num > 0 && num <= that._getTotalPage()) {
					that.goPage(num);
				}
			});

			$("#" + this._elementId + "_page_length").change(function() {
				var num = $(this).val();
				that._pageSize = num;
				that.reload();
			});

		},

		// 获取总页数
		_getTotalPage : function() {
			var totalpage = 0;
			var totalcount = this._data.total;
			var pagesize = this._pageSize;
			if (totalcount % pagesize != 0) {
				totalpage = Math.floor(totalcount / pagesize) + 1;
			} else {
				totalpage = Math.floor(totalcount / pagesize);
			}
			return totalpage;
		},
		// checkbox事件初始化
		_checkboxInit : function() {
			var that = this;
			$('#' + this._tableId + ' .group-checkable').change(function() {
				var set = $(this).attr("data-set");
				var checked = $(this).is(":checked");
				$(set).each(function() {
					if (checked) {
						$(this).attr("checked", true);
					} else {
						$(this).attr("checked", false);
					}
				});
				$.uniform.update(set);
			});

		}
	}

	// 为jquery元素实例添加实例方法
	var grid = function(options) {
		options = $.extend({}, MetroGrid.defaults, options);
		var eles = [];
		this.each(function() {
			var self = this;
			var grid = new MetroGrid(self, options);
			eles.push(grid);
		});
		return eles[0];
	};

	$.fn.extend({
		'MetroGrid' : grid
	});
})(jQuery, window, document);