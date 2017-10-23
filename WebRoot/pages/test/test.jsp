<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Test.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<%@include file="../admin/include/style.jsp"%>
<link href="<%=basePath%>themes/media/css/profile.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>themes/media/css/bootstrap-fileupload.css"
	rel="stylesheet" type="text/css" />
<link href="<%=basePath%>themes/media/css/chosen.css" rel="stylesheet"
	type="text/css" />
  </head>
  
  <body>
  <%@include file="../admin/include/head.jsp"%>
		<%@include file="../admin/include/sidebar.jsp"%>
		<c:forEach items="${testList}" var="test" varStatus="status">
			${status.count}
			<c:if test="${test.id >= 0}">11111${test}</c:if>
			${test.name}
		</c:forEach>
		<%@include file="../admin/include/js.jsp"%>
  </body>
</html>
