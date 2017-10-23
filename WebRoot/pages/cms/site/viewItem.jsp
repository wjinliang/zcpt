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
<title>站点管理-查看</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/select2_metro.css" />

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/chosen.css" />

<!-- END PAGE LEVEL STYLES -->

</head>
<!-- END HEAD -->

	<!-- BEGIN HEADER -->
	<%@include file="../../admin/include/head.jsp"%>
	<!-- END HEADER -->
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
							表单 <small>新增/修改示例</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="${root}/cms/site/listItems">站点管理</a> <i
								class="icon-angle-right"></i></li>
							<li><a>查看</a></li>
						</ul>
						</div>
					</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>内容
								</div>
							</div>
							<div class="portlet-body form">
								<!-- BEGIN FORM-->
								<div class="form-horizontal form-view">

									<div class="row-fluid">

										<div class="span6 ">

											<div class="control-group">

												<label class="control-label">站点名称:</label>

												<div class="controls">

													<span class="text">${item.siteName}</span>

												</div>

											</div>

										</div>
										
										<div class="span6 ">

											<div class="control-group">

												<label class="control-label">域名:</label>

												<div class="controls">

													<span class="text">${item.domain}</span>

												</div>

											</div>

										</div>

									</div>

									<!--/row-->

									<div class="form-actions">

										<button type="button" onclick="editItem(${item.siteId})" class="btn blue">
											<i class="icon-pencil"></i> 修改
										</button>
										<button type="button" onclick="window.history.back();" class="btn">返回</button>

									</div>
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

		<script type="text/javascript"
			src="<%=basePath%>themes/media/js/jquery.validate.min.js"></script>

		<script type="text/javascript"
			src="<%=basePath%>themes/media/js/additional-methods.min.js"></script>

		<script type="text/javascript"
			src="<%=basePath%>themes/media/js/select2.min.js"></script>

		<script type="text/javascript"
			src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>

		<!-- END PAGE LEVEL PLUGINS -->

		<script>
		function editItem(siteId){
			window.location.href="./editItem?siteId="+siteId;
		}
		</script>

		<!-- END JAVASCRIPTS -->
