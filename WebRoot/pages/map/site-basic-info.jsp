<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  <style>
    .ais-pop1{
    cursor: move;
    width: 380px;
    height: 330px;
    position: absolute;
    z-index: 2;
    background-color: #ffffff;
    border-radius: 10px;
}
.ais-table1{
    width: 380px;
    height: 330px;
}
.btn-close{
    color: #0d99d5;
    font-weight: bold;
    font-size: 14px;
}
.btn-close:hover{
    color: #00ffff;
    text-decoration: none;
}
.ais-tt{
    height: 29px;
    padding: 8px 10px;
}

  </style>
  </head>
  
  <body>
<div class="site-basic-popu" id="siteBasicInfo" onmousedown="down1(this)" style="right: 6px;bottom: 25px;">
    <table class="ais-table1">
        <tbody>
        <tr>
            <td class="ais-tt">
                <div class="fn-right">
                    <a class="btn-close" href="javascript:void(0)" onclick="clase('pop2')">X</a>
                </div>
            </td>
        </tr>
        <tr class="ais-tc">
            <td></td>
        </tr>
        </tbody>
    </table>
</div>

 </body>
</html>
