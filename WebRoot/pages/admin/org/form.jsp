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
<title>组织管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
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
							<form action="${root}/org/save" method="post" id="format_form" class="form-horizontal">
								<div class="alert alert-error hide">

										<button class="close" data-dismiss="alert"></button>

										表单填写不正确，请仔细核查。

								</div>

								<div class="alert alert-success hide">

										<button class="close" data-dismiss="alert"></button>

										提交成功，等待跳转！

								</div>
									<input type="hidden" name="id" value="${org.id}"/>
									<input type="hidden" name="parentid" value="${parentid}"/>
									<input type="hidden" id="appCheckList" name="appCheckList" value="" />
									<div class="control-group">

										<label class="control-label">区划名<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" name="name"  data-required="1"
												value="${org.name}" class="span10 m-wrap" />

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">区划代码<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" name="code"  data-required="1"
												value="${org.code}" class="span10 m-wrap" />

										</div>

									</div>
									
									<div class="control-group">

										<label class="control-label">排序号<span
											class="required">*</span>
										</label>
										<div class="controls">

											<input type="text" name="seq" value="${org.seq}" data-required="1"
												value="${org.seq}" class="span10 m-wrap" />

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
	</body>
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER -->
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../include/js.jsp"%>
	<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
	<script>
		jQuery(document).ready(function() {
			App.handleNavInit("3");
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
					code:{
						 required: true
					},
					seq:{
						 required: true
					}
                },

                messages: { // custom messages for radio buttons and checkboxes
                    name: {
                        required: "请输入组织名称"
                    },
					code:{
						 required: "请输入组织代码"
					},
					seq:{
						 required: "请输入排序号"
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
		function closewin(){
		var api = frameElement.api, W = api.opener; // api.opener 为载加lhgdialog.min.js文件的页面的window对象
		api.close();
		}
	</script>
	<!-- 
	<script>
	$(document).ready(function(){
		$.ajax({
			type:'post',
			url:'${root}/synorg/loadAppInfo',
			data:{
				orgId:${org.id}
			},
			dataType:'html',
			success:function(data) { 
				var app_array = $.parseJSON(data);  // 把字串轉換成 JSON array 
				var html="";
					$.each(app_array, function(index, app) { 
						if(app.status=="1"){
							html+="<td style=\"vertical-align: middle;\"><input type=\"checkbox\" checked=\"checked\" class=\"checkboxes\" name=\"checkboxes\" value=\""+app.appId+"\"/>"+app.appName+"</td>";
						}else{
							html+="<td style=\"vertical-align: middle;\"><input type=\"checkbox\" class=\"checkboxes\" name=\"checkboxes\" value=\""+app.appId+"\"/>"+app.appName+"</td>";
						}
					});
					$("#listApp").html(html);
			}
		});
		});
	function getcheckedids(){
		var ids=[];
		var cbs = document.getElementsByName("checkboxes");
		for(var i = 0 ; i < cbs.length; i++){
			if(cbs[i].checked == true){
				ids.push(cbs[i].value);
			}
		}
		return ids;
		}
	function checkTongBu(){
		var appCheckList=getcheckedids();
		$("#appCheckList").val(appCheckList);
		var height=500;
		var width=600;
		var aa=window.showModalDialog('${root}/synorg/checkTongBu?appCheckList='+appCheckList+'&orgId=${org.id}',window,'dialogHeight='+height+',dialogWidth='+width);
		var api = frameElement.api, W = api.opener; // api.opener 为载加lhgdialog.min.js文件的页面的window对象
		W.refreshorgtree();
		api.close();
	}
	function doTongBu(){
		 $.ajax({
            cache: true,
            type: "POST",
            url:'${root}/synorg/ajaxsave',
            data:$('#format_form').serialize(),// 你的formid
            dataType:'html',
            async: false,
            error: function(request) {
                alert("Connection error");
            },
            success: function(data) {
           	var height=500;
        		var width=600;
        		window.showModalDialog('${root}/synorg/synUserResult?result='+encodeURI(data),window,'dialogHeight='+height+',dialogWidth='+width);
            }
        });
	}
	</script>
	 -->
</html>
