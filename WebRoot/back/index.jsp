<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<head>

<base href="<%=basePath%>">

<title>单点登录</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="动物疫病预控中心,中国动物疫病预控中心">
<meta http-equiv="description" content="动物疫病预控中心单点登录">

<!-- bootstrap & fontawesome -->
<link rel="stylesheet"
	href="<%=basePath%>/themes/assets/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>/themes/assets/font-awesome/4.2.0/css/font-awesome.min.css" />

<!-- text fonts -->
<link rel="stylesheet"
	href="<%=basePath%>/themes/assets/fonts/fonts.googleapis.com.css" />

<!-- ace styles -->
<link rel="stylesheet"
	href="<%=basePath%>/themes/assets/css/ace.min.css" />

<!--[if lte IE 9]>
			<link rel="stylesheet" href="<%=basePath%>/themes/assets/css/ace-part2.min.css" />
		<![endif]-->
<link rel="stylesheet"
	href="<%=basePath%>/themes/assets/css/ace-rtl.min.css" />

<!--[if lte IE 9]>
		  <link rel="stylesheet" href="<%=basePath%>/themes/assets/css/ace-ie.min.css" />
		<![endif]-->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<link rel="stylesheet" href="<%=basePath%>/themes/assets/css/style.css" />

<!--[if lt IE 9]>
		<script src="<%=basePath%>/themes/assets/js/html5shiv.min.js"></script>
		<script src="<%=basePath%>/themes/assets/js/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">   
        #ie6-warning{background:#FF0; position:absolute;top:0; left:0;font-size:12px; line-height:24px; color:#F00; padding:0 10px; }  
        #ie6-warning span{float:right; cursor:pointer; margin-top:4px;} 
        #ie6-warning a{text-decoration:none;color:#2f0 !important}  
</style>
    
	<!--[if lte IE 7]>   
<div id="ie6-warning" style="z-index:100;">
<span  onclick="closeme();"><img src="<%=basePath%>themes/assets/img/clear.png" width="14" height="14" alt="关闭提示" />关闭提示</span>
您正在使用 Internet Explorer 7 低版本的IE浏览器。为更好的浏览本页，建议您将浏览器升级到 
<a href="http://www.microsoft.com/china/windows/internet-explorer/ie8howto.aspx" target="_blank">IE8</a>  
或以下浏览器： <a href="/360cse.exe" target="_blank">360浏览器下载(非XP系统)</a>/  <a href="/360sexp.exe" target="_blank">360浏览器下载(XP系统)</a>
</div>
<script type="text/javascript">  
    togo = 0; 
    function closeme(){    
        var div = document.getElementById("ie6-warning");    
        div.style.display ="none";
    };
    function position_fixed(el, eltop, elleft){
        // check if this is IE6
        if(!window.XMLHttpRequest)
            window.onscroll = function(){
                el.style.top = (document.documentElement.scrollTop + eltop)+"px";
                el.style.left = (document.documentElement.scrollLeft + elleft)+"px";
            }
        else 
            el.style.position = "fixed";
    };
    position_fixed(document.getElementById("ie6-warning"),0, 0);
</script>   
<![endif]-->
		<style type="text/css">
			.usinfo{
				margin-right:100px;
				color:#eee;
				margin-top:10px;
				font-size:1.2em;
				float:right;
			}
			.lout{
				margin-left:3px;
				color:white;
			}
		</style>
</head>

<body class="login-layout blur-app">
	<div class="main-container">
		<div class="main-content">
			<div class="row">
				<span class="usinfo">${currentUser.name }[${currentUser.loginname }]<span><a class="lout" href="${root}/j_spring_security_logout"><fron>退出</a>
			</div>
			<div class="row">
					<div class="center banner">
						<h1>
							<span class="white"  id="id-text2">全国动物疫病防控与动物卫生监督工作云平台</span>
						</h1>
					</div>
				<div class="col-sm-10 col-sm-offset-1">
					<div class="app-container radius sheed">
						<div class="app-container-body${fn:length(synAppList)>=4?'-3':''}">
							<c:forEach items="${synAppList}" var="app" varStatus="status">
								<div class="col-xs-${fn:length(synAppList)>=4?'4':'6'} mT30">
									<div class="radius5 divcenter app opa list${status.index}" >
						               <a href="${root}/synuseraccount/ssoServiceBySession?xtbs=${app.appCode}" target="_blank" >
						               	<i class="fa-font fa <c:choose>
										<c:when test="${app.appCode=='fk'}">
										fa-ambulance
										</c:when>
										<c:when test="${app.appCode=='dwyb'}">
										fa-flask
										</c:when>
										<c:when test="${app.appCode=='zuxt'}">
										 fa-repeat 
										</c:when>
										</c:choose>  fa-briefcase  pT10"></i>
						               	<c:if test="${fn:length(app.appName)<17}">
						               		<span class="fonts1 pT10">${app.appName}</span>
						               	</c:if> 
						               	<c:if test="${fn:length(app.appName)>=17}">
						                  <span class="fonts1 fonts2 pT10">${app.appName}</span>
						                </c:if>
						                  <%-- <span class="w419 pT10"><p>${app.appName}</p></span> --%>
						               </a>
					               </div>
				               </div>
				               
				           </c:forEach>
							<div class="col-xs-${fn:length(synAppList)>=4?'4':'6'} mT30">
								<div class="radius5 divcenter app opa list9" >
									<a href="${root}/infoCenter"> <i
										class="fa-font fa fa-cogs  pT10"></i> <span class="fonts1 fonts3 pT10">单点登录</span>
										<!-- <span class="w419 pT30"><p>预控中心信息系统统一认证平台</p></span> -->
									</a>
								</div>
							</div>
						</div>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.main-content -->
		</div>
		<!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script src="<%=basePath%>/themes/assets/js/jquery.2.1.1.min.js"></script>

		<!-- <![endif]-->

		<!--[if IE]>
<script src="<%=basePath%>/themes/assets/js/jquery.1.11.1.min.js"></script>
<![endif]-->

		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='<%=basePath%>/themes/assets/js/jquery.min.js'>"+"<"+"/script>");
			
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='<%=basePath%>/themes/assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='<%=basePath%>
			/themes/assets/js/jquery.mobile.custom.min.js'>"
								+ "<"+"/script>");
		</script>

		<!-- inline scripts related to this page -->
		<script type="text/javascript">
		var appsSzie=1;
			jQuery(function($) {

			});
		</script>
</body>
</html>
