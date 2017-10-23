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
<title>角色管理-菜单组授权</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
	<!-- END PAGE LEVEL STYLES -->
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
						<h3 class="page-title">
							角色授权 <small>选择角色菜单菜单组</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="${root}/userrole/list">角色管理</a> <i
								class="icon-angle-right"></i>
							</li>
							<li><a>授权菜单组</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>菜单组
								</div>
							</div>
							<div class="portlet-body form">
								<div id="success" class="alert alert-success hide">

									<button class="close" data-dismiss="alert"></button>

									<strong>授权成功!</strong> 即将跳转回管理页面...

								</div>
								<!-- BEGIN FORM-->

								<div class="form-horizontal form-view">
									<div class="row-fluid">
										<div class="span12 ">
											<ul id="treeMenuGroup" class="ztree"></ul>
										</div>
									</div>
									<!--/row-->
									<div class="form-actions">
										<button type="button" onclick="setMenuGroups('${userrole.code}')"
											class="btn blue">
											<i class="icon-pencil"></i> 确认
										</button>
										<button type="button" onclick="window.history.back();"
											class="btn">返回</button>
									</div>
								</div>

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

		<!-- BEGIN PAGE LEVEL PLUGINS -->

		<script type="text/javascript"
			src="<%=basePath%>themes/media/js/select2.min.js"></script>

		<script type="text/javascript"
			src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>

		<script type="text/javascript"
			src="${root}/themes/zTree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript"
			src="${root}/themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>

		<!-- END PAGE LEVEL PLUGINS -->
		<script type="text/javascript">
			$(document).ready(function() {
				$.fn.zTree.init($("#treeMenuGroup"), settingMenu, zNodesMenu);
			});
			var settingMenu = {
				check : {
					enable : true,
					chkboxType : {
						"Y" : "s",
						"N" : "s"
					}
				},
				data : {
					simpleData : {
						enable : true
					}
				}
			};
			var zNodesMenu = ${menugroupStr};
			function setMenuGroups() {
				var zTree = $.fn.zTree.getZTreeObj("treeMenuGroup");
				var nodes = zTree.getCheckedNodes();
				var menugroupids = [];
				for ( var i = 0; i < nodes.length; i++) {
					menugroupids.push(nodes[i].id);
				}
				$.ajax({
					url : "${root}/userrole/setmenugroups",
					type : "POST",
					data : "userroleid=${userroleid}&menugroupids=" + menugroupids,
					success : function(data) {
						if (data == "ok") {
							$("#success").fadeIn(1500, function() {
								window.location.href = "${root}/userrole/list";
							});
						}
					}
				});
			}
		</script>

		<!-- END JAVASCRIPTS -->
</html>
