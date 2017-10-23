<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<style type="text/css">   
        #ie6-warning{background:#FF0; top:0; left:0;font-size:12px; line-height:24px; color:#F00; padding:0 10px; }  
        #ie6-warning span{float:right; cursor:pointer; margin-top:4px;} 
        #ie6-warning a{text-decoration:none;color:#2f0 !important}  
</style>
    
	<!--[if lte IE 7]>   
<div id="ie6-warning" style="z-index:100;">
<span  onclick="closeme();"><img src="<%=basePath%>themes/assets/img/clear.png" width="14" height="14" alt="关闭提示" />关闭提示</span>
您正在使用 Internet Explorer 7 低版本的IE浏览器。为更好的浏览本页，建议您将浏览器升级到 
<a href="http://www.microsoft.com/china/windows/internet-explorer/ie8howto.aspx" target="_blank">IE8</a>  
或以下浏览器：<a href="/360cse.exe" target="_blank">360浏览器下载(非XP系统)</a>/ <a href="/360sexp.exe" target="_blank">360浏览器下载(XP系统)</a>
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
            el.style.position = "none";
    };
    position_fixed(document.getElementById("ie6-warning"),0, 0);
</script>   
<![endif]-->
<!-- BEGIN BODY -->
<body class="page-full-width">
	<div class="header navbar navbar-inverse ">
		<!-- BEGIN TOP NAVIGATION BAR -->
		<div class="navbar-inner">
			<div class="container-fluid">
				<!-- BEGIN LOGO -->
				<a class="brand" href="javascript:void(0);"><%--  <img
					src="<%=basePath%>/back/images/logo.png" alt="logo" /> --%> </a>
				<!-- END LOGO -->
				<div id="vertical" class="navbar hor-menu hidden-phone hidden-tablet">
				</div>
				<!-- BEGIN RESPONSIVE MENU TOGGLER -->
				<a href="javascript:;" class="btn-navbar collapsed"
					data-toggle="collapse" data-target=".nav-collapse"> 
					<img src="<%=basePath%>themes/media/image/menu-toggler.png" alt="" /> 
				</a>
				<!-- END RESPONSIVE MENU TOGGLER -->
				<!-- BEGIN TOP NAVIGATION MENU -->
				<ul id="top_nav" class="nav pull-right">
					<!-- BEGIN USER LOGIN DROPDOWN -->
					<!--  -->
					<li class="dropdown user">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
						<!-- <img alt="" style="width:30px;height:30px;" src="${currentUser.headpic}" /> -->
						<span class="username">${currentUser.name}[${currentUser.loginname}]</span>
						<i class="icon-angle-down"></i> 
					</a>
					<ul class="dropdown-menu">
						<li>
						<a href="<%=basePath%>j_spring_security_logout">
							<i class="icon-key"></i>
							退出
						</a>
						</li>
					</ul>
					</li>
					<!-- END USER LOGIN DROPDOWN -->
				</ul>
				<!-- END TOP NAVIGATION MENU -->
			</div>
		</div>
		<!-- END TOP NAVIGATION BAR -->
	</div>

	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<div class="color-panel hidden-phone">

			<div class="color-mode-icons icon-color"></div>

			<div class="color-mode-icons icon-color-close"></div>

			<div class="color-mode">
			<form name="layoutForm" id="layoutForm" action="<%=basePath%>userAttr/saveLayout/${currentUser.code}" method="post">
				<p>主题颜色</p>

				<ul class="inline">

					<li data="theme" class="color-black color-default" data-style="default"></li>

					<li data="theme" class="color-blue" data-style="blue"></li>

					<li data="theme" class="color-brown" data-style="brown"></li>

					<li data="theme" class="color-purple" data-style="purple"></li>

					<li data="theme" class="color-grey" data-style="grey"></li>

					<li data="theme" class="color-white color-light" data-style="light"></li>

				</ul>
				<p>表格颜色</p>
				<ul class="inline">
					<li data="box" class="bg-blue" data-style="blue"></li>
					<li data="box" class="bg-green" data-style="green"></li>
					<li data="box" class="bg-red" data-style="red"></li>
					<li data="box" class="bg-yellow" data-style="yellow"></li>
					<li data="box" class="bg-grey" data-style="grey"></li>
				</ul>

				<label> 
				<span>导航</span> 
				<select id="layoutSetting" name="layoutType"
					class="layout-option m-wrap small">
						<option value="0">垂直</option>
						<option value="1">水平</option>
				</select> 
				</label>
				</form>
			</div>

		</div>
		<!-- BEGIN SIDEBAR -->