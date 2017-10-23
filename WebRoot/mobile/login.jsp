<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mobile-Login</title>
    <link rel="stylesheet" href="<%=basePath%>/themes/jquery-mobile/jquery.mobile-1.4.5.min.css" />
    <link rel="shortcut icon" href="<%=basePath%>/themes/jquery-mobile/favicon.ico">
	<script src="<%=basePath%>/themes/jquery-mobile/jquery-1.10.2.min.js"></script>
	<script src="<%=basePath%>/themes/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
	<script src="<%=basePath%>/themes/jquery-mobile/jquery.validate.js"></script>
	<style>
	label.error {
		color: red;
		font-size: 16px;
		font-weight: normal;
		line-height: 1.4;
		margin-top: 0.5em;
		width: 100%;
		float: none;
	}
	@media screen and (orientation: portrait) {
		label.error {
			margin-left: 0;
			display: block;
		}
	}
	@media screen and (orientation: landscape) {
		label.error {
			display: inline-block;
			margin-left: 22%;
		}
	}
	em {
		color: red;
		font-weight: bold;
		padding-right: .25em;
	}
	</style>
</head>
<body>
<div data-role="page" id="login" class="jqm-demos">
	<form id="loginForm" name="loginForm" action="<%=basePath%>/j_spring_security_check" method="post" data-ajax="false">
	<div data-role="header" class="jqm-header" data-position="fixed">
		<a href="<%=basePath%>/regiest" rel="external" class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-btn-icon-right ui-icon-user">注册</a>
        <h1>用户登录</h1>
	</div>
	<div class="ui-content" role="main">
		<c:if test="${param.error==true}">
		<div id="errorDiv" onclick="hideThis()" class="ui-bar ui-bar-a"><font color="red">${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}</font></div>
		</c:if>	
			<div class="ui-field-contain">
				<label for="j_username">用户名:</label>
				<input type="text" name="j_username" id="j_username" value="" data-clear-btn="true">
			</div>
			<div class="ui-field-contain">
				<label for="j_password">密码:</label>
				<input type="password" name="j_password" id="j_password" value="" data-clear-btn="true">
			</div>
		<div class="ui-input-btn ui-btn ui-icon-carat-r ui-btn-icon-right ui-btn-active ui-corner-all">
					登录
			<input type="submit" data-transition="flip" data-enhanced="true" value="登录">
		</div>
	</div>
	<div data-role="footer" data-position="fixed" data-theme="a">
		<p>Copyright 2014</p>
	</div>
	</form>
</div>
<script>
	function hideThis(){
		$("#errorDiv").hide();
	}
	$("#login" ).on("pageinit", function() {
	$("#loginForm" ).validate({
		rules: {
			j_username: {
				required: true
			},
			j_password: {
				required: true,
			}
		},
		messages: {
			j_username: "请输入登录名。",
			j_password: "请输入密码。"
		},
		errorPlacement: function( error, element ) {
			error.insertAfter( element.parent() );
		}
	});
	});
	</script>
</body>
</html>
