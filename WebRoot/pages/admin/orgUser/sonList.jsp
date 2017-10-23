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
<title>组织用户管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
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
							组织机构用户管理 <small>组织机构用户增删改查、角色授权、重置密码</small>
						</h3>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span3">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>区划
								</div>
							</div>
							<div class="portlet-body">
							<ul id="treeOrg" style="font-weight: bold" class="ztree"></ul>
							</div>
						</div>
					</div>
					<div class="span9">
						<input type="hidden" name="divisionid" id="divisionid" value="${divisionid}">
						<input type="hidden" name="parentid" id="parentid" value="${parentid}">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>组织机构管理
								</div>
							</div>
							<div class="portlet-body">
								<p>
									<c:if test="${IsTopDivision}">								
									<button type="button" onclick="newItem()" class="btn green">
										<i class="icon-plus"></i>添加组织机构
									</button>
									<button type="button" onclick="deleteItems()" class="btn red">
										<i class="icon-minus-sign"></i>删除组织机构
									</button>
								</c:if>
								<button type="button" onclick="gopage('0');" class="btn" style="float:right">
										查询 
									</button>
									<i style="float:right">&nbsp;&nbsp;</i>
									<input type="text" class="m-wrap" id="tjcx" style="float:right" value="${param.tj}">
									<label class="control-label" style="float:right;font-size: 18px;text-align: center">名称搜索:&nbsp;&nbsp;</label>
								</p>
								<table class="table table-condensed table-hover"
									id="useraccount_table">
									<colgroup>
										<col width="5%"></col>
										<col width="5%"></col>
										<col ></col>
										<col ></col>
										<col ></col>
										<col ></col>
										<col width="20%"></col>
									</colgroup>
									<thead>
										<tr>
											<th style="width:8px;"><input type="checkbox"
												class="group-checkable"
												data-set="#useraccount_table .checkboxes" /></th>
											<th>#</th>
											<th>组织名</th>
											<th>组织编码</th>
											<th>所在区划</th>
											<th>查看下级组织</th>
											<th>查看用户</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${orgList}" var="org" varStatus="status">
											<tr >
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${org.id}" /></td>
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;"><c:if test="${IsTopDivision}">	
												<a href="${root}/orgAndUser/form/edit?orgid=${org.id}&flag=0&divisionid=${divisionid}">${org.name}</a>
												</c:if><c:if test="${!IsTopDivision}">	
												${org.name}
												</c:if></td>
												<td style="vertical-align: middle;">${org.code}</td>
												<td style="vertical-align: middle;">${org.division.name}</td>
												<td style="vertical-align: middle;"><a href="${root}/orgAndUser/listSon?orgid=${org.id}&tj=${param.tj}">查看</></td>
												<td style="vertical-align: middle;"><a href="${root}/orgAndUser/listUsers?orgid=${org.id}">查看</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								${pagination}
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
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	<script>
		jQuery(document).ready(function() {
			jQuery('#useraccount_table .group-checkable').change(function() {
				var set = jQuery(this).attr("data-set");
				var checked = jQuery(this).is(":checked");
				jQuery(set).each(function() {
					if (checked) {
						$(this).attr("checked", true);
					} else {
						$(this).attr("checked", false);
					}
				});
				jQuery.uniform.update(set);
			});
			$.fn.zTree.init($("#treeOrg"), settingMenu, zNodesMenu);
			zTree = $.fn.zTree.getZTreeObj("treeOrg");
			selectNodes();
		});
		var settingMenu = {
				check : {
					enable : false
				},
				async: {
					enable: true,
					url:"${root}/orgAndUser/loadSonDivision",
					autoParam:["id=divisionid"]
				},
			data : {
				simpleData : {
					enable : true
					}
				},
			callback : {
				onClick : goorgpage
			}
			};
			var zNodesMenu=${orgStr};
		function selectNodes(){
 				var node = zTree.getNodeByParam("id", "${orgid}", null);
 				zTree.selectNode(node);
 			}
 		function goorgpage(){
				if (zTree.getSelectedNodes()[0]) {
					var orgid = zTree.getSelectedNodes()[0].id;
					document.getElementById('divisionid').value=orgid;
					gopage1("0");
				}
			}
			function getNodes(treeNode,ids){
				var nodes = treeNode.children;
				if(nodes!=null){
					for(var i=0;i<nodes.length;i++){
						ids.push(nodes[i].id);
						getNodes(nodes[i],ids);
					}
				}
			}
		function gopage1(thispage){
			var tj=$("#tjcx").val();
			var divisionid=document.getElementById('divisionid').value;
			window.location.href="${root}/orgAndUser/listOrgs?thispage="+thispage+"&divisionid="+divisionid+"&tj="+tj;
		}
		function gopage(thispage){
			var tj=$("#tjcx").val();
			var orgid=document.getElementById('parentid').value;
			window.location.href="${root}/orgAndUser/listSon?thispage="+thispage+"&orgid="+orgid+"&tj="+tj;
		}
		function nextpage(){
				if(${thispage}<${totalpage-1}){
					gopage(${thispage+1});
				}
		}
		function prepage(){
				if(${thispage}>0){
					gopage(${thispage-1});
				}
		}
		function newItem(){
			var divisionid=document.getElementById('divisionid').value;
			window.location.href="${root}/orgAndUser/form/new?divisionid="+divisionid+"&flag=1&orgid=${parentid}";
		}
		function deleteItem(id) {
				window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "userid=" + id,
						url : '${root}/synuser/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}else if(data == "false"){
								alert("删除同步时出现错误，请查看同步日志！");
							}
						}
					});
				}
			});
	}
	function getcheckedids(){
	var ids=[];
	var cbs = document.getElementsByName("checkboxes");
	for(var i = 0 ; i < cbs.length; i++){
		if(cbs[i].checked == true){
			ids.push(cbs[i].value);
		}
	}
	return ids;
	}
	function deleteItems(){
		var ids = getcheckedids();
		if(ids.length>0){
				window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "orgid=" + ids,
						url : '${root}/synorg/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}else if(data == "false"){
								alert("删除同步时出现错误，请查看同步日志！");
							}else if(data=="403"){
								alert("您没有这个权限,请联系上级管理员!");
							}else{	
								alert("操作失败");
							}
						}
					});
				}
			});
			}else{
				window.parent.bootbox.alert("请选择要删除的选项！");
			}
	}
	</script>

	<!-- END JAVASCRIPTS -->
</html>
