;(function ( $, window, document, undefined ){
	var MetroLayout = function(options){
		this._content = "";
		this.$content = new Object();
		this.$dialog = new Object();
		this._options = options;
		SetAttribute(options,this);
		this._init();
	};
	var SetAttribute = function(options,that){
		that._contentId = options.contentId;
		that._title = options.title;
		that._width = options.width;
		that._contentWidth = options.width-2;
		that._height = options.height;
		that._contentHeight = options.height-50;
		that._max = options.max;
		that._min = options.min;
		that._lock = options.lock;
	}
	MetroLayout.defaults = {
		contentId : "",
		title : "弹窗",
		width : 1000,
		height : 600,
		max : false,
		min : false,
		lock : true
	};
	MetroLayout.prototype = {
		close : function(){
			this.$dialog.close();
		},
		_init : function(){
			this._getBox();
			this._dialog();
			this.$content = $("#"+this._contentId);
			this._handleScrollers();
		},
		_getBox : function(){
			var content='';
			content+=('<div style="width:'+this._contentWidth+'px;" class="row-fluid">');
			content+=('<div class="span12">');
			content+=('<div id="'+this._contentId+'_box" class="portlet box green">');
			content+='<div class="portlet-title"><div class="caption">'
					+this._title+'</div></div>';
			content+=('<div  style="height:'+this._contentHeight+'px;overflow-y:auto;" class="portlet-body form">');
			content+=('<div id="'+this._contentId+'">');
			content+=('</div></div></div></div></div>');
			this._content = content;
		},
		_dialog :function(){
			var that = this;
			var dialog = $.dialog({
				title : '',
				width : that._width,
				height : that._height,
				max : that._max,
				min : that._min,
				lock : that._lock,
				content : this._content
			});
			this.$dialog = dialog;
		},
		_handleScrollers : function(){
		}
	};
	var layout = function(options){
		options = $.extend({}, MetroLayout.defaults, options);
		var box = new MetroLayout(options);
		return box;	
	};

	$.extend({
		'MetroLayout':layout
	});
})(jQuery, window,document);