;
(function($, window, document, undefined) {
	var MetroDropdown = function(options) {
		this._options = options;
		SetAttribute(options, this);
		this._init();
	};
	var SetAttribute = function(options, that) {
		if (options.type != undefined) {
			that._type = options.type;
		} else {
			return;
		}
		if(options.totalUrl!=undefined){
			that._totalUrl = options.totalUrl;
		}
		if(options.dataUrl!=undefined){
			that._dataUrl = options.dataUrl;
		}else{
			if(options.data!=undefined){
				that._data = options.data;
			}
		}
	};
	MetroDropdown.defaults = {
		type : undefined,
		data : undefined,
		dataUrl : undefined
	};
	MetroDropdown.prototype = {
		_init : function() {
			this._render();
		},
		_render : function() {
			var that = this;
			var li = $('<li class="dropdown"></li>');
			$("#top_nav").prepend(li);
			this.$element = li;
			var a = $('<a href="#" data-url="" class="dropdown-toggle" data-toggle="dropdown"></a>');
			if (this._type == "inbox") {
				a.append('<i class="icon-envelope"></i>');
			}
			var badge = $('<span class="badge"></span>');
			this.$badge = badge;
			a.append(badge);
			this.$element.append(a);
			var list = $('<ul class="dropdown-menu extended ' + this._type
					+ '"></ul>');
			this.$element.append(list);
			this.$list = list;
			a.click(function(){
				if(that._dataUrl!=undefined){
					that._loadRemoteList();
				}else{
					that._loadLocalList();
				}
			});
			
			this._getTotal();
			
		},
		_timerRefresh : function(){
			var that = this;
			this.$badge.everyTime("5s",function(){
				var span = $(this);
				$.post(that._totalUrl, {}, function(res) {
					span.text(res);
				});
			});
		},
		_getTotal : function(){
			var that = this;
			$.post(that._totalUrl, {}, function(res) {
				that.$badge.text(res);
				that._timerRefresh();
			});
		},
		_loadRemoteList : function(){
			var that = this;
			$.post(this._dataUrl, {}, function(res) {
				if (typeof res == "object") {
					that._data = res;
				} else {
					var json = eval("(" + res + ")");
					that._data = json;
				}
				that.$list.html("");
				if(that._type=="inbox"){
					that._renderInboxList();
				}
			});
		},
		_loadLocalList : function(){
			this.$list.html("");
			if(this._type=="inbox"){
				this._renderInboxList();
			}
		},
		_renderInboxList : function(){
			var that = this;
			if(this._data!=null){
				$.each(this._data, function(index, content) {
					var li = $('<li></li>');
					var a = $('<a href="'+content.link+'"></a>');
					li.append(a);
					var subject = $('<span class="subject"></span>');
					var from = content.from;
					if(from.length>15){
						from=from.substring(0,15)+"...";
					}
					subject.append('<span class="from" title="'+content.from+'">'+from+'</span>');
					subject.append('<span class="time">'+content.time+'</span>');
					a.append(subject);
					var attach = '';
					if(content.attch){
						attch = '&nbsp;<i class="icon-paper-clip"></i>';
					}
					a.append('<span class="message">'+content.message+attch+'</span>');
					that.$list.append(li);
				});
			}
			that.$list.append('<li class="external"><a href="/DM/message/messageCenter">查看所有<i class="m-icon-swapright"></i></a></li>');
		}
	};
	var dropdown = function(options) {
		options = $.extend({}, MetroDropdown.defaults, options);
		var dropDown = new MetroDropdown(options);
		return dropDown;
	};
	$.extend({
		'MetroDropdown' : dropdown
	});
})(jQuery, window, document);