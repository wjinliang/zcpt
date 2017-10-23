;
(function($, window, document, undefined) {
	var MetroZTree = function(element,options){
		this.$element = $(element);
		this._tree = new Object();
		this._options = options;
		setAttribute(options,this);
		this._inited = false;
		this._init();
	};
	var setAttribute = function(options,that){
		if(options.treeId!=undefined){
			that._treeId = options.treeId;
		}else{
			return;
		}
		that._setting = options.setting;
		if(options.zNodes!=undefined){
			that._zNodes = options.zNodes;
		}else{
			that._zNodes="";
		}
	};
	MetroZTree.defaults = {
		treeId : undefined,
		setting : {
			check : {
				enable : false
			},
			data : {
				simpleData : {
					enable : true
				}
			}
		},
		zNodes : undefined
	};
	MetroZTree.prototype = {
		reload : function(options){
				var that = this;
				if(options!=undefined){
					this._options = $.extend(true,{}, that._options, options);
					SetAttribute(this._options, this);
					this._init();
				}else{
					this._refresh();
				}
		},
		getSelectNode : function(){
			var treeObj = $.fn.zTree.getZTreeObj(this._treeId);
			if(treeObj.getSelectedNodes().length>0){
				return treeObj.getSelectedNodes()[0];
			}else{
				return undefined;
			}
		},
		expandAll : function(boolean){
			var treeObj = $.fn.zTree.getZTreeObj(this._treeId);
			treeObj.expandAll(boolean);
		},
		_init : function(){
			this._render();
			this._treeInit();
			this._inited = true;
		},
		_render : function(){
			if(this.inited){
				return;
			}
			var tree = $('<ul id="'+this._treeId+'" class="ztree"></ul>');
			this.$element.append(tree);
			this._tree = tree;
		},
		_treeInit : function(){
			$.fn.zTree.init(this._tree, this._setting, this._zNodes);
		},
		_refresh : function() {
			var treeObj = $.fn.zTree.getZTreeObj(this._treeId);
			if(this._options.setting.async.enable){
				treeObj.reAsyncChildNodes(null, "refresh");
			}else if(this._data!=undefined){
				treeObj.refresh();
			}else{
				return;
			}
		}
	};
	var metro_function = function(options) {
		options = $.extend(true,{}, MetroZTree.defaults, options);
		var mTree;
		this.each(function() {
			var self = this;
			mTree = new MetroZTree(self,options);
			return false;
		});
		return mTree;
	};
	$.fn.extend({
		'MetroZTree' : metro_function
	});
})(jQuery, window, document);