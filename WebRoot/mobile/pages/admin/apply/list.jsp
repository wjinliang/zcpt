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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>审批主页</title>
<link rel="stylesheet"
	href="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<script src="<%=basePath%>themes/jquery-mobile/jquery-1.10.2.min.js"></script>
<script src="<%=basePath%>themes/jquery-mobile/js/index.js"></script>
<script
	src="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
</head>
<div data-role="page">
	<div data-role="header" data-position="fixed">
		<h1>审批中心</h1>
		<a href="<%=basePath%>mainpage" data-shadow="false"
				data-iconshadow="false" data-ajax="false"
				class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-icon-home ui-btn-icon-left ui-btn-icon-notext"></a>
	</div>
	<div data-role="navbar">
			<ul>
				<li><a rel="external" href="${root}/apply/list?approveStatus=1"
					data-icon="clock"
					<c:if test="${approveStatus=='1'}"> class="ui-btn-active" </c:if>>待审批<span
						class="ui-li-count" style="background-color: red;color: white;">${d:gAn("1")}</span>
				</a></li>
				<li><a rel="external" href="${root}/apply/list?approveStatus=2"
					data-icon="check"
					<c:if test="${approveStatus=='2'}"> class="ui-btn-active" </c:if>>已通过<span
						class="ui-li-count" style="background-color: red;color: white">${d:gAn("2")}</span>
				</a></li>
				<li><a rel="external" href="${root}/apply/list?approveStatus=3"
					data-icon="delete"
					<c:if test="${approveStatus=='3'}"> class="ui-btn-active" </c:if>>已驳回
					<span class="ui-li-count" style="background-color: red;color: white">${d:gAn("3")}</span>
				</a></li>
				<li><a rel="external" href="${root}/apply/list?approveStatus=0"
					data-icon="recycle"
					<c:if test="${approveStatus=='0'}"> class="ui-btn-active" </c:if>>已过期
					<span class="ui-li-count" style="background-color: red;color: white">${d:gAn("4")}</span>
				</a></li>             
			</ul>
		</div>

	<div data-role="main">
		<ul data-role="listview" data-theme="a" data-dividertheme="b"
		    data-filter="true" data-filter-theme="a"
			data-filter-placeholder="搜索">
			<c:forEach items="${applys}" var="apply">
				<li data-role="list-divider">${apply.applyDate}</li>
				<li>
				<a href="${root}/apply/approveForm?applyId=${apply.applyId}" ref="external">
					<h2>${apply.applyContent}</h2>
    				<p>
					申请人：${d:gName(apply.applyUserId)}
					<br/><strong>${apply.applyDate}</strong>
					</p>
    				<p>申请详情：${d:gDet(apply.applyId)}</p>
				</a>
				</li>
			</c:forEach>
		</ul>
	</div>

	<div data-role="footer" data-position="fixed">
		<h4>Copyright 2014</h4>
	</div>
</div>
</body>
</html>
