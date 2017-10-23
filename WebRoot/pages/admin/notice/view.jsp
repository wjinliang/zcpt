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
<title>查看公告</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<%@include file="../include/style.jsp"%>
</head>
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

		<!-- BEGIN PAGE HEADER-->

		<div class="row-fluid">

			<div class="span12">

				<!-- BEGIN PAGE TITLE & BREADCRUMB-->

				<h3 class="page-title">${notice.noticeTitle}</h3>
				<button type="button" onclick="window.history.back();" class="btn blue pull-right"> <i class="icon-arrow-left"></i> 返  回 </button>
				<ul class="breadcrumb">

					<li>来源： ${notice.noticeOriginal}</li>
					<li></li>
					<li>发布时间： ${notice.noticeDate}</li>
				</ul>
				<!-- END PAGE TITLE & BREADCRUMB-->
				
			</div>
		</div>

		<!-- END PAGE HEADER-->

		<!-- BEGIN PAGE CONTENT-->

		<div class="row-fluid margin-bottom-20">

			<div class="span12" style="border: 1px solid #eee;">
			${notice.noticeContent}
			</div>

		</div>

	</div>

</div>

<!-- BEGIN FOOTER -->
<%@include file="../include/foot.jsp"%>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../include/js.jsp"%>
<!-- END JAVASCRIPTS -->
</html>
