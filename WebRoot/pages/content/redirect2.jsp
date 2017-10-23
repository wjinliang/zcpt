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
<title>操作提示</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<%@include file="../admin/include/style.jsp"%>

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="<%=basePath%>themes/media/css/error.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="shortcut icon" href="<%=basePath%>themes/media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-404-full-page">

	<div class="row-fluid">

		<div class="span12 page-404">

			<div class="number">
				 <c:if test="${error}"><i class="icon-remove-sign"></i></c:if>
         		 <c:if test="${!error}"><i class="icon-ok"></i></c:if>
			</div>

			<div class="details">

				<h3>
				 <c:if test="${msg!=null}">${msg}</c:if>
         		 <c:if test="${msg==null}">操作成功！</c:if>
				</h3>

				<p>

					<a href="${redirect}">如果您的浏览器没有反应，请点击这里...[<font id="num">3</font>]</a>

				</p>

				

			</div>

		</div>

	</div>

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<%@include file="../admin/include/js.jsp"%>
	<script type="text/javascript" src="${root}/themes/admin/js/jquery.timers-1.1.2.js"></script>
	<script type="text/javascript">
	var num = 2;
	$(document).ready(function() {
		setTimeout(function(){location.href="${redirect}";},3000);
		$('body').everyTime('1s',dec);
	});
	function dec(){
		document.getElementById("num").innerHTML=num;
		if(num>0){
			num--;
		}
	}
	</script>
	<!-- END JAVASCRIPTS -->

	<!-- END BODY -->

</html>