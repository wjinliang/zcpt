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
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
<meta content="" name="description" />
<meta content="" name="author" />
<title>操作提示</title>
<link href="<%=basePath%>themes/plugins/sweetAlert/sweet-alert.css" rel="stylesheet" type="text/css"/>
<link rel="shortcut icon" href="<%=basePath%>themes/media/image/favicon.ico" />
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body >

	

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<script src="<%=basePath%>themes/media/js/jquery-1.11.1.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/plugins/sweetAlert/sweet-alert.js"></script>
	<!--[if lte IE 7]>
		<script type="text/javascript">
		$(document).ready(function() {
			$('body').append('<h1>${msg}</h1><p>请等待<strong id="five"></strong>秒后<a href="${redirect}">跳转&gt;&gt;</a></p>');
			//setTimeout(function(){window.location.href="${redirect}";},2000);
	 		count();
		});
		</script>
			
		<![endif]-->
	<script type="text/javascript">
	var s=3;
    function count(){
       document.getElementById("five").innerHTML=s;
       s=s-1;
       if (s==0){
           window.location.href="${redirect}";
       }
       window.setTimeout(count,1000);
   }
	$(document).ready(function() {
		if("${msg}"!="") {
			setTimeout(function(){window.location.href="${redirect}";},3000);
			swal({
				title: "提示:",
				<c:if test="${!error}">type: "success",</c:if>
				<c:if test="${error}">type: "error",</c:if>
				<c:if test="${msg!=null}">text: "${msg}"</c:if>
				<c:if test="${msg==null}">text: "操作成功"</c:if>
			},
			function(){
				window.location.href="${redirect}";
			});
		} else {
			window.location.href="${redirect}";
		}
	});
	
	</script>
	<!-- END JAVASCRIPTS -->

	<!-- END BODY -->

</html>