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
<title>表单信息</title>
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
						<div class="portlet box green">
							<div class="portlet-title">信息</div>
							<div class="portlet-body">
								<div class="form-horizontal form-view">

									<div class="row-fluid">

										<div class="span12 ">
											<div class="control-group">

												<div class="control-group">

										<label class="control-label">菜单名
										</label>

										<div class="controls">
											<span class="text">${userMenu.name}</span>
										</div>

									</div>
									<div class="control-group">

										<label class="control-label">菜单路径
										</label>

										<div class="controls">
											<span class="text">${userMenu.url}</span>
										</div>

									</div>
									<div class="control-group">

										<label class="control-label">是否显示</label>

										<div class="controls">

											<c:if test="${userMenu.isShow=='1'}"><span class="text">是</span></c:if>
											<c:if test="${userMenu.isShow=='0'}"><span class="text">否</span></c:if>


										</div>

									</div>
									<div class="control-group">

										<label class="control-label">图标
										</label>
										<div class="controls">
											<span class="text"><i class="${userMenu.icon}"></i></span>
										</div>

									</div>
									<div class="control-group">

										<label class="control-label">排序号
										</label>

										<div class="controls">
											<span class="text">${userMenu.seq}</span>
										</div>

									</div>
									
									<div class="control-group">

										<label class="control-label">描述
										</label>

										<div class="controls">
											<span class="text">${userMenu.detail}</span>
										</div>

									</div>

											<div class="form-actions">
												<button type="button" onclick="editItem('${userMenu.id}')" class="btn blue">
													<i class="icon-pencil"></i> 修改
												</button>
												<button type="button" onclick="closewin()" class="btn">关闭</button>

											</div>
										</div>
									</div>
								</div>
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
	<script type="text/javascript"
		src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
	<script>
		function closewin() {
			var api = frameElement.api, W = api.opener; // api.opener 为载加lhgdialog.min.js文件的页面的window对象
			api.close();
		}
		function editItem(id){
			window.location.href="${root}/usermenu/form/edit?menuid="+id;
		}
	</script>

	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</body>
</html>
