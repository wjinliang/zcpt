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
	<title>DM-MOBILE</title>
    <link rel="stylesheet" href="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.css" />
    <link rel="stylesheet" href="<%=basePath%>themes/jquery-mobile/css/jqm-demos.css">
	<script src="<%=basePath%>themes/jquery-mobile/jquery-1.10.2.min.js"></script>
	 <script src="<%=basePath%>themes/jquery-mobile/js/index.js"></script>
	<script src="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
	<script src="<%=basePath%>themes/jquery-mobile/js/qrcode.min.js"></script>
    <script>
    	function logout(){
    		document.myform.submit();
    	}
    	function submitForm(){
    		document.passwordform.submit();
    	}
    	function submitUserNameForm(){
    		document.usenameform.submit();
    	}
    	function submitEmailForm(){
    		document.emailform.submit();
    	}
	</script>
    <style>
    	#qrcode {
    		width: 200px;
    		height: 200px;
   	 		margin-top: 0px;
		}
		/* Adjust the width of the left reveal menu. */
		#mainpage #left-panel.ui-panel {
			width: 15em;
		}
		#mainpage #left-panel.ui-panel-closed {
			width: 0;
		}
		#mainpage .ui-panel-page-content-position-left,
		.ui-panel-dismiss-open.ui-panel-dismiss-position-left {
			left: 15em;
			right: -15em;
		}
		#mainpage .ui-panel-animate.ui-panel-page-content-position-left.ui-panel-page-content-display-reveal {
			left: 0;
			right: 0;
			-webkit-transform: translate3d(15em,0,0);
			-moz-transform: translate3d(15em,0,0);
			transform: translate3d(15em,0,0);
		}

		/* Listview with collapsible list items. */
	    .ui-listview > li .ui-collapsible-heading {
	      margin: 0;
	    }
	    .ui-collapsible.ui-li-static {
	      padding: 0;
	      border: none !important;
	    }
	    .ui-collapsible + .ui-collapsible > .ui-collapsible-heading > .ui-btn {
	      border-top: none !important;
	    }
	    /* Nested list button colors */
	    .ui-listview .ui-listview .ui-btn {
	    	background: #fff;
	    }
	    .ui-listview .ui-listview .ui-btn:hover {
	    	background: #f5f5f5;
	    }
	    .ui-listview .ui-listview .ui-btn:active {
	    	background: #f1f1f1;
	    }

		/* Reveal panel shadow on top of the listview menu (only to be used if you don't use fixed toolbars) */
		#mainpage .ui-panel-display-reveal {
			-webkit-box-shadow: none;
			-moz-box-shadow: none;
			box-shadow: none;
		}
		#mainpage .ui-panel-page-content-position-left {
			-webkit-box-shadow: -5px 0px 5px rgba(0,0,0,.15);
			-moz-box-shadow: -5px 0px 5px rgba(0,0,0,.15);
			box-shadow: -5px 0px 5px rgba(0,0,0,.15);
		}

		/* Setting a custom background image. */
		#mainpage.ui-page-theme-a,
		#mainpage .ui-panel-wrapper {
			background-color: #fff;
			
			background-repeat: repeat-x;
			background-position: left bottom;
		}

		/* Styling of the page contents */
		.article p {
			margin: 0 0 1em;
			line-height: 1.5;
		}
		.article p img {
			max-width: 100%;
		}
		.article p:first-child {
			text-align: center;
		}
		.article small {
			display: block;
			font-size: 75%;
			color: #c0c0c0;
		}
		.article p:last-child {
			text-align: right;
		}
		.article a.ui-btn {
			margin-right: 2em;
		}
		@media all and (min-width:769px) {
			.article {
				max-width: 994px;
				margin: 0 auto;
				padding-top: 4em;
				-webkit-column-count: 2;
				-moz-column-count: 2;
				column-count: 2;
				-webkit-column-gap: 2em;
				-moz-column-gap: 2em;
				column-gap: 2em;
			}
			/* Fix for issue with buttons and form elements
			if CSS columns are used on a page with a panel. */
			.article a.ui-btn {
				-webkit-transform: translate3d(0,0,0);
			}
		}
	</style>
