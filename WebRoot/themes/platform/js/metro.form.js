;
(function($, window, document,undefined) {
	//kindeditor
	var KE;
	if(KindEditor!=undefined){
		KindEditor.ready(function(K) {
			KE = K;
		});
	}
	
	var MetroForm = function(element, options) {
		this.$element = $(element);
		this._element = element;
		this._elementId = this._element.id;
		// 表单juqery元素变量
		this.$form = new Object();
		this._editor = new Object();
		// 记录当前form属性
		this._options = options;
		// 初始化form属性
		SetAttribute(this._options, this);
		this._init();
	};
	// 设置属性
	var SetAttribute = function(options, that) {
		// 表单id
		that._form_id = options.id;
		// 表单名称
		that._form_name = options.name;
		// 表单提交方式
		that._form_method = options.method;
		// 表单提交action
		that._form_action = options.action;
		// 是否ajax提交
		that._form_ajaxSubmit = options.ajaxSubmit;
		// ajax提交成功回调函数
		if (options.ajaxSuccess != undefined) {
			that._form_ajaxSuccess = options.ajaxSuccess;
		}
		// 提交按钮文本
		that._showSubmit = options.showSubmit;
		// 提交按钮文本
		that._form_submitText = options.submitText;
		// 是否显示重置
		that._form_showReset = options.showReset;
		// 重置按钮文本
		that._form_resetText = options.resetText;
		// 表单元素
		that._items = options.items;
		// 表单按钮
		that._buttons = options.buttons;
		// 是否开启表单验证
		that._isValidate = options.isValidate;
		// form默认样式
		that._cls = options.cls;
		that.$K = KE;
	};

	MetroForm.defaults = {
		id : "metro_form_id",
		name : "metro_form_name",
		action : "",
		method : "post",
		ajaxSubmit : false,
		showSubmit : true,
		submitText : "保存",
		showReset : true,
		resetText : "重置",
		isValidate : false,
		cls : "form-horizontal"
	};

	MetroForm.prototype = {
		// 加载本地data
		loadLocal : function(param) {
			App.blockUI(this.$element);
			this.$form.reset();
			var that = this;
			this.reset();
			var form_data;
			if (typeof param == "object") {
				form_data = param;
			} else {
				var json = eval("(" + param + ")");
				form_data = json;
			}
			this._randerDate(form_data);
			App.unblockUI(this.$element);
		},
		// 异步加载表单
		loadRemote : function(url) {
			App.blockUI(this.$element);
			this.reset();
			var that = this;
			that.reset();
			$.post(url, {}, function(res) {
				var form_data;
				if (typeof res == "object") {
					form_data = res;
				} else {
					var json = eval("(" + res + ")");
					form_data = json;
				}
				that._randerDate(form_data);
			});
			App.unblockUI(this.$element);
		},
		// form重载
		reload : function(options) {
			this._options = $.extend({}, this._options, options);
			SetAttribute(this._options, this);
			this._remove();
			this._init();
		},
		// 设置action
		setAction : function(action) {
			this._form_action = action;
		},
		// 重置表单
		reset : function() {
			$("#" + this._form_id)[0].reset();
		},
		// 表单内显示提示信息
		alertText : function(type, msg, time) {
			this._alert(type, msg, time);
		},
		// 清空表单内提示信息
		cleanAlertText : function() {
			$(".alert").remove();
		},
		// 刷新元素支持select，radiogroup，checkboxgroup
		refreshItem : function(id, url) {
			var that = this;
			var eles = this.$form.find("#" + id);
			var ele;
			if (eles.length > 0) {
				ele = $(eles[0]);
				if (ele.is("select")) {
					ele.empty();
					$.each(that._items, function(index, content) {
						if (content.id == id) {
							$.post(url, {}, function(res) {
								var urlItems;
								if (typeof res == "object") {
									urlItems = res;
								} else {
									var json = eval("(" + res + ")");
									urlItems = json;
								}
								var value = content.value;
								var urlOptions = that._getOptions(urlItems,
										value);
								ele.append(urlOptions);
							});
						}
					});

				} else if (ele.is("div") && ele.attr("data-type") == "radio") {
					ele.html("");
					$.each(that._items, function(index, content) {
						if (content.id == id) {
							$.post(url, {}, function(res) {
								var urlItems;
								if (typeof res == "object") {
									urlItems = res;
								} else {
									var json = eval("(" + res + ")");
									urlItems = json;
								}
								var validate = '';
								if (that._isValidate) {
									if (content.rule != undefined) {
										var rule = content.rule;
										for ( var key in rule) {
											validate += 'data-rule-' + key
													+ '="' + rule[key] + '" ';
										}
									}

									if (content.msg != undefined) {
										var msg = content.msg;
										for ( var key in msg) {
											validate += 'data-msg-' + key
													+ '="' + msg[key] + '" ';
										}
									}
								}
								var urlRadios = that._getAjaxRadios(urlItems,
										validate);
								urlRadios += '<label for="' + urlItems[0].name
										+ '" class="error"></label>';
								ele.append(urlRadios);
							});

						}
					});

				} else if (ele.is("div") && ele.attr("data-type") == "checkbox") {
					ele.html("");
					$.each(that._items, function(index, content) {
						if (content.id == id) {
							$.post(url, {}, function(res) {
								var urlItems;
								if (typeof res == "object") {
									urlItems = res;
								} else {
									var json = eval("(" + res + ")");
									urlItems = json;
								}
								var validate = '';
								if (that._isValidate) {
									if (content.rule != undefined) {
										var rule = content.rule;
										for ( var key in rule) {
											validate += 'data-rule-' + key
													+ '="' + rule[key] + '" ';
										}
									}

									if (content.msg != undefined) {
										var msg = content.msg;
										for ( var key in msg) {
											validate += 'data-msg-' + key
													+ '="' + msg[key] + '" ';
										}
									}
								}
								var urlCheckboxs = that._getAjaxCheckboxs(
										urlItems, validate);
								urlCheckboxs += '<label for="'
										+ urlItems[0].name
										+ '" class="error"></label>';
								ele.append(urlCheckboxs);
							});
						}
					});

				}
			}
		},
		// 初始化
		_init : function() {
			this._initFormInfo();
			this._initItems();
			this._initButtons();
			if (this._isValidate) {
				this._validate();
			}
			this._uniform();
		},
		// 表单验证成功后执行函数
		_validate : function() {
			var that = this;
			this.$form.validate({
				errorElement : 'span', // default input error message container
				errorClass : 'help-inline', // default input error message class
				focusInvalid : false, // do not focus the last invalid input
				ignore : ".ignore",
				errorPlacement : function(error, element) {
					if (element.attr("data-type") == "checkbox"
							|| element.attr("data-type") == "radio"
							|| element.attr("data-type") == "datetime"
							|| element.attr("data-type") == "file") {
						error.addClass("no-left-padding").insertAfter(
								"#" + element.attr("name") + "_error");
					} else {
						error.insertAfter(element);
					}
				},

				highlight : function(element) { // hightlight error inputs
					$(element).closest('.help-inline').removeClass('ok');
					$(element).closest('.control-group').removeClass('success')
							.addClass('error'); // set error class to the
					// control group
				},

				unhighlight : function(element) { // revert the change dony by
					// hightlight
					$(element).closest('.control-group').removeClass('error');
				},

				success : function(label) {
					label.addClass('valid').addClass('help-inline ok').closest(
							'.control-group').removeClass('error').addClass(
							'success');
				},
				submitHandler : function(form) {
					// 若是ajax提交
					if (that._form_ajaxSubmit) {
						$.ajax({
							type : that._form_method,
							url : that._form_action,
							data : $('#' + that._form_id).serialize(),
							dataType : "json",
							success : that._form_ajaxSuccess,
							error : function(data) {
								alert("异步提交表单错误.");
							}
						});
						// 普通表单提交
					} else {
						form.submit();
					}
				}
			});
		},
		// 初始化表单
		_initFormInfo : function() {
			var form = $('<form id="' + this._form_id + '" name="'
					+ this._form_name + '" method = "' + this._form_method
					+ '" action="' + this._form_action + '" class="'
					+ this._cls + '"></form>');
			$('#' + this._elementId).append(form);
			this.$form = form;
		},
		// 提示
		_alert : function(type, msg, time) {
			var alert_div = $('<div class="alert alert-'
					+ type
					+ ' alert-dismissable">'
					+ '<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>'
					+ msg + '</div>');
			this.$form.prepend(alert_div);
			this._scrollTo(alert_div, -200);
			var remove = function() {
				alert_div.remove();
			}
			if (time != undefined)
				setTimeout(remove, time);
		},
		_scrollTo : function(el, offeset) {
			var pos = el ? el.offset().top : 0;
			$('html,body').animate({
				scrollTop : pos + (offeset ? offeset : 0)
			}, 'slow');
		},
		// 初始化元素
		_initItems : function() {
			var that = this;
			$
					.each(
							that._items,
							function(index, content) {
								if (content.type == 'text') {
									that.$form.append(that._getText(content));
								}
								if (content.type == 'hidden') {
									$('#' + that._form_id).append(
											that._getHidden(content));
								}
								if (content.type == 'password') {
									$('#' + that._form_id).append(
											that._getPassword(content));
								}
								if (content.type == 'textarea') {
									$('#' + that._form_id).append(
											that._getTextarea(content));
								}
								if (content.type == 'display') {
									$('#' + that._form_id).append(
											that._getDisplay(content));
								}
								if (content.type == 'checkboxGroup') {
									$('#' + that._form_id).append(
											that._getCheckboxGroup(content));
								}
								if (content.type == 'radioGroup') {
									$('#' + that._form_id).append(
											that._getRadioGroup(content));
								}
								if (content.type == 'select') {
									$('#' + that._form_id).append(
											that._getSelect(content));
								}
								if (content.type == 'datepicker') {
									$('#' + that._form_id).append(
											that._getDatepicker(content));
								}
								if (content.type == 'file') {
									$('#' + that._form_id).append(
											that._getFile(content));
									if (content.isAjaxUpload != undefined
											&& content.isAjaxUpload
											&& content.uploadUrl != undefined) {
										var uploadUrl = content.uploadUrl;
										$("#" + content.name + "_error").html(
												"");
										$('#' + content.id + '_button')
												.click(
														function() {
															if ($(
																	"#"
																			+ content.id
																			+ "_span")
																	.text() == "") {
																$(
																		"#"
																				+ content.name
																				+ "_error")
																		.html(
																				"<font color='#b94a48'>请选择文件</font>");
																return;
															}
															$
																	.ajaxFileUpload({
																		url : uploadUrl,
																		secureuri : false,
																		fileElementId : content.id,
																		dataType : "json",
																		success : function(
																				data,
																				status) {
																			content
																					.OnSuccess(data);
																		},
																		error : function(
																				data,
																				status,
																				e) {
																			alert(e);
																		}
																	});
														});
									}

								}
								if (content.type == 'tree') {
									$('#' + that._form_id).append(
											that._getTree(content));
									var checkMode = "checkbox";
									if (content.checkMode != undefined) {
										checkMode = content.checkMode;
									}
									var tree = $("#" + content.id)
											.MetroFormTree({
												treeId : content.treeId,
												url : content.url,
												setting : {
													async : {
														enable : true,
														url : content.url,
														autoParam: ["id", "name"]
													},
													check : {
														enable : true,
														chkStyle : checkMode,
														radioType : "all"
													},
													data : {
														simpleData : {
															enable : true
														}
													}
												}
											});
									$('#' + content.treeId + '_button').click(
											function() {
												tree._toggle();
											});
									$('#' + content.treeId + '_refresh').click(
											function() {
													var onSuccess = function(event, treeId, treeNode, msg){
														var values = $("input[type='hidden'][data-tree-id='"+treeId+"']").val();
														var zTree = $.fn.zTree.getZTreeObj(treeId);
														var ids = values.split(",");
														var names=[];
														for (i in ids) {
															var c_node = zTree.getNodeByParam("id",
																ids[i], null);
															zTree.checkNode(c_node, true, true);
															names.push(c_node.name);
														}
														$("[data-text-id='" + treeId + "']")
														.val(names);
													};
													tree.reload({
														onAsyncSuccess :　onSuccess
													});
											});
								}
								if (content.type == 'htmlEditor') {
									$('#' + that._form_id).append(
											that._getHtmlEditor(content));
									var editor = that.$K.create('#'+content.id, {
										uploadJson : dm_root+'/KE/file_upload',
										fileManagerJson : dm_root+'/KE/file_manager',
										height : '400px;',
										allowFileManager : true,
										afterBlur : function() {
											this.sync();
										}
									});
									that._editor[content.id] = editor;
								}
							});
		},
		// 初始按钮
		_initButtons : function() {
			var that = this;
			var str = '<div class="form-actions" id="' + that._form_id
					+ '_action" ></div>';
			$('#' + that._form_id).append(str);
			if (this._showSubmit) {
				that._initSubmit();
			}
			if (this._form_showReset) {
				that._initReset();
			}
			if (that._buttons != undefined) {
				$.each(that._buttons, function(index, content) {
					if (content.type == 'button') {
						that._initButton(that._form_id, content);
					}
				});
			}
		},
		// 初始提交按钮
		_initSubmit : function() {
			var that = this;
			var button;
			if (this._isValidate) {
				button = $('<button type="submit" class="btn green">'
						+ this._form_submitText + '</button>');
				$('#' + this._form_id + '_action').append(button);
				$('#' + this._form_id + '_action').append("&nbsp;");
			} else {
				if (this._form_ajaxSubmit) {
					button = $('<button type="button" class="btn green">'
							+ this._form_submitText + '</button>');
				} else {
					button = $('<button type="submit" class="btn green">'
							+ this._form_submitText + '</button>');
				}
				$('#' + this._form_id + '_action').append(button);
				$('#' + this._form_id + '_action').append("&nbsp;");
				if (this._form_ajaxSubmit) {
					button.click(function() {
						$.ajax({
							type : that._form_method,
							url : that._form_action,
							data : $('#' + that._form_id).serialize(),
							dataType : "json",
							success : that._form_ajaxSuccess,
							error : function(data) {
								alert("异步提交表单错误.");
							}
						});
					});
				}
			}

		},
		// 初始重置按钮
		_initReset : function() {
			var button = $('<button type="reset" class="btn grey">'
					+ this._form_resetText + '</button>');
			$('#' + this._form_id + '_action').append(button);
			$('#' + this._form_id + '_action').append("&nbsp;");
		},
		// 初始按钮
		_initButton : function(form_id, data) {
			var button = $('<button type="button" class="btn blue">'
					+ data.text + '</button>');
			$('#' + form_id + '_action').append(button);
			$('#' + form_id + '_action').append("&nbsp;");
			if (typeof (data.handle) != "undefined") {
				var func = data.handle;
				button.click(func);
			}
		},
		// text类型渲染
		_getText : function(element_data) {
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '6';
			if (typeof (element_data.span) != "undefined") {
				span = element_data.span;
			}
			var value = '';
			if (typeof (element_data.value) != "undefined") {
				value = element_data.value;
			}
			str += '<div class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}
				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			str += '<input type="text" name="' + element_data.name
					+ '" value="' + value + '" id="' + element_data.id + '" '
					+ validate + ' class="span' + span + ' m-wrap">';
			if (element_data.detail != undefined) {
				str += '<span class="help-inline">' + element_data.detail
						+ '</span>';
			}
			str += '</div>';
			str += '</div>';
			return str;
		},
		// hidden类型渲染
		_getHidden : function(element_data) {
			var value = '';
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			var str = '<input type="hidden" name="' + element_data.name
					+ '" id="' + element_data.id + '"  value="' + value + '">';
			return str;
		},
		// password类型渲染
		_getPassword : function(element_data) {
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '6';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			var value = '';
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			str += '<div class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			str += '<input type="password" name="' + element_data.name
					+ '" id="' + element_data.id + '" ' + validate
					+ ' class="span' + span + ' m-wrap" value="' + value + '">';
			if (element_data.detail != undefined) {
				str += '<span class="help-inline">' + element_data.detail
						+ '</span>';
			}
			str += '</div>';
			str += '</div>';
			return str;
		},
		// textarea类型渲染
		_getTextarea : function(element_data) {
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '6';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			var value = '';
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			str += '<div class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			str += '<textarea class="span' + span + ' m-wrap" name="'
					+ element_data.name + '" id="' + element_data.id + '" '
					+ validate + ' >' + value + '</textarea>';
			if (element_data.detail != undefined) {
				str += '<span class="help-block">' + element_data.detail
						+ '</span>';
			}
			str += '</div>';
			str += '</div>';
			return str;
		},
		// 日期控件渲染
		_getDatepicker : function(element_data) {
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '2';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			var value = '';
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			str += '<div class="controls">';
			var istime = false;
			if (element_data.isTime != undefined) {
				istime = element_data.isTime;
			}
			var format = "YYYY-MM-DD hh:mm:ss";
			if (element_data.format != undefined) {
				format = element_data.format;
			}
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			str += '<input data-type="datetime" type="text" class="span' + span
					+ ' m-wrap layer-date" name="' + element_data.name
					+ '" id="' + element_data.id
					+ '" onclick="laydate({istime: ' + istime + ' , format:\''
					+ format + '\'})" ' + validate + '>';
			str += '<button type="button" onclick="laydate({istime :' + istime
					+ ', format:\'' + format + '\', elem: \'#'
					+ element_data.id + '\'});" class="btn green">选择</button>';
			if (element_data.detail != undefined) {
				str += '<span class="help-inline">' + element_data.detail
						+ '</span>';
			}
			str += '<div id="' + element_data.name + '_error"></div>';
			str += '</div>';
			str += '</div>';

			return str;
		},
		// 文件控件渲染
		_getFile : function(element_data) {
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '3';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			var value = '';
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			str += '<div id="' + element_data.id
					+ '_controls" class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			str += ('<div class="fileupload fileupload-new" data-provides="fileupload">'
					+ '<div class="input-append">'
					+ '<div class="uneditable-input">'
					+ '<span id="'
					+ element_data.id
					+ '_span" class="fileupload-preview"></span></div>'
					+ '<span class="btn btn-file">'
					+ '<span class="fileupload-new">选择文件</span>'
					+ '<span class="fileupload-exists">更换</span>'
					+ '<input data-type="file" type="file" name="'
					+ element_data.name + '" id="' + element_data.id + '" ');
			if (!element_data.isAjaxUpload) {
				str += validate;
			}
			str += (' class="default"/>'
					+ '</span><a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除</a>'
					+ '</div>');
			if (element_data.isAjaxUpload) {
				str += '<button type="button" id="' + element_data.id
						+ '_button" class="btn green"> 上 传 </button>';
			}
			str += '</div>';
			str += '<div id="' + element_data.name + '_error"></div>';
			if (element_data.detail != undefined) {
				str += '<span class="help-inline">' + element_data.detail
						+ '</span>';
			}
			str += '<div id="' + element_data.name + '_error"></div>';
			str += '</div>';
			str += '</div>';
			return str;
		},
		// 树形控件渲染
		_getTree : function(element_data) {
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '4';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			var value = '';
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			str += '<div id="' + element_data.treeId
					+ '_controls" class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			str += '<span><input data-text-id="'+element_data.treeId+'"  data-text="' + element_data.hiddenId
					+ '" type="text" readonly="readonly" name="'
					+ element_data.name + '" id="' + element_data.id + '" '
					+ validate + ' class="span' + span + ' m-wrap">';
			str += '<input data-hidden="true" data-tree-id="'
					+ element_data.treeId + '" type="hidden" name="'
					+ element_data.hiddenName + '" id="'
					+ element_data.hiddenId + '"> ';
			str += '&nbsp;<button id="' + element_data.treeId
					+ '_button" type="button" class="btn green">'
					+ '显示/隐藏</button>&nbsp;<button id="' + element_data.treeId
					+ '_refresh" type="button" class="btn green">'
					+ '刷新</button></span>';
			if (element_data.detail != undefined) {
				str += '<span class="help-inline">' + element_data.detail
						+ '</span>';
			}
			str += '</div>';
			str += '</div>';

			return str;
		},
		// 展示域渲染
		_getDisplay : function(element_data) {
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '8';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			var value = '';
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			str += '<div class="controls">';
			str += '<span class="text" name="' + element_data.name + '" id="'
					+ element_data.id + '">' + value + '</span>';
			str += '</div></div>';

			return str;
		},
		// checkbox渲染
		_getCheckboxs : function(items, validate) {
			var str = '';
			var name = '';
			$.each(items, function(index, content) {
				var checked = "";
				if (content.checked != undefined) {
					if (content.checked) {
						checked = 'checked="checked"';
					}
				}
				str += '<label class="checkbox">';
				str += '<input data-type="checkbox" type="checkbox" name="'
						+ content.name + '" value="' + content.value + '" '
						+ validate + ' ' + checked + '>' + content.text
						+ '</label>';
				name = content.name;
			});
			return str;
		},
		// ajax异步加载checkbox
		_getAjaxCheckboxs : function(items, validate) {
			var str = '';
			var name = '';
			$.each(items, function(index, content) {
				var checked = "";
				if (content.checked != undefined) {
					if (content.checked) {
						checked = 'checked="checked"';
					}
				}
				str += '<label class="checkbox">';
				str += '<input data-type="checkbox type="checkbox" name="'
						+ content.name + '" value="' + content.value + '" '
						+ validate + ' ' + checked + '>' + content.text
						+ '</label>';
				name = content.name;
			});
			return str;
		},
		// checkbox组渲染
		_getCheckboxGroup : function(element_data) {
			var that = this;
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '6';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			str += '<div id="' + element_data.id
					+ '" data-type="checkbox" class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			if (element_data.items != undefined) {
				var items = element_data.items;
				str += this._getCheckboxs(items, validate);
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
					var urlCheckboxs = that._getAjaxCheckboxs(urlItems,
							validate);
					$("#" + element_data.id).find('.error')
							.before(urlCheckboxs);
				});
			}
			if (element_data.detail != undefined) {
				str += '<label for="' + element_data.items[0].name
						+ '" class="inline">' + element_data.detail
						+ '</label>';
			}
			str += '<div id="' + element_data.items[0].name + '_error"></div>';
			str += '</div>';
			str += '</div>';

			return str;
		},
		// radio渲染
		_getRadios : function(items, validate) {
			var str = '';
			var name = '';
			$.each(items, function(index, content) {
				var checked = "";
				if (content.checked != undefined) {
					if (content.checked) {
						checked = 'checked="checked"';
					}
				}
				str += '<label class="radio">';
				str += '<input data-type="radio" type="radio" name="'
						+ content.name + '" value="' + content.value + '"  '
						+ validate + ' ' + checked + '>' + content.text
						+ '</label>';
				name = content.name;
			});
			return str;
		},
		// ajax加载radio
		_getAjaxRadios : function(items, validate) {
			var str = '';
			var name = '';
			$.each(items, function(index, content) {
				var checked = "";
				if (content.checked != undefined) {
					if (content.checked) {
						checked = 'checked="checked"';
					}
				}
				str += '<label class="radio">';
				str += '<input data-type="radio" type="radio" name="'
						+ content.name + '" value="' + content.value + '"  '
						+ validate + ' ' + checked + '>' + content.text
						+ '</label>';
				name = content.name;
			});
			return str;
		},
		// 渲染raido组
		_getRadioGroup : function(element_data) {
			var that = this;
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '6';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			str += '<div id="' + element_data.id
					+ '" data-type="radio" class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			if (element_data.items != undefined) {
				var items = element_data.items;
				str += this._getRadios(items, validate);
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
					var urlRadios = that._getAjaxRadios(urlItems, validate);
					$("#" + element_data.id).find('.error').before(urlRadios);

				});
			}
			if (element_data.detail != undefined) {
				str += '<label for="' + element_data.items[0].name
						+ '" class="inline">' + element_data.detail
						+ '</label>';
			}
			str += '<div id="' + element_data.items[0].name + '_error"></div>';
			str += '</div>';
			str += '</div>';
			return str;
		},
		// select的option渲染
		_getOptions : function(items, value) {
			var str = '';
			$.each(items, function(index, content) {
				var select = ""
				if (value != "") {
					if (content.value == value) {
						select = 'selected="selected"';
					}
				}
				str += '<option ' + select + ' value="' + content.value + '">'
						+ content.text + '</option>';
			});
			return str;
		},
		// select渲染
		_getSelect : function(element_data) {
			var that = this;
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '6';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			str += '<div class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}

			var value = "";
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			str += '<select class="span' + span + ' m-wrap" name="'
					+ element_data.name + '" id="' + element_data.id + '" '
					+ validate + '>';
			if (element_data.items != undefined) {
				var items = element_data.items;
				str += this._getOptions(items, value);
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
					var urlOptions = that._getOptions(urlItems, value);
					$("#" + element_data.id).append(urlOptions);
				});
			}
			str += '</select>';
			if (element_data.detail != undefined) {
				str += '<span class="help-inline">' + element_data.detail
						+ '</span>';
			}
			str += '</div>';
			str += '</div>';
			return str;

		},
		_getHtmlEditor : function(element_data){
			var str = '<div class="control-group">';
			str += '<label class="control-label">' + element_data.label
					+ '</label>';
			var span = '8';
			if (element_data.span != undefined) {
				span = element_data.span;
			}
			var value = '';
			if (element_data.value != undefined) {
				value = element_data.value;
			}
			str += '<div class="controls">';
			var validate = '';
			if (this._isValidate) {
				if (element_data.rule != undefined) {
					var rule = element_data.rule;
					for ( var key in rule) {
						validate += 'data-rule-' + key + '="' + rule[key]
								+ '" ';
					}
				}

				if (element_data.msg != undefined) {
					var msg = element_data.msg;
					for ( var key in msg) {
						validate += 'data-msg-' + key + '="' + msg[key] + '" ';
					}
				}
			}
			str += '<textarea kindeditor="true" class="span' + span + ' m-wrap" name="'
					+ element_data.name + '" id="' + element_data.id + '" '
					+ validate + ' >' + value + '</textarea>';
			if (element_data.detail != undefined) {
				str += '<span class="help-block">' + element_data.detail
						+ '</span>';
			}
			str += '</div>';
			str += '</div>';
			return str;
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
		_randerDate : function(form_data) {
			var that = this;
			for ( var name in form_data) {
				var ele = $("#" + that._form_id).find("[name='" + name + "']");
				if (ele.is('input[type="text"]')) {
					if (form_data[name] != null) {
						ele.val(form_data[name]);
					}
				} else if (ele.is('input[type="radio"]')) {
					if (form_data[name] != null) {
						for ( var i in ele) {
							if (ele[i].value == form_data[name]) {
								ele[i].checked = true;
							}
						}
					}
				} else if (ele.is('input[type="checkbox"]')) {
					if (form_data[name] != null) {
						var values = form_data[name].split(",");
						for ( var i in ele) {
							if (values.indexOf(ele[i].value) != -1) {
								ele[i].checked = true;
							}
						}
					}
				} else if (ele.is('input[type="hidden"]')) {
					if (ele.attr("data-hidden") == "true") {
						if (form_data[name] != null) {
							ele.val(form_data[name]);
							$('#' + ele.attr("data-tree-id") + '_refresh').trigger("click");
						}
					}else{
						ele.val(form_data[name]);
					}
				}
				if (ele.is('select')) {
					if (form_data[name] != null) {
						ele.val(form_data[name]);
					}
				}
				if (ele.is('textarea')) {
					if (ele.attr("kindeditor") == "true") {
						if (form_data[name] != null) {
							var editor = that._editor[ele.attr("id")];
							editor.html(form_data[name]);
						}
					}else{
						if (form_data[name] != null) {
							ele.html(form_data[name]);
						}
					}
				}
				if (ele.is('span')) {
					if (form_data[name] != null) {
						ele.html(form_data[name]);
					}
				}
			}
			this._uniform();
		},
		_remove : function() {
			this.$element.html('');
		}
	}

	var form = function(options) {
		options = $.extend({}, MetroForm.defaults, options);
		var eles = [];
		this.each(function() {
			var self = this;
			var form = new MetroForm(self, options);
			eles.push(form);
		});
		return eles[0];
	};
	$.fn.extend({
		'MetroForm' : form
	});
})(jQuery, window, document);