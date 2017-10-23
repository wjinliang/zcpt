<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
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
<title>审批记录</title>
<%@include file="../../include/meta.jsp"%>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/select2_metro.css" />

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/chosen.css" />
<link href="<%=basePath%>themes/media/css/timeline.css" rel="stylesheet"
	type="text/css" />


<!-- END PAGE LEVEL STYLES -->

</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-full-width page-header-fixed">
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
						<h3 class="page-title">审批记录</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i></li>
							<li><a>审批记录</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<h3 class="form-section">审批记录</h3>
						<ul class="timeline">
							<c:forEach items="${applys}" var="item">
								<c:if test="${item.applyStatus=='1'}">
										<li class="timeline-grey">
								</c:if>
								<c:if test="${item.applyStatus=='2'}">
										<li class="timeline-green">
								</c:if>
								<c:if test="${item.applyStatus=='3'}">
										<li class="timeline-red">
								</c:if>
									<div class="timeline-time">
										<span class="date">${fn:substring(item.applyDate, 0, 10)}</span>
										<span class="time">${fn:substring(item.applyDate, 10, 19)}</span>
									</div>
									<div class="timeline-icon">
										<c:if test="${item.applyStatus=='1'}">
												<i class="icon-clock" style="margin-top: 12px;"></i>
										</c:if>
										<c:if test="${item.applyStatus=='2'}">
												<i class="icon-ok" style="margin-top: 12px;"></i>
										</c:if>
										<c:if test="${item.applyStatus=='3'}">
												<i class="icon-remove" style="margin-top: 12px;"></i>
										</c:if>
									
									</div>
									<div class="timeline-body">
										<h2>申请结果：
											<c:if test="${item.applyStatus=='1'}">
												未结束
											</c:if>
											<c:if test="${item.applyStatus=='2'}">
												同意
											</c:if>
											<c:if test="${item.applyStatus=='3'}">
												驳回
											</c:if>
										</h2>
										<div class="timeline-content">
											申请内容：${item.applyContent}
											<br/>
											申请人：<a
												href="${root}/common/userInfo/${item.applyUserId}">${d:gName(item.applyUserId)}</a>
										</div>
										<div class="timeline-footer">

										<a href="${root}/apply/approveForm?applyId=${item.applyId}" class="nav-link pull-right">

										查看审批记录 <i class="m-icon-swapright m-icon-white"></i>                              

										</a>  

										</div>
								  </div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
						<div class="span12">
						<h3 class="form-section"><button type="button" onclick="window.history.back();"
											class="btn ">
							<i class="icon-arrow-left"></i> 返 回
						</button></h3>
						</div>
				</div>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->
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


	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</body>
</html>
