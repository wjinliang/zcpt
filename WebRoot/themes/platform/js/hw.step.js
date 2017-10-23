;(function ( $, window, document, undefined ){
	var HwStep = function(element,options){
		//jquery元素对象
		this.$element = $(element);
		//js元素对象
		this._element = element;
		//元素id
		this._elementId = this._element.id;
		
		this.$step_content = new Object();
		
		if(options.box!=undefined){
			//box元素
			this._box = options.box;
		}
		
		this._steps = options.steps;
		
		this._onStepChanging = options.onStepChanging;
		this._onFinished = options.onFinished;
		this._init();
	};
	HwStep.defaults = {
		onStepChanging : function(event, currentIndex, newIndex) {
			var form = $(this).find("form");
        	alert("当前form的action--"+form[currentIndex].action);
			return true;
		},
		onFinished : function(event, currentIndex) {
			return true;
		}
	};
	HwStep.prototype = {
			_init : function(){
				this.renderBox();
				this.renderStepContent();
				this._initSteps();
			},
			_initSteps : function(){
				this.$step_content.steps({
		            bodyTag: "fieldset",
		            onStepChanging: this._onStepChanging,
		            onFinished: this._onFinished
		        });
			},
			renderBox : function(){
				if(this.boxInited){
					return;
				}
				var ibox = this.$element;
				ibox.addClass('ibox');
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
				var content = $('<div class="ibox-content wizard-big"></div>');
				ibox.append(title);
				ibox.append(content);
				this.$element.append(ibox);			
				this.$step_content = content;
				this.boxInited = true;
			},
			renderStepContent : function(){
				var that = this;
				$.each(that._steps,function(index,content){
					var h1 = $('<h1>'+content.title+'</h1>');
					var fieldset = $('<fieldset></fieldset>');
					var h2 = $('<h2>'+content.h2+'</h2>');
					fieldset.append(h2);
					var row = $('<div class="row"></div>');
					var form = $('<form class="form-horizontal" id="'+content.form.id+'" name="'+content.form.name+'" method = "'+content.form.method+'" action="'+content.form.action+'"></form>');
					$.each(content.form.items,function(index,content){
						if(content.type=='text'){
							form.append(that.getText(content));
						}
						if(content.type=='hidden'){
							form.append(that.getHidden(content));
						}
						if(content.type=='password'){
							form.append(that.getPassword(content));
						}
						if(content.type=='textarea'){
							form.append(that.getTextarea(content));
						}
						if(content.type=='display'){
							form.append(that.getDisplay(content));
						}
						if(content.type=='checkboxGroup'){
							form.append(that.getCheckboxGroup(content));
						}
						if(content.type=='radioGroup'){
							form.append(that.getRadioGroup(content));
						}
						if(content.type=='select'){
							form.append(that.getSelect(content));
						}
					});
					row.append(form);
					fieldset.append(row);
					that.$step_content.append(h1);
					that.$step_content.append(fieldset);
				});
				
			},
			getText : function(element_data){
				var str= '<div class="form-group">';
				str+='<label class="col-sm-2 control-label">'+element_data.label+'</label>';
				var span = '10';
				if(typeof(element_data.span) != "undefined"){
					span = element_data.span;
				}
				var value = '';
				if(typeof(element_data.value) != "undefined"){
					value = element_data.value;
				}
				str+='<div class="col-sm-'+span+'">';
				str+='<input type="text" name="'+element_data.name+'" value="'+value+'" id="'+element_data.id+'" class="form-control">';
				str+='</div></div>';
				str+='<div class="hr-line-dashed"></div>';
				return str;
			},
			getHidden : function(element_data){	
				var value = '';
				if(element_data.value != undefined){
					value = element_data.value;
				}
				var str='<input type="hidden" name="'+element_data.name+'" id="'+element_data.id+'"  value="'+value+'">';
				return str;
			},
			getPassword : function(element_data){
				var str= '<div class="form-group">';
				str+='<label class="col-sm-2 control-label">'+element_data.label+'</label>';
				var span = '10';
				if(element_data.span != undefined){
					span = element_data.span;
				}
				var value = '';
				if(element_data.value != undefined){
					value = element_data.value;
				}
				str+='<div class="col-sm-'+span+'">';
				str+='<input type="password" name="'+element_data.name+'" id="'+element_data.id+'" class="form-control" value="'+value+'">';
				str+='</div></div>';
				str+='<div class="hr-line-dashed"></div>';
				return str;
			},
			getTextarea : function(element_data){
				var str= '<div class="form-group">';
				str+='<label class="col-sm-2 control-label">'+element_data.label+'</label>';
				var span = '10';
				if(element_data.span != undefined){
					span = element_data.span;
				}
				var value = '';
				if(element_data.value != undefined){
					value = element_data.value;
				}
				str+='<div class="col-sm-'+span+'">';
				str+='<textarea class="form-control" name="'+element_data.name+'" id="'+element_data.id+'" >'+value+'</textarea>';
				str+='</div></div>';
				str+='<div class="hr-line-dashed"></div>';
				return str;
			},
			getDisplay : function(element_data){
				var str= '<div class="form-group">';
				str+='<label class="col-sm-2 control-label">'+element_data.label+'</label>';
				var span = '10';
				if(element_data.span != undefined){
					span = element_data.span;
				}
				var value = '';
				if(element_data.value != undefined){
					value = element_data.value;
				}
				str+='<div class="col-sm-'+span+'">';
				str+='<p class="form-control-static">'+value+'</p>';
				str+='</div></div>';
				str+='<div class="hr-line-dashed"></div>';
				return str;
			},
			getCheckboxs : function(items){
				var str = '';
				$.each(items,function(index,content){
					str+='<div class="checkbox"><label>';
					str+='<input type="checkbox" name="'+content.name+'" value="'+content.value+'">'+content.text+'</label></div>';
				});
				return str;
			},
			getCheckboxGroup : function(element_data){
				var str= '<div class="form-group">';
				str+='<label class="col-sm-2 control-label">'+element_data.label+'</label>';
				var span = '10';
				if(element_data.span != undefined){
					span = element_data.span;
				}	
				str+='<div class="col-sm-'+span+'">';
			
				if(element_data.items != undefined){
					var items = element_data.items;
					str+=this.getCheckboxs(items);
				}
				str+='</div></div>';
				str+='<div class="hr-line-dashed"></div>';
				return str;
			},
			getRadios : function(items){
				var str = '';
				$.each(items,function(index,content){
					str+='<div class="radio"><label>';
					str+='<input type="radio" name="'+content.name+'" value="'+content.value+'">'+content.text+'</label></div>';
				});
				return str;
			},
			getRadioGroup : function(element_data){
				var str= '<div class="form-group">';
				str+='<label class="col-sm-2 control-label">'+element_data.label+'</label>';
				var span = '10';
				if(element_data.span != undefined){
					span = element_data.span;
				}		
				str+='<div class="col-sm-'+span+'">';
				if(element_data.items != undefined){
					var items = element_data.items;
					str+=this.getRadios(items);
				}
				str+='</div></div>';
				str+='<div class="hr-line-dashed"></div>';
				return str;
			},
			getOptions : function(items){
				var str = '';
				$.each(items,function(index,content){
					str+='<option value="'+content.value+'">'+content.text+'</option>';
				});
				return str;
			},
			getSelect : function(element_data){
				var str= '<div class="form-group">';
				str+='<label class="col-sm-2 control-label">'+element_data.label+'</label>';
				var span = '10';
				if(element_data.span != undefined){
					span = element_data.span;
				}	
				str+='<div class="col-sm-'+span+'">';
				str+='<select class="form-control m-b" name="'+element_data.name+'" id="'+element_data.id+'">';
				if(element_data.items != undefined){
					var items = element_data.items;
					str+=this.getOptions(items);
				}		
				str+='</select></div></div>';
				str+='<div class="hr-line-dashed"></div>';
				return str;
			}
	};
	//为jquery元素实例添加实例方法
	var fun = function(options){
		options = $.extend({}, HwStep.defaults, options);
		var eles = [];
		this.each(function() {
			var self = this;
			var step = new HwStep(self,options);
			eles.push(HwStep);
		});
		return eles[0];	
	};
	$.fn.extend({
		'HwStep':fun
	});
})(jQuery, window,document);