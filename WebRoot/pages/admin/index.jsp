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
<title>中国海事局AIS岸基网络监控系统-主页</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<%@include file="include/style.jsp"%>
</head>
<!-- BEGIN HEADER -->
<%@include file="include/head.jsp"%>
<!-- END HEADER -->
<!-- BEGIN SIDEBAR -->
<%@include file="include/sidebar.jsp"%>
<!-- END SIDEBAR -->
<!-- BEGIN PAGE -->
	<div class="page-content">

			<!-- BEGIN PAGE CONTAINER-->

			<div class="container-fluid">

				<!-- BEGIN PAGE HEADER-->

				<div class="row-fluid">

					<div class="span12">

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->

						<h3 class="page-title">

							AIS基站网络监控平台简介 

						</h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="<%=basePath%>mainpage">主页</a>
							</li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid margin-bottom-20">

					<div class="span12">

						&nbsp;&nbsp;&nbsp;&nbsp;AIS基站网络监控平台简介AIS基站网络监控平台简介AIS基站网络监控平台简介AIS基站网络监控平台简介AIS基站网络监控平台简介AIS基站网络监控平台简介AIS基站网络监控平台简介AIS基站网络监控平台简介AIS基站网络监控平台简介AIS基站网络监控平台简介

					</div>

				</div>

				<div class="row-fluid">

					<div class="span6">

						<!-- BEGIN SAMPLE TABLE PORTLET-->

						<div class="portlet box green">

							<div class="portlet-title">

								<div class="caption">
									<i class="icon-cogs"></i>通知公告
								</div>

								<div class="tools">

									<a href="javascript:;" class="collapse"></a> 

								</div>

							</div>

							<div class="portlet-body">

								<table class="table table-condensed table-hover"
									id="notice_table">
									<colgroup>
										<col width="5%"></col>
										<col width="55%"></col>
										<col width="40%"></col>
									</colgroup>
									<thead>
										<tr>
											<th>#</th>
											<th>公告标题</th>
											<th>发布时间</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${notices}" var="notice" varStatus="status">
											<tr >
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">
												<a href="${root}/notice/form/view?noticeId=${notice.noticeId}">${notice.noticeTitle}</a></td>
												<td style="vertical-align: middle;">${notice.noticeDate}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

							</div>

						</div>

						<!-- END SAMPLE TABLE PORTLET-->

					</div>

					<div class="span6">

						<!-- BEGIN BORDERED TABLE PORTLET-->

						<div class="portlet box green">

							<div class="portlet-title">

								<div class="caption">
									<i class="icon-coffee"></i>用户权限
								</div>

								<div class="tools">

									<a href="javascript:;" class="collapse"></a> <a
										href="#portlet-config" data-toggle="modal" class="config"></a>

									<a href="javascript:;" class="reload"></a> <a
										href="javascript:;" class="remove"></a>

								</div>

							</div>

							<div class="portlet-body">

								<table class="table table-bordered table-hover">

									<thead>

										<tr>

											<th>#</th>

											<th>角色名称</th>

											<th>权限等级</th>

											<th class="hidden-480">描述</th>

											<th>操作</th>

										</tr>

									</thead>

									<tbody>

										<tr>

											<td>1</td>

											<td>管理员</td>

											<td>一</td>

											<td class="hidden-480">管理员</td>

											<td><span class="label label-success">查看</span>
											</td>

										</tr>

										<tr>

											<td>2</td>

											<td>配置员</td>

											<td>二</td>

											<td class="hidden-480">配置员</td>

											<td><span class="label label-info">查看</span>
											</td>

										</tr>

										<tr>

											<td>3</td>

											<td>值班员</td>

											<td>三</td>

											<td class="hidden-480">值班员</td>

											<td><span class="label label-warning">查看</span>
											</td>

										</tr>

										<tr>

											<td>3</td>

											<td>值班员</td>

											<td>四</td>

											<td class="hidden-480">值班员</td>

											<td><span class="label label-danger">查看</span>
											</td>

										</tr>

									</tbody>

								</table>

							</div>

						</div>

						<!-- END BORDERED TABLE PORTLET-->

					</div>

				</div>
			</div>

		</div>
	
	<!-- BEGIN FOOTER -->
	<%@include file="include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="include/js.jsp"%>
	<!-- END JAVASCRIPTS -->
</html>
