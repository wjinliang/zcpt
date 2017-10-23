<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>注册</title>
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
	<div data-role="page" id="regiestPage" class="jqm-demos">
	<form class="tempUserform" id="tempUserform" name="tempUserform" data-ajax="false"
				action="<%=basePath%>/saveRegiest" method="post">
	<div data-role="header" class="jqm-header" data-position="fixed">
		<a href="<%=basePath%>/login" rel="external" class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-btn-icon-right ui-icon-back">返回</a>
        <h1>用户注册</h1>
        <button type="submit"
				class="ui-btn ui-btn-right ui-corner-all ui-shadow ui-icon-check ui-btn-icon-left">确认</button>
	</div>
    <div role="main" class="ui-content">
				<label for="loginname">登录名:             
				<input type="text"
					name="loginname" id="loginname"  data-clear-btn="true" data-mini="true">
				</label> 
				<label for="name">用户名:             
				<input type="text"
					name="name" id="name"  data-clear-btn="true" data-mini="true">
				</label>
				<label for="password">密码:             
				<input type="password"
					name="password" id="password"  data-clear-btn="true" data-mini="true">
				</label>
				<label for="cpassword">确认密码:             
				<input type="password"
					name="cpassword" id="cpassword"  data-clear-btn="true" data-mini="true">
				</label>
				<label for="mobile">手机:             
				<input type="text"
					name="mobile" id="mobile"  data-clear-btn="true" data-mini="true">
				</label>
				<label for="email">电子邮箱:             
				<input type="text"
					name="email" id="email"  data-clear-btn="true" data-mini="true">
				</label>
	</div>
	<div data-role="footer" data-position="fixed" data-theme="a">
			<p>Copyright 2014</p>
	</div>
	</form>
	</div><!-- /page -->
	<script>
	$("#regiestPage" ).on( "pageinit", function() {
	$("#tempUserform" ).validate({
		rules: {
			loginname: {
				required: true
			},
			name: {
				required: true
			},
			loginname: {
				required: true
			},
			password: {
				required: true,
				minlength: 6
			},
			cpassword: {
				required: true,
				minlength: 6,
				equalTo: "#password"
			},
			email: {
				required: true,
				email: true
			},
			mobile:{
				required: true
			}
		},
		messages: {
			loginname: "请输入登录名。",
			name: "请输入用户名",
			password: {
				required: "请输入密码。",
				minlength: "至少6位。"
			},
			cpassword: {
				required: "请输入确认密码。",
				minlength: "至少6位。",
				equalTo: "与密码不一致。"
			},
			email: {
				required: "请输入邮箱。",
				email: "格式不正确。"
			},
			mobile: "请输入电话。"
		},
		errorPlacement: function( error, element ) {
			error.insertAfter( element.parent() );
		}
	});
	});
	</script>
</body>
</html>