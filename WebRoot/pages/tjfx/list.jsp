<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@page import="java.util.List"%>
<%@page import="com.app.model.JKApplicationInfo"%>
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
<title>统计列表</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../admin/include/style.jsp"%>
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
							统计列表 <small>统计结果</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/syn/listSynApp">主页</a>
								<i class="icon-angle-right"></i>
							</li>
						</ul>
					</div>
				</div>
				<div class="fszt"><div class="cg" id="timeCount"></div></div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>列表
								</div>
							</div>
							<div class="portlet-body">
								<table class="table table-condensed table-hover"
									id="useraccount_table">
									<colgroup>
										<col ></col>
										<col ></col>
										<col ></col>
									</colgroup>
									<thead>
										<tr>
											<th>组织名称</th>
											<th>用户数量</th>
											<th>在线用户数</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${resultList}" var="result" varStatus="status">
											<tr >
												<td style="vertical-align: middle;">
												<c:choose>
													<c:when test="${result.flag=='1'}">
														<a href="${root}/tjfx/listTj?orgId=${result.id}">${result.name}</a></td>
													</c:when>
													<c:otherwise>
														${result.name}
													</c:otherwise>
												</c:choose>
												<td style="vertical-align: middle;"><a href="${root}/tjfx/listUsers?orgid=${result.id}&orgids=${result.ids}">${result.userCount}(人)</a></td>
												<td style="vertical-align: middle;"><a href="${root}/tjfx/listActiveUsers?orgids=${result.ids}">${result.onLineUserCount}(人)</a></td>
											</tr>
										</c:forEach>
												<td style="vertical-align: middle;">总计</td>
												<td style="vertical-align: middle;">${userCountSum}(人)</td>
												<td style="vertical-align: middle;">${onLineUserCountSum}(人)</td>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	<!-- BEGIN FOOTER -->
	<%@include file="../admin/include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../admin/include/js.jsp"%>
	
	<!-- END JAVASCRIPTS -->
</html>
