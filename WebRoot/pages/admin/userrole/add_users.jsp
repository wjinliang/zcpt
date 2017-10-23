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
<title>添加用户</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${root}/themes/media/css/multi-select-metro.css" />
</head>
<!-- END HEAD -->

	<!-- BEGIN HEADER -->
	<%@include file="../include/head.jsp"%>
	<!-- END HEADER -->
		<!-- BEGIN SIDEBAR -->
		<%@include file="../include/sidebar.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<h3 class="page-title">
							添加用户 <small>为角色添加用户</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="${root}/userrole/list">角色管理</a> <i
								class="icon-angle-right"></i>
							</li>
							<li><a>添加用户</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">

					<div class="span12">

						<!-- BEGIN PORTLET-->

						<div class="portlet box green">

							<div class="portlet-title">

								<div class="caption">
									<i class="icon-reorder"></i>添加用户
								</div>

								<div class="tools">

									<a href="javascript:;" class="reload"></a>

								</div>

							</div>

							<div class="portlet-body form">

								<!-- BEGIN FORM-->

								<form action="${root}/userrole/setUsers?roleId=${roleId}"
									method="post" class="form-horizontal">
									<div class="control-group">

										<label class="control-label">左侧为未选择用户</label>

										<div class="controls">

											<select multiple="multiple" id="userIds" name="userIds">
												<c:forEach items="${yesUsers}" var="user1"
													varStatus="status">
													<option value="${user1.code}" selected>${user1.name}(${user1.name})</option>
												</c:forEach>
												<c:forEach items="${noUsers}" var="user2" varStatus="status">
													<option value="${user2.code}">${user2.name}(${user2.name})</option>
												</c:forEach>
											</select>

										</div>

									</div>

									<div class="form-actions">

										<button type="submit" class="btn blue">确定</button>

										<button type="button" onclick="window.history.back();"
											class="btn">返回</button>

									</div>

								</form>

								<!-- END FORM-->

							</div>

						</div>

						<!-- END PORTLET-->

					</div>

				</div>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	<!-- BEGIN FOOTER -->
	<%@include file="../include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../include/js.jsp"%>
	<script type="text/javascript"
		src="${root}/themes/media/js/jquery.multi-select.js"></script>
	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</html>
