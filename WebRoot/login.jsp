<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
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
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,chrome=1">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="动物疫病预控中心,中国动物疫病预控中心">
	<meta http-equiv="description" content="动物疫病预控中心单点登录">
	
		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="<%=basePath%>/themes/assets/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=basePath%>/themes/assets/font-awesome/4.2.0/css/font-awesome.min.css" />

		<!-- text fonts -->
		<link rel="stylesheet" href="<%=basePath%>/themes/assets/fonts/fonts.googleapis.com.css" />

		<!-- ace styles -->
		<link rel="stylesheet" href="<%=basePath%>/themes/assets/css/ace.min.css" />

		<!--[if lte IE 9]>
			<link rel="stylesheet" href="<%=basePath%>/themes/assets/css/ace-part2.min.css" />
		<![endif]-->
		<link rel="stylesheet" href="<%=basePath%>/themes/assets/css/ace-rtl.min.css" />

		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="<%=basePath%>/themes/assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="<%=basePath%>/themes/assets/js/html5shiv.min.js"></script>
		<script src="<%=basePath%>/themes/assets/js/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">   
        #ie6-warning{background:#FF0; position:absolute;top:0; left:0;font-size:12px; line-height:24px; color:#F00; padding:0 10px; }  
        #ie6-warning span{float:right; cursor:pointer; margin-top:4px;} 
        #ie6-warning a{text-decoration:none;color:#2f0 !important}  
        .login-box .toolbar>div {  width: 30%;  }
	    .login-box .user-div-tj{  text-align: center; }
	    .login-box .user-tj{  color:#fff }
</style>
    
	<!--[if lte IE 7]>   
<div id="ie6-warning" style="z-index:100;">
<span  onclick="closeme();"><img src="<%=basePath%>themes/assets/img/clear.png" width="14" height="14" alt="关闭提示" />关闭提示</span>
您正在使用 Internet Explorer 7 低版本的IE浏览器。为更好的浏览本页，建议您将浏览器升级到 
<a href="http://www.microsoft.com/china/windows/internet-explorer/ie8howto.aspx" target="_blank">IE8</a>  
或以下浏览器： <a href="/360cse.exe" target="_blank">360浏览器下载(非XP系统)</a>/ <a href="/360sexp.exe" target="_blank">360浏览器下载(XP系统)</a>
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
	</head>

	<body class="login-layout blur-login">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">

                        <div class="center" style="margin:50px 200px;width:60%;">
								<h1>
									<i class="ace-icon fa fa-leaf green"></i>
									<span class="red">单点登录</span>
									<span class="white" id="id-text2">全国动物疫病防控与动物卫生监督工作云平台</span>
								</h1>
							</div>


						<div class="login-container">
							
							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-coffee <c:if test="${param.error==true}">red</c:if>
												<c:if test="${param.error!=true}">green</c:if>"></i>
												
												<c:if test="${param.error==true}">${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}</c:if>
												<c:if test="${param.error!=true}">请输入您的信息</c:if>

											</h4>

											<div class="space-6"></div>
											<form id="loginForm" name="loginForm" class="form-vertical login-form" action="<%=basePath%>/j_spring_security_check" method="post">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" name="j_username" placeholder="登录名" />
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="密码" name="j_password" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>
<c:if test="${param.error==true}">
			<div class="row-fluid">
			<div class="inline">
			<div class="control-group">
				<!-- <label class="control-label visible-ie8 visible-ie9">验证码</label> -->
				<div class="controls">
					<div class="input-icon left">
						<i class="icon-font"></i> 
						<input 
							class="m-wrap placeholder-no-fix" style="width:100px;" type="text"
							placeholder="验证码" name="j_captcha" />
					</div>
				</div>
			</div>
			</div>
			<div class="inline">
			<div class="control-group">
				<div class="controls">
					<div class="input-icon left">
						<a id="flashImage" title="看不清,换一张" href="javascript:void(0)">
						<img id="imageF" src="<%=basePath%>/randomImage"
							style="width:150px;height:32px;border: 1px solid #e5e5e5;"
							class="m-wrap placeholder-no-fix" />
						</a>
					</div>
				</div>
			</div>
			</div>
			</div>
			</c:if>
													<div class="space"></div>

													<div class="clearfix">
														<label class="inline">
															<input type="checkbox" class="ace" name="_spring_security_remember_me"/>
															<span class="lbl">记住</span>
														</label>

														<button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110">登录</span>
														</button>
													</div>

													<div class="space-4"></div>
												</fieldset>
											</form>

											
										</div><!-- /.widget-main -->

										<div class="toolbar clearfix">
											<div>
												<a href="/yonghushouce.zip" style="color:#fff">用户手册
												</a>
											</div>
											<div >
												<a href="#" data-target="#forgot-box"  class="user-signup-link">
													浏览器下载
													
												</a>
											</div>
											<div class="user-div-tj">
												<a href="/dengluminghebing.docx"  class="user-tj">
													用户统计表
												</a>
											</div>
										</div>
									</div><!-- /.widget-body -->
								</div><!-- /.login-box -->
										<span id="btn-login-dark"></span>
										<span id="btn-login-light"></span>
										<span id="btn-login-blur"></span>

								<div id="forgot-box" class="signup-box widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header green lighter bigger">
												浏览器下载
											</h4>

											<div class="space-6"></div>
											<p>
												<a href="/360cse.exe">360浏览器下载(非XP系统)</a>
											</p>
											<p>
												<a href="/360sexp.exe">360浏览器下载(XP系统)</a>
											</p>
											<p></p>
											<p></p>
											<p></p>
											<p></p>
											<!--
											<p>
												<a href="/Firefox.exe">火狐浏览器(32位/64位)</a>
											</p>
											<p>
												<a href="/Chrome64.exe">谷歌浏览器(64位)</a>
											</p>
											<p>
												<a href="/Chrome32.exe">谷歌浏览器(32位)</a>
											</p>
											<p>
												<a href="/chromeforxp_setup.exe">谷歌浏览器(xp系统专用)</a>
											</p>
-->
											
										</div><!-- /.widget-main -->

										<div class="toolbar center">
											<a href="#" data-target="#login-box" class="back-to-login-link">
												返回登录
												<i class="ace-icon fa fa-arrow-right"></i>
											</a>
										</div>
									</div><!-- /.widget-body -->
								</div><!-- /.forgot-box -->

								<div id="signup-box" class="signup-box widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header green lighter bigger">
												<i class="ace-icon fa fa-users blue"></i>
												用户注册
											</h4>

											<div class="space-6"></div>
											<p>填写信息: </p>

											<form>
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="email" class="form-control" placeholder="é®ç®±" />
															<i class="ace-icon fa fa-envelope"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="ç¨æ·å" />
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="å¯ç " />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="ç¡®è®¤å¯ç " />
															<i class="ace-icon fa fa-retweet"></i>
														</span>
													</label>

													<label class="block">
														<input type="checkbox" class="ace" />
														<span class="lbl">
															接受
															<a href="#">用户协议</a>
														</span>
													</label>

													<div class="space-24"></div>

													<div class="clearfix">
														<button type="reset" class="width-30 pull-left btn btn-sm">
															<i class="ace-icon fa fa-refresh"></i>
															<span class="bigger-110">重置</span>
														</button>

														<button type="button" class="width-65 pull-right btn btn-sm btn-success">
															<span class="bigger-110">注册</span>

															<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
														</button>
													</div>
												</fieldset>
											</form>
										</div>

										<div class="toolbar center">
											<a href="#" data-target="#login-box" class="back-to-login-link">
												<i class="ace-icon fa fa-arrow-left"></i>
												返回登录
											</a>
										</div>
									</div><!-- /.widget-body -->
								</div><!-- /.signup-box -->
							</div><!-- /.position-relative -->

							
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->

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
			if('ontouchstart' in document.documentElement) document.write("<script src='<%=basePath%>/themes/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>

		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			jQuery(function($) {
			 $(document).on('click', '.toolbar a[data-target]', function(e) {
				e.preventDefault();
				var target = $(this).data('target');
				$('.widget-box.visible').removeClass('visible');//hide others
				$(target).addClass('visible');//show target
			 });
			});
			
			
			
			//you don't need this, just used for changing background
			jQuery(function($) {
			 $('#btn-login-dark').on('click', function(e) {
				$('body').attr('class', 'login-layout');
				$('#id-text2').attr('class', 'white');
				$('#id-company-text').attr('class', 'blue');
				
				e.preventDefault();
			 });
			 $('#btn-login-light').on('click', function(e) {
				$('body').attr('class', 'login-layout light-login');
				$('#id-text2').attr('class', 'grey');
				$('#id-company-text').attr('class', 'blue');
				
				e.preventDefault();
			 });
			 $('#btn-login-blur').on('click', function(e) {
				$('body').attr('class', 'login-layout blur-login');
				$('#id-text2').attr('class', 'white');
				$('#id-company-text').attr('class', 'light-blue');
				
				e.preventDefault();
			 });
			 
			});
			jQuery(function($) {
				$("#flashImage").click(
						function() {
							$('#imageF').hide().attr(
									'src',
									'')
									.fadeIn();
						   $('#imageF').show().attr(
									'src',
									'<%=basePath%>/randomImage?t='+Math.random())
									.fadeIn();
						});
			});
		</script>
		
	</body>
</html>
