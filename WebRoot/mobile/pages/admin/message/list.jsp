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
<title>消息中心</title>
<link rel="stylesheet"
	href="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<script src="<%=basePath%>themes/jquery-mobile/jquery-1.10.2.min.js"></script>
<script src="<%=basePath%>themes/jquery-mobile/js/index.js"></script>
<script
	src="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
</head>
<div data-role="page">
	<div data-role="header" data-position="fixed">
		<h1>消息中心</h1>
		<a href="<%=basePath%>mainpage" data-shadow="false"
				data-iconshadow="false" data-ajax="false"
				class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-icon-home ui-btn-icon-left ui-btn-icon-notext"></a>
	</div>
	<div data-role="navbar">
			<ul>
				<li><a rel="external" href="${root}/message/listNew"
					data-icon="clock"
					<c:if test="${isReaded=='0'}"> class="ui-btn-active" </c:if>>新消息<span
						class="ui-li-count" style="background-color: red;color: white;">${totalcount}</span>
				</a></li>
				<li><a rel="external" href="${root}/message/listAll"
					data-icon="check"
					<c:if test="${isReaded=='1'}"> class="ui-btn-active" </c:if>>全部
				</a></li>
			</ul>
		</div>

	<div data-role="main">
		<ul data-role="listview" data-theme="a" data-dividertheme="b"
		    data-filter="true" data-filter-theme="a"
			data-filter-placeholder="搜索">
			<c:forEach items="${messages}" var="message">
			<li>
			<a href="${root}/message/readMessage?messageId=${message.messageId}" ref="external">
					<h2>${message.messageContent}</h2>
					<p>来自：${d:gName(message.messageFromUserId)}</p>
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
