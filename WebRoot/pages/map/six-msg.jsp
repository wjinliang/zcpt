<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'six-msg.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
     <table>
       <tr><td>消息ID:</td><input type="text" /><td></td><td>应用数据:</td><td><input type="text" /></td></tr>
       <tr><td>转发指示符:</td><td><select><option>1</option><option>2</option><option>3</option></select></td><td>应用标识符:</td><td></td></tr>
       <tr><td>序列编号:</td><td><select><option>1</option><option>2</option><option>3</option></select></td><td>重发标志:</td><td><select><option>1</option><option>2</option></select></td></tr>
       <tr><td><input type="button" value ="发送"/></td></tr>
     <table>
  </body>
</html>
