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
<title>操作成功</title>
<link rel="stylesheet"
	href="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>themes/jquery-mobile/css/jqm-demos.css">
<script src="<%=basePath%>themes/jquery-mobile/jquery-1.10.2.min.js"></script>
<script src="<%=basePath%>themes/jquery-mobile/js/index.js"></script>
<script
	src="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
</head>
<div data-role="page">
	<div data-role="header" data-position="fixed" data-theme="a">
		<h1>提示</h1>
	</div><!-- /header -->

	<div role="main" class="ui-content">
		<h3 class="ui-bar ui-bar-a ui-corner-all">操作成功</h3>
    	<div class="ui-body ui-body-a ui-corner-all">
        	<p>${msg}</p>
			<p><a href="${redirect}" data-ajax="false">如果您的浏览器没有反应，请点击这里...</a></p>
		</div>
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-theme="a">
		<h4>Copyright 2014</h4>
	</div><!-- /footer -->
</div>
<script type="text/javascript">
$(document).ready(function() {
	setTimeout(function(){location.href="${redirect}";},3000);
});
</script>
</body>
</html>