</head>
<body>
<form id="myform" name="myform" action="<%=path%>/j_spring_security_logout" method="post" data-ajax="false">
</form>	
<div data-role="page" class="jqm-demos" id="mainpage" >
	<div data-role="header" data-position="fixed" data-theme="a">
        <h1><a>DM Mobile</a></h1>
        <a href="#left-panel" data-icon="bars" data-iconpos="notext" data-shadow="false" data-iconshadow="false"></a>
    	<a href="#user" data-icon="user" <c:if test="${newMessage==0}">data-iconpos="notext"</c:if>  data-shadow="false" data-iconshadow="false">
    	<c:if test="${newMessage>0}"><span class="count" style="background-color: red;color: white">&nbsp;New&nbsp;</span></c:if>
    	</a>
	</div>
    <div role="main" class="ui-content">
    	<div class="article">
            <h2>欢迎</h2>
            <p>基于jquery-mobile-1.45的DM移动版，测试中。</p>
            <p><a href="javascript:showCode()" data-rel="popup" data-position-to="window" class="ui-btn ui-shadow ui-corner-all ui-btn-inline ui-mini">二维码分享</a></p>
		</div><!-- /article -->
		<div data-role="popup" id="code" data-overlay-theme="a"
			class="ui-content" data-theme="a" style="min-width:260px;min-height:260px;">
			<div id="qrcode"></div>
		</div>
    </div><!-- /content -->
    <div data-role="panel" id="left-panel">
        <ul data-role="listview" data-theme="a" data-dividertheme="b" data-filter="true" data-filter-theme="a" data-filter-placeholder="Search">
				<c:forEach items="${menugroups}" var="menugroup">
				<li data-role="list-divider">${menugroup.gname}</li>
				<c:forEach items="${menugroup.menus}" var="menu">
				<li>
				<a rel="external" href="${root}${menu.url}">${menu.name}</a>
				</li>
				</c:forEach>
				</c:forEach>
		</ul>
	</div>
	<div data-role="panel" id="user" data-position="right" data-display="overlay"  >
				<ul data-role="listview" data-theme="a" data-split-theme="a" >
				<li data-role="list-divider"></li>
				<li>
				<a href="#userdetail" data-shadow="false" data-iconshadow="false" data-transition="slide" style="vertical-align: center;">
				<div height="130" width="130"><img height="120" width="120" src="${currentUser.headpic}"></div>
				<h2>${currentUser.username}</h2>
				</a>
				</li>
				<li data-role="list-divider"></li>
				<li>
					<a  <c:if test="${newMessage==0}">href="${root}/message/listNew"</c:if>
						<c:if test="${newMessage>0}">href="${root}/message/listAll"</c:if> 
						ref="external" style="text-align: center;" data-prefetch="true" >
					消息中心
					<c:if test="${newMessage>0}"><span class="ui-li-count" style="background-color: red;color: white">${newMessage}</span></c:if>
					</a>
				</li>
				<li>
					<a href="#password" data-transition="slide" style="text-align: center;" data-prefetch="true" class="ui-input-btn ui-btn ui-icon-edit ui-btn-icon-right">修改密码</a>
				</li>
				<li>
					<a href="javascript:logout()" style="text-align: center;" data-prefetch="true" class="ui-input-btn ui-btn ui-icon-forward ui-btn-icon-right">注销</a>
				</li>
				</ul>
	</div>
	<div data-role="panel" id="userdetail" data-position="right" data-display="overlay"  >
				<ul data-role="listview" data-theme="a" data-split-theme="a" >
				<li data-role="list-divider"></li>
				<li>
					<a href="#" data-transition="slide" 
					data-prefetch="true" 
					class="ui-input-btn ui-btn ui-icon-carat-r ui-btn-icon-right">
					<span style="float:left;text-align: center;margin-top: 8px;">头像</span>
					<span style="float:right;">
					<img height="32" width="32" src="${currentUser.headpic}"/>
					</span>
					</a>
				</li>
				<li data-role="list-divider"></li>
				<li>
					<a href="#username" data-transition="slide" 
					style="text-align: right;" data-prefetch="true" 
					class="ui-input-btn ui-btn ui-icon-edit ui-btn-icon-right">
					<span style="float:left">名字</span>${currentUser.name}
					</a>
				</li>
				<li>
					<a href="#" data-transition="slide" 
					style="text-align: right;" data-prefetch="true" 
					class="ui-input-btn ui-btn">
					<span style="float:left">登录名</span>${currentUser.loginname}
					</a>
				</li>
				<li>
					<a href="#email" data-transition="slide" 
					style="text-align: right;" data-prefetch="true" 
					class="ui-input-btn ui-btn ui-icon-edit ui-btn-icon-right">
					<span style="float:left">邮箱</span>${currentUser.email}
					</a>
				</li>
				<li data-role="list-divider"></li>
				<li>
					<a href="#" data-transition="slide" 
					style="text-align: right;" data-prefetch="true" 
					class="ui-input-btn ui-btn ui-icon-edit ui-btn-icon-right">
					<span style="float:left">组织机构</span>${currentUser.org.name}
					</a>
				</li>
				</ul>
	</div>
	<div data-role="footer" data-position="fixed" data-theme="a">
		<p>Copyright 2014</p>
	</div>
