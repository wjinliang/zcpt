<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
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
<title>消息中心</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link href="<%=basePath%>themes/media/css/bootstrap-tag.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>themes/media/css/jquery.fancybox.css" rel="stylesheet" />
<link href="<%=basePath%>themes/media/css/bootstrap-wysihtml5.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>themes/media/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" >
<link href="<%=basePath%>themes/media/css/inbox.css" rel="stylesheet" type="text/css" />
</head>
<!-- END HEAD -->

<!-- BEGIN HEADER -->
<%@include file="../include/head.jsp"%>
<!-- END HEADER -->
<!-- BEGIN SIDEBAR -->
<%@include file="../include/sidebar.jsp"%>
<!-- END SIDEBAR -->
<!-- BEGIN PAGE -->
<div class="page-content">
	<!-- BEGIN PAGE CONTAINER-->
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<h3 class="page-title">消息中心</h3>
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
						<i class="icon-angle-right"></i>
					</li>
					<li><a href="${root}/message/message_center">消息中心</a></li>
				</ul>
			</div>
		</div>
		<div class="row-fluid inbox">

			<div class="span2">

				<ul class="inbox-nav margin-bottom-10">

					<li class="compose-btn"><a href="javascript:;"
						data-title="Compose" class="btn green"> <i class="icon-edit"></i>
							写站内信 </a></li>

					<li class="inbox active"><a href="javascript:;" class="btn"
						data-title="收件箱">收件箱</a> <b></b></li>
						
					<li class="mark"><a href="javascript:;" class="btn"
						data-title="星标信息">星标信息  <i class="icon-star"></i></a>  <b></b></li>

					<li class="sent"><a class="btn" href="javascript:;"
						data-title="发件箱">发件箱</a><b></b>
					</li>

					<li class="draft"><a class="btn" href="javascript:;"
						data-title="草稿">草稿</a><b></b>
					</li>

					<li class="trash">
					<a class="btn" href="javascript:;"
						data-title="回收站">回收站</a>	
					<b></b>
					</li>

				</ul>

			</div>

			<div class="span10">

				<div class="inbox-header">

					<h1 class="pull-left">收件箱</h1>

					<form action="#" class="form-search pull-right">

						<div class="input-append">

							<input class="m-wrap" type="text" placeholder="搜索站内信">

							<button class="btn green" type="button">搜索</button>
						</div>

					</form>

				</div>
				<div id="note" class="alert alert-success hide">
					<button class="close" data-dismiss="alert"></button>
					<span id="note_msg">操作成功！</span>
				</div>
				<div class="inbox-loading alert alert-info">加载中...</div>
				<div class="inbox-content"></div>

			</div>

		</div>

	</div>
</div>
<!-- END PAGE CONTAINER-->
</div>
<!-- END PAGE -->
<!-- BEGIN FOOTER -->
<%@include file="../include/foot.jsp"%>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../include/js.jsp"%>
<script src="<%=basePath%>themes/media/js/bootstrap-tag.js"
	type="text/javascript"></script>
<script src="<%=basePath%>themes/media/js/jquery.tagsinput.min.js"
	type="text/javascript"></script>
<script src="<%=basePath%>themes/media/js/jquery.fancybox.pack.js"
	type="text/javascript"></script>
<script src="<%=basePath%>themes/media/js/wysihtml5-0.3.0.js"
	type="text/javascript"></script>

<script
	src="<%=basePath%>themes/media/assets/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"
	type="text/javascript"></script>
<!-- BEGIN:File Upload Plugin JS files-->
<script src="<%=basePath%>themes/media/js/jquery.ui.widget.js"></script>
<script src="<%=basePath%>themes/media/js/load-image.min.js"></script>
<script src="<%=basePath%>themes/media/js/canvas-to-blob.min.js"></script>
<script src="<%=basePath%>themes/media/js/jquery.iframe-transport.js"></script>
<script src="<%=basePath%>themes/media/js/jquery.fileupload.js"></script>
<script src="<%=basePath%>themes/media/js/jquery.fileupload-ui.js"></script>
<script src="<%=basePath%>themes/media/js/jquery.tmpl.min.js"></script>
<script src="<%=basePath%>themes/media/js/inbox.js"></script>
<script charset="utf-8" src="${root}/themes/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="${root}/themes/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script type="text/javascript">
  	$(function(){
  		KindEditor.ready(function(K) {
                var editor1 = K.create('#editor_id', {
					uploadJson : '${root}/KE/file_upload',
					fileManagerJson : '${root}/KE/file_manager',
					allowFileManager : true
				});
		});
  	})
</script>
<script>
	jQuery(document).ready(function() {
		//定位到当前导航栏，参数为菜单id;
		Inbox.init();
	});
</script>

<!-- END JAVASCRIPTS -->
</html>
