;(function ( $, window, document, undefined ){
	var MetroModal = function(element,options){
		this.$element = $(element);
		this._element = element;
		this._modal_id = options.id;
		this._title = options.title;
		this.$modal = new Object();
		this.$body = new Object();
		if(options.items!=undefined){
			this.items = options.items;
		}
		this._init();
	};
	MetroModal.defaults = {
	};
	MetroModal.prototype = {
		_init : function(){
			this._render();
		},
		_show : function(){
			this.$modal.modal("show");
		},
		_hide : function(){
			this.$modal.modal("hide");
		},
		_remove : function(){
			this.$modal.remove();
		},
		_render : function(){
			var modal = $('<div class="modal fade" id="'+this._modal_id+'" tabindex="-1" role="dialog"'
				+'aria-labelledby="'+this._modal_id+'Label" aria-hidden="true"><div>');
			var dialog = $('<div class="modal-dialog"></div>');
			var content = $('<div class="modal-content"></div>');
			var header = $('<div class="modal-header"></div>');
			var close = $('<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>');
			var title = $('<h4 class="modal-title" id="myModalLabel">'+this._title+'</h4>');
			header.append(close);
			header.append(title);
			var body = $('<div id="'+this._modal_id+'_body" class="modal-body"></div>');
			this.$body = body;
			var footer = $('<div class="modal-footer"></div>');
			content.append(header);
			content.append(body);
			content.append(footer);
			dialog.append(content);
			modal.append(dialog);
			this.$modal = modal;
		}
	};
	var fun = function(options){
		options = $.extend({}, MetroModal.defaults, options);
		var eles = [];
		this.each(function() {
			var self = this;
			var modal = new MetroModal(self,options);
			eles.push(modal);
		});
		return eles[0];	
	};

	$.fn.extend({
		'MetroModal':fun
	});
})(jQuery, window,document);