</div><!-- /mainpage -->
<div data-role="page" id="password" class="jqm-demos">
	<div data-role="header"  data-position="fixed" data-theme="a">
		<h1>修改密码</h1>
		<a href="#" data-shadow="false" data-rel="back"
				data-iconshadow="false" data-transition="flip"
				class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-icon-carat-l ui-btn-icon-left">取消</a>
				<a href="javascript:submitForm()" 
				class="ui-btn ui-btn-right ui-corner-all ui-shadow ui-icon-check ui-btn-icon-left">确定</a>
	</div><!-- /header -->

	<div role="main" class="ui-content">
		<form name="passwordform" data-ajax="false"
				action="${root}/useraccount/savepasswordm" method="post">
				<input type="hidden" name="useraccountid"
					value="${currentUser.code}" />
				<label for="oldpassword">旧密码:            
				<input type="password"
					name="oldpassword" id="oldpassword" data-clear-btn="true" data-mini="true"></label>  
				<label for="newpassword">新密码:            
				<input type="password"
					name="newpassword" id="newpassword" data-clear-btn="true" data-mini="true"></label>  
				<label for="cpassword">确认密码:        
				<input type="password"
					name="cpassword" id="cpassword"  data-clear-btn="true" data-mini="true"></label>      
		</form>
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-theme="a">
		<h4>Copyright 2014</h4>
	</div><!-- /footer -->
</div><!-- /page password -->
<div data-role="page" id="username" class="jqm-demos">
	<div data-role="header"  data-position="fixed" data-theme="a">
		<h1>修改用户名</h1>
		<a href="#" data-shadow="false"  data-rel="back"
				data-iconshadow="false" data-transition="flip"
				class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-icon-carat-l ui-btn-icon-left">取消</a>
				<a href="javascript:submitUserNameForm()" 
				class="ui-btn ui-btn-right ui-corner-all ui-shadow ui-icon-check ui-btn-icon-left">确定</a>
	</div><!-- /header -->

	<div role="main" class="ui-content">
		<form name="usenameform" data-ajax="false"
				action="${root}/useraccount/savem" method="post">
				<input type="hidden" name="code"
					value="${currentUser.code}" />
				<input type="text"
					name="name" id="name" value="${currentUser.name}" data-clear-btn="true" data-mini="true"></label>  
		</form>
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-theme="a">
		<h4>Copyright 2014</h4>
	</div><!-- /footer -->
</div><!-- /page username -->

<div data-role="page" id="email" class="jqm-demos">
	<div data-role="header"  data-position="fixed" data-theme="a">
		<h1>用户邮箱</h1>
		<a href="#" data-shadow="false" data-rel="back"
				data-iconshadow="false" data-transition="flip"
				class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-icon-carat-l ui-btn-icon-left">取消</a>
				<a href="javascript:submitEmailForm()" 
				class="ui-btn ui-btn-right ui-corner-all ui-shadow ui-icon-check ui-btn-icon-left">确定</a>
	</div><!-- /header -->

	<div role="main" class="ui-content">
		<form name="emailform" data-ajax="false"
				action="${root}/useraccount/savem" method="post">
				<input type="hidden" name="code"
					value="${currentUser.code}" />
				<input type="text"
					name="email" id="email" value="${currentUser.email}" data-clear-btn="true" data-mini="true"></label>  
		</form>
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-theme="a">
		<h4>Copyright 2014</h4>
	</div><!-- /footer -->
</div><!-- /page username -->
<script>
		var qrcode = new QRCode("qrcode");
    	function makeCode() {
    		// 获取链接
    		var ele = window.location.href;
    		// 生成二维码并放置在元素中
    		qrcode.makeCode(ele);
    	}
    	function showCode(){
    		makeCode();
    		$('#code').popup('open');
    	}
</script>
</body>
</html>
