;
(function($, window, document, undefined) {
	var MetroFormTree = function(element, options) {
		this.$element = $(element);
		this._element = element;
		this._elementId = this._element.id;
		this._options = options;
		SetAttribute(this._options, this);
		this._tree = new Object();
		this.$menu = new Object();
		this._menuId = "";
		this.inited = false;
		this._init();
	};
	var SetAttribute = function(options, that) {
		that._treeId = options.treeId;
		if(options.url!=undefined)
			that._url = options.url;
		if(options.data!=undefined)
			that._data = options.data;
		that._setting = options.setting;
		if(options.onAsyncSuccess!=undefined)
			that._onAsyncSuccess = options.onAsyncSuccess;
	};
	MetroFormTree.defaults = {
		treeId : "demo_tree",
		url : undefined,
		data : undefined,
		setting : {
			check : {
				enable : true
			},
			data : {
				simpleData : {
					enable : true
				}
			},
			async: {
				enable: true,
				autoParam: ["id", "name"]
			}
		}
	};
	MetroFormTree.prototype = {
		reload : function(options){
			var that = this;
			if(options!=undefined){
				this._options = $.extend({}, that._options, options);
				SetAttribute(this._options, this);
				this._init();
			}else{
				this._refresh();
			}
		},
		//初始化
		_init : function() {
			this._render();
			if(this._url!=undefined){
				this._loadUrl();
			}else if(this._data!=undefined){
				this._loadData();
			}else{
				return;
			}
		},
		_refresh : function() {
			var treeObj = $.fn.zTree.getZTreeObj(this._treeId);
			if(this._url!=undefined){
				treeObj.reAsyncChildNodes(null, "refresh");
			}else if(this._data!=undefined){
				treeObj.refresh();
			}else{
				return;
			}
		},
		_render : function() {
			if (this.inited) {
				return;
			}
			var row = $("<span class='row'></span>");
			var menu = $('<div id="'
					+ this._elementId
					+ '_menu" style="relative: absolute;margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;height: 260px;overflow-y: scroll;overflow-x: auto;">');
			var tree = $('<ul id="' + this._treeId + '" class="ztree"></ul>');
			this._menuId = this._elementId + '_menu';
			menu.addClass(this.$element.attr("class").split(" ")[0]);
			menu.append(tree);
			row.append(menu);
			this.$element.closest(".controls").append(row);
			this.$menu = menu;
			this._tree = tree;
			this.inited = true;
		},
		_loadUrl : function() {
			var that = this;
			$.post(this._url, {}, function(res) {
				var data;
				if (typeof res == "object") {
					data = res;
				} else {
					var json = eval("(" + res + ")");
					data = json;
				}
				$.fn.zTree.init(that._tree, that._setting, data);
				var zTree = $.fn.zTree.getZTreeObj(that._treeId);
				zTree.setting.check.chkboxType = { "Y" : "p", "N" : "p" };
				zTree.setting.async.url = that._url;
				zTree.setting.callback.onCheck = function(e, treeId, treeNode) {
					nodes = zTree.getCheckedNodes(true);
					var text = "";
					nodes.sort(function compare(a, b) {
						return a.id - b.id;
					});
					for ( var i = 0, l = nodes.length; i < l; i++) {
						text += nodes[i].name + ",";
					}
					if (text.length > 0)
						text = text.substring(0, text.length - 1);
					that.$element.val(text);

					var v = "";
					for ( var i = 0, l = nodes.length; i < l; i++) {
						v += nodes[i].id + ",";
					}
					if (v.length > 0)
						v = v.substring(0, v.length - 1);
					that.$element.next("input[type='hidden']").val(v);
				};
				if(that._onAsyncSuccess!=undefined){
					var onAs = that._onAsyncSuccess;
					zTree.setting.callback.onAsyncSuccess = function(event, treeId, treeNode, msg){
						onAs(event, treeId, treeNode, msg);
					};
				}
				zTree.reAsyncChildNodes(null, "refresh");
			});
		},
		_loadData : function(){
			$.fn.zTree.init(that._tree, that._setting, this._data);
			var zTree = $.fn.zTree.getZTreeObj(that._treeId);
			zTree.setting.callback.onCheck = function(e, treeId, treeNode) {
				nodes = zTree.getCheckedNodes(true);
				var text = "";
				nodes.sort(function compare(a, b) {
					return a.id - b.id;
				});
				for ( var i = 0, l = nodes.length; i < l; i++) {
					text += nodes[i].name + ",";
				}
				if (text.length > 0)
					text = text.substring(0, text.length - 1);
				that.$element.val(text);

				var v = "";
				for ( var i = 0, l = nodes.length; i < l; i++) {
					v += nodes[i].id + ",";
				}
				if (v.length > 0)
					v = v.substring(0, v.length - 1);
				that.$element.next("input[type='hidden']").val(v);
			};
		},
		_toggle : function(){
			if(this.$menu.is(":visible")){
				this._hideMenu();
			}else{
				this._showMenu();
			}
		},
		_showMenu : function() {
			var that = this;
			var inputObject = this.$element;
			var cityOffset = this.$element.offset();
			this.$menu.slideDown("fast");
		},
		_hideMenu : function() {
			var that = this;
			this.$menu.fadeOut("fast");
		}
	};
	var formTree = function(options) {
		options = $.extend({}, MetroFormTree.defaults, options);
		var eles = [];
		this.each(function() {
			var self = this;
			var tree = new MetroFormTree(self, options);
			eles.push(tree);
		});
		return eles[0];
	};

	var setTreeUrl = function(url) {
		this.each(function() {
			var self = this;
			var treeObj = $.fn.zTree.getZTreeObj(self.id);
			treeObj.setting.async.url = url;
			treeObj.reAsyncChildNodes(null, "refresh");
		});
	};

	$.fn.extend({
		'MetroFormTree' : formTree
	});

	$.fn.extend({
		'refreshFormTree' : setTreeUrl
	});
})(jQuery, window, document);