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
<title>Ping 结果</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<%@include file="../admin/include/style.jsp"%>
</head>
<div class="page-content" style="height: 500px">
	<div class="span3" style="height: 450px;overflow-y:auto;" >
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>Ping 结果
								</div>
							</div>
							<div class="portlet-body">
							<c:choose>
								<c:when test="${result}"><font color="green">网络畅通</font></c:when>
								<c:otherwise><font color="red">网络阻塞</font></c:otherwise>
							</c:choose>
							</div>
						</div>
	</div>
	<div align="center">
	<button type="button" onclick="window.close();" class="btn red">
			<i>关&nbsp;&nbsp;闭</i>
	</button>
	<div>
</div>
	<script type="text/javascript" src="${root}/themes/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	<SCRIPT type="text/javascript">
	
    </SCRIPT>
</html>
