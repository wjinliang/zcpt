<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<title>菜单管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->

<body>
	<!-- BEGIN HEADER -->
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green" >
							<div class="portlet-title">
							表单
							</div>
							<div class="portlet-body">
							<form action="${root}/usermenu/save" method="post" id="format_form" class="form-horizontal">
								<div class="alert alert-error hide">

										<button class="close" data-dismiss="alert"></button>

										表单填写不正确，请仔细核查。

								</div>

								<div class="alert alert-success hide">

										<button class="close" data-dismiss="alert"></button>

										提交成功，等待跳转！

								</div>
									<input type="hidden" name="id" value="${userMenu.id}"/>
									<input type="hidden" name="parentid" value="${parentid}"/>

									<div class="control-group">

										<label class="control-label">菜单名<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" name="name"  data-required="1"
												value="${userMenu.name}" class="span10 m-wrap" />

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">菜单路径<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" name="url"  data-required="1"
												value="${userMenu.url}" class="span10 m-wrap" />

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">是否显示<span class="required">*</span></label>

										<div class="controls">

											<label class="radio line">

											<input type="radio" name="isShow" value="1"  
											<c:if test="${userMenu.isShow=='1'}">  checked="checked" </c:if>
											/>

											是

											</label>

											<label class="radio line">

											<input type="radio" name="isShow" value="0"  
											<c:if test="${userMenu.isShow=='0'}">  checked="checked" </c:if>
											/>

											否

											</label> 

											<div id="enabled_error"></div>

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">图标
										</label>

										<div class="controls">

											<input type="text" name="icon" data-required="1"
												value="${userMenu.icon}" class="span10 m-wrap" />

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">排序号<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" name="seq" value="${userMenu.seq}" data-required="1"
												value="${userMenu.seq}" class="span10 m-wrap" />

										</div>

									</div>
									
									<div class="control-group">

										<label class="control-label">描述
										</label>

										<div class="controls">

											<input type="text" name="detail" 
												value="${userMenu.detail}" class="span10 m-wrap" />

										</div>

									</div>



									<div class="form-actions">

										<button type="submit" class="btn green">提交</button>

										<button type="button" onclick="closewin()" class="btn">关闭</button>

									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	</div>
	
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER -->
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../include/js.jsp"%>
	<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=basePath%>themes/media/js/additional-methods.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>
	<script>
		jQuery(document).ready(function() {
			var form = $('#format_form');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    name: {
                        required: true
                    },
					url:{
						 required: true
					},
					isShow:{
						 required: true
					},
					seq:{
						 required: true
					}
                },

                messages: { // custom messages for radio buttons and checkboxes
                    name: {
                        required: "请输入菜单名称"
                    },
					url:{
						 required: "请输入菜单路径"
					},
					isShow:{
						 required: "请选择"
					},
					seq:{
						 required: "请输入排序号"
					}
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.attr("name") == "isShow") { // for uniform checkboxes, insert the after the given container
                        error.addClass("no-left-padding").insertAfter("#enabled_error");
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavoir
                    }
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		function closewin(){
			var api = frameElement.api, W = api.opener; // api.opener 为载加lhgdialog.min.js文件的页面的window对象
			api.close();
		}
	</script>

	</body>
</html>
