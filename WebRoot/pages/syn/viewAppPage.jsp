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
<title>系统列表-表单</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../admin/include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="<%=basePath%>themes/media/css/bootstrap-fileupload.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/select2_metro.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/chosen.css" />

<!-- END PAGE LEVEL STYLES -->

</head>
<!-- END HEAD -->
	<!-- BEGIN HEADER -->
	<%@include file="../admin/include/head.jsp"%>
	<!-- END HEADER -->
		<!-- BEGIN SIDEBAR -->
		<%@include file="../admin/include/sidebar.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<h3 class="page-title">
							表单 <small>新增/修改系统</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/syn/listSynApp">主页</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="${root}/syn/listApp">系统列表</a> <i
								class="icon-angle-right"></i>
							</li>
							<li><a>表单</a>
							</li>
						</ul>
					</div>
				</div>
				<div  class="row-fluid">
					<div class="span8">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>表单内容
								</div>
							</div>

							<div class="portlet-body form">

								<!-- BEGIN FORM-->

								<form action="${root}/syn/updateApp" method="post"
									id="format_form" class="form-horizontal">
									<input type="hidden" name="id" value="${appInfo.id}"/> 
									<div id="alert-error" class="alert alert-error hide">

										<button class="close" data-dismiss="alert"></button>

										表单填写不正确，请仔细核查。

									</div>

									<div id="alert-success" class="alert alert-success hide">

										<button class="close" data-dismiss="alert"></button>

										提交成功，等待跳转！

									</div>

									<div class="control-group">

										<label class="control-label">系统名称<span class="required">*</span>
										</label>

										<div class="controls">
											<input type="text" name="appName"  id="appName"
												data-required="1" value="${appInfo.appName}" class="span6 m-wrap" <c:if test="${mode=='view'}"> readonly="readonly" </c:if> />

										</div>
									</div>
									<div class="control-group">

										<label class="control-label">系统标识
										<span class="required">*</span>
										</label>

										<div class="controls">
											<input type="text" name="appCode" id="appCode"  data-required="1"
												class="span6 m-wrap" value="${appInfo.appCode}"  <c:if test="${mode=='view'}"> readonly="readonly" </c:if> onblur="checkunique();"/>
										</div>

									</div>
									<div class="control-group">

										<label class="control-label">单点地址<span
											class="required">*</span> </label>

										<div class="controls">
											<input type="text" name="appPath" id="appPath" data-required="1"
												class="span6 m-wrap" value="${appInfo.appPath}" <c:if test="${mode=='view'}"> readonly="readonly" </c:if>/>

										</div>

									</div>
									<br/>
									<div class="control-group">

										<label class="control-label">同步类型<span
											class="required">*</span> </label>

										<div class="controls">
											<select name="synType" id="synType" onchange="showPackageName()"  <c:if test="${mode=='view'}">disabled="disabled" </c:if>>
												<option value="axis1"  <c:if test="${appInfo.synType=='axis1'}">selected="selected" </c:if>>axis1</option>
												<option value="axis2"  <c:if test="${appInfo.synType=='axis2'}">selected="selected" </c:if>>axis2</option>
												<option value="http"   <c:if test="${appInfo.synType=='http'}">selected="selected" </c:if>>http</option>
											</select>
										</div>

									</div>
									<div class="control-group" id="packageNameDiv" <c:if test="${appInfo.synType=='http'}">style="display: none"</c:if>>

										<label class="control-label">命名空间<span
											class="required">*</span> </label>
										<div class="controls">
											<input type="text" name="packageName" id="packageName" value="${appInfo.packageName}" data-required="1"
												class="span6 m-wrap" <c:if test="${mode=='view'}"> readonly="readonly" </c:if> />
										</div>

									</div>
									<div class="control-group" id="packageNameDiv1" <c:if test="${appInfo.synType!='axis1'}">style="display: none"</c:if>>

										<label class="control-label">参数名<span
											class="required">*</span> </label>
										<div class="controls">
											<input type="text" name="paramName" id="paramName" value="${appInfo.paramName}" data-required="1"
												class="span6 m-wrap" <c:if test="${mode=='view'}"> readonly="readonly" </c:if> />
										</div>

									</div>
									<div class="control-group">

										<label class="control-label">同步地址<span
											class="required">*</span> </label>

										<div class="controls">
											<input type="text" name="synPath" id="synPath"  data-required="1"
												class="span6 m-wrap" value="${appInfo.synPath}" <c:if test="${mode=='view'}"> readonly="readonly" </c:if>/>

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">操作级别<span
											class="required">*</span> </label>

										<div class="controls">
											<select name="opLevel" id="opLevel" <c:if test="${mode=='view'}">disabled="disabled" </c:if>>
												<option value="0"  <c:if test="${appInfo.opLevel=='0'}">selected="selected" </c:if>>部</option>
												<option value="1"  <c:if test="${appInfo.opLevel=='1'}">selected="selected" </c:if>>省</option>
												<option value="2"   <c:if test="${appInfo.opLevel=='2'}">selected="selected" </c:if>>市</option>
												<option value="3"  <c:if test="${appInfo.opLevel=='3'}">selected="selected" </c:if>>县</option>
												<option value="4"  <c:if test="${appInfo.opLevel=='4'}">selected="selected" </c:if>>镇（乡）</option>
												<option value="5"   <c:if test="${appInfo.opLevel=='5'}">selected="selected" </c:if>>村</option>
											</select>
										</div>

									</div>
									<div class="control-group">

										<label class="control-label">用户级别<span
											class="required">*</span> </label>

										<div class="controls">
											<select name="userLevel" id="userLevel" <c:if test="${mode=='view'}">disabled="disabled" </c:if>>
												<option value="0"  <c:if test="${appInfo.userLevel=='0'}">selected="selected" </c:if>>部</option>
												<option value="1"  <c:if test="${appInfo.userLevel=='1'}">selected="selected" </c:if>>省</option>
												<option value="2"   <c:if test="${appInfo.userLevel=='2'}">selected="selected" </c:if>>市</option>
												<option value="3"  <c:if test="${appInfo.userLevel=='3'}">selected="selected" </c:if>>县</option>
												<option value="4"  <c:if test="${appInfo.userLevel=='4'}">selected="selected" </c:if>>镇（乡）</option>
												<option value="5"   <c:if test="${appInfo.userLevel=='5'}">selected="selected" </c:if>>村</option>
											</select>
										</div>

									</div>
									<div class="control-group">

										<label class="control-label">系统描述 </label>

										<div class="controls">

										<textarea rows="3" name="description"  class="span6 m-wrap"  <c:if test="${mode=='view'}"> readonly="readonly" </c:if> >${appInfo.description}</textarea>
											

										</div>

									</div>

									<div class="form-actions">
										<c:if test="${mode!='view'}"> 
										<button type="submit" class="btn green">提交</button>
										</c:if>
										<button type="button" onclick="window.history.back();"
											class="btn">返回</button>

									</div>
									</form>
									<!-- END FORM-->
							</div>

						</div>

					</div>
					
				</div>
			</div>
	</div>
	<!-- END PAGE -->
	<!-- BEGIN FOOTER -->
	<%@include file="../admin/include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../admin/include/js.jsp"%>

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script type="text/javascript"
		src="<%=basePath%>themes/media/js/jquery.validate.js"></script>

	<script type="text/javascript"
		src="<%=basePath%>themes/media/js/additional-methods.min.js"></script>

	<script type="text/javascript"
		src="<%=basePath%>themes/media/js/select2.min.js"></script>

	<script type="text/javascript"
		src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>themes/media/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="<%=basePath%>themes/platform/js/lhgdialog/lhgdialog.min.js${dialog_css}"></script>
	<script>
	function showPackageName(){
		var synType=$("#synType").val();
		var packageName="${appInfo.packageName}";
		var paramName = "${appInfo.paramName}";
		if(synType=="http"){
			$("#packageName").val("");
			$("#packageNameDiv").hide();
		}else{
			$("#packageName").val(packageName);
			$("#packageNameDiv").show();
		}
		if(synType=="axis1"){
			$("#paramName").val(paramName);
			$("#packageNameDiv1").show();
		}else{
			$("#paramName").val("");
			$("#packageNameDiv1").hide();
		}
	}
	</script>
	<script>
	jQuery(document).ready(
			function() {
				var form = $('#format_form');
				form.validate({
					rules : {
						appName : {
							required : true
						},
						appCode : {
							required : true
						},
						appPath :{
							required: true,
								url:true
						},
						synPath :{
							required: true,
								url:true
						}
					},
						messages : { // custom messages for radio buttons and checkboxes
						appName : {
							required : "请输入系统名称"
						},
						appCode : {
							required : "请输入系统标识" 
						},
						appPath : {
							required : "请输入单点地址",
							url:"URL地址不正确"
						},
						synPath : {
							required : "请输入单点地址",
							url:"URL地址不正确"
						}
					}

				});

			});
	
	function checkunique(){
		var val = $("#appCode").val();
		$.ajax({
			type:'post',
			url:'${root}/syn/checkunique',
			data:{
				name:"appCode",
				param:val,
				id:'${appInfo.id}'
			},
			dataType:'html',
			success:function(data) {  
				  if(data=='n'){
					  alert("系统标识重复！");
				  }
			}
		});
	}
	</script>
</html>
