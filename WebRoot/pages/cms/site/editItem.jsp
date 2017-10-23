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
<title>站点管理-修改</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/media/css/select2_metro.css" />

<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/media/css/chosen.css" />

<!-- END PAGE LEVEL STYLES -->

</head>
<!-- END HEAD -->

	<!-- BEGIN HEADER -->
	<%@include file="../../admin/include/head.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<%@include file="../../admin/include/sidebar.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<h3 class="page-title">
							表单 <small>修改站点</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="${root}/cms/site/listItems">站点列表</a> <i
								class="icon-angle-right"></i>
							</li>
							<li><a>表单</a>
							</li>
						</ul>
						</div>
					</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>表单内容
								</div>
							</div>

							<div class="portlet-body form">

								<!-- BEGIN FORM-->

								<form action="${root}/cms/site/updateItem" method="post" id="format_form" class="form-horizontal">
									<div class="alert alert-error hide">
										<button class="close" data-dismiss="alert"></button>
										表单填写不正确，请仔细核查。
									</div>
									<div class="alert alert-success hide">
										<button class="close" data-dismiss="alert"></button>
										提交成功，等待跳转！
									</div>
									<input type="hidden" name="siteId" value="${item.siteId}"/>
									<div class="control-group">
										<label class="control-label">站点名称<span
											class="required">*</span>
										</label>
										<div class="controls">
											<input type="text" name="siteName" value="${item.siteName}" class="span6 m-wrap" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">域名<span
											class="required">*</span>
										</label>
										<div class="controls">
											<input type="text" name="domain" value="${item.domain}" class="span6 m-wrap" />
										</div>
									</div>
									<div class="form-actions">
										<button type="submit" class="btn green">提交</button>
										<button type="button" onclick="window.history.back();" class="btn">返回</button>
									</div>
								</form>
								<!-- END FORM-->
							</div>

						</div>

					</div>
				</div>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	<!-- BEGIN FOOTER -->
	<%@include file="../../admin/include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../../admin/include/js.jsp"%>
	
	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>

	<script type="text/javascript" src="<%=basePath%>themes/media/js/additional-methods.min.js"></script>

	<script type="text/javascript" src="<%=basePath%>themes/media/js/select2.min.js"></script>

	<script type="text/javascript" src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->
	
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
                    siteName: {
                        required: true
                    },
                    domain: {
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	siteName: {
                        required: "请输入站点名称"
                    },
                    domain: {
                        required: "请输入域名"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
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
	</script>

	<!-- END JAVASCRIPTS -->
</html>
