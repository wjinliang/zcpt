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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>DM MOBILE</title>
<link rel="stylesheet"
	href="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>themes/jquery-mobile/css/jqm-demos.css">
<script src="<%=basePath%>themes/jquery-mobile/jquery-1.10.2.min.js"></script>
<script src="<%=basePath%>themes/jquery-mobile/js/index.js"></script>
<script
	src="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
	
		<style>
.left {
	float: left;
	width: 78%;
	margin-right: 2%;
}

.right {
	float: right;
	width: 20%;
}

.ui-input-search {
	margin: 0;
}

button.ui-btn {
	margin: 0;
}
</style>
<script>
	function submitForm() {
		document.newForm.submit();
	}
</script>
</head>
<body>
<div data-role="page" class="jqm-demos">
		<div data-role="header" data-position="fixed" data-theme="a">
			<h1>示例</h1>
			<a href="javascript:window.history.back();" data-shadow="false"
				data-iconshadow="false" data-transition="slide"
				class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-icon-carat-l ui-btn-icon-left">取消</a>
			<a href="javascript:submitForm()" 
				class="ui-btn ui-btn-right ui-corner-all ui-shadow ui-icon-check ui-btn-icon-left">保存</a>
		</div>
		<div role="main" class="ui-content">
			<form class="userform" name="newForm" data-ajax="false"
				action="${root}/example/save" method="post">
				<input type="hidden" name="id" value="${example.id}" />
				<label for="name">示例名称:</label>              
				<input type="text"
					name="name" id="name" value="${example.name}" data-clear-btn="true" data-mini="true">
			</form>
		</div>
		<div data-role="footer" data-position="fixed" data-theme="a">
			<p>Copyright 2014</p>
		</div>
</div>
</body>
</html>
