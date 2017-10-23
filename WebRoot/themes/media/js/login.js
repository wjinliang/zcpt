var Login = function () {
    
    return {
        //main function to initiate the module
        init: function () {
        	
           $('.login-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            rules: {
	                j_username: {
	                    required: true
	                },
	                j_password: {
	                    required: true
	                },
	                j_captcha:{
	                	required: true
	                }
	            },

	            messages: {
	            	j_username: {
	                    required: "请输入登录名。"
	                },
	                j_password: {
	                    required: "请输入密码。"
	                },
	                j_captcha: {
	                    required: "请输入验证码。"
	                }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   
	                //$('#error', $('.login-form')).show();
	            },

	            highlight: function (element) { // hightlight error inputs
	                $(element)
	                    .closest('.control-group').addClass('error'); // set error class to the control group
	            },

	            success: function (label) {
	                label.closest('.control-group').removeClass('error');
	                label.remove();
	            },

	            errorPlacement: function (error, element) {
	                error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
	            },

	            submitHandler: function (form) {
	            	submitLogin();
	            }
	        });

	        $('.login-form input').keypress(function (e) {
	            if (e.which == 13) {
	                if ($('.login-form').validate().form()) {
	                	submitLogin();
	                }
	                return false;
	            }
	        });

	        $('.forget-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            ignore: "",
	            rules: {
	                email: {
	                    required: true,
	                    email: true
	                }
	            },

	            messages: {
	                email: {
	                    required: "请输入邮箱."
	                }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   

	            },

	            highlight: function (element) { // hightlight error inputs
	                $(element)
	                    .closest('.control-group').addClass('error'); // set error class to the control group
	            },

	            success: function (label) {
	                label.closest('.control-group').removeClass('error');
	                label.remove();
	            },

	            errorPlacement: function (error, element) {
	                error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
	            },

	            submitHandler: function (form) {
	                submitForget();
	            }
	        });

	        $('.forget-form input').keypress(function (e) {
	            if (e.which == 13) {
	                if ($('.forget-form').validate().form()) {
	                    window.location.href = "index.html";
	                }
	                return false;
	            }
	        });

	        jQuery('#forget-password').click(function () {
	            jQuery('.login-form').hide();
	            jQuery('.forget-form').show();
	        });

	        jQuery('#back-btn').click(function () {
	            jQuery('.login-form').show();
	            jQuery('.forget-form').hide();
	        });

	        $('.register-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            ignore: "",
	            rules: {
	                loginname: {
	                    required: true,
	                    remote: {
	                        type: "post",
	                        url: "/DM/checkunique",
	                        data: {
	                        	param: function() {
	                                return $("#loginname").val();
	                            },
	                            name:"loginname"
	                        },
	                        dataType: "html",
	                        dataFilter: function(data, type) {
	                            if (data == "y")
	                                return true;
	                            else
	                                return false;
	                        }
	                    }
	                },
	                password: {
	                    required: true
	                },
	                rpassword: {
	                    equalTo: "#password"
	                },
	                email: {
	                    required: true,
	                    email: true,
	                    remote: {
	                        type: "post",
	                        url: "/DM/checkunique",
	                        data: {
	                        	param: function() {
	                                return $("#email").val();
	                            },
	                            name:"email"
	                        },
	                        dataType: "html",
	                        dataFilter: function(data, type) {
	                            if (data == "y")
	                                return true;
	                            else
	                                return false;
	                        }
	                    }
	                },
	                tnc: {
	                    required: true
	                }
	            },

	            messages: { // custom messages for radio buttons and checkboxes
	                tnc: {
	                    required: "请点击同意协议。"
	                },
	                loginname　: {
	                	required: "请填写登录名。",
	                	remote: "登录名已被注册。"
	                },
	                password　: {
	                	required: "请填写登录密码。"
	                },
	                rpassword　: {
	                	equalTo: "两次密码不一致。"
	                },
	                email　: {
	                	required: "请填写邮箱。",
	                	email: "请输入正确的邮箱格式",
	                	remote: "邮箱已被注册。"
	                }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   

	            },

	            highlight: function (element) { // hightlight error inputs
	                $(element).closest('.help-inline')
					.removeClass('ok'); // display OK icon
	                $(element).closest('.control-group').removeClass(
					'success').addClass('error'); // set error class to the control group
	            },

	            success: function (label) {
	            	label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
					.closest('.control-group').removeClass('error')
							.addClass('success'); // set success class to the control group
	            },

	            errorPlacement: function (error, element) {
	                error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
	            },

	            submitHandler: function (form) {
	            	submitRegiest();
	            }
	        });

	        jQuery('#register-btn').click(function () {
	            jQuery('.login-form').hide();
	            jQuery('.register-form').show();
	        });

	        jQuery('#register-back-btn').click(function () {
	            jQuery('.login-form').show();
	            jQuery('.register-form').hide();
	        });
        }

    };

}();