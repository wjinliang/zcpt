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
<title>用户管理</title>
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
							用户管理 <small>用户关联</small>
						</h3>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<input type="hidden" name="orgid" id="orgid" value="${orgid}">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>列表
								</div>
							</div>
							<div class="portlet-body">
								<p>
									<button type="button" onclick="newItem()" class="btn green">
										<i class="icon-plus"></i>添加关联
									</button>
									<button type="button" onclick="deleteItems()" class="btn red">
										<i class="icon-minus-sign"></i>取消关联
									</button>
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
											<th>用户(登录名)</th>
											<th>所在单位</th>
											<th>系统标识</th>
											<th>登录次数</th>
											<th>上次登录</th>
											<th>上次登录IP</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${userList}" var="useraccount" varStatus="status">
											<tr >
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${useraccount.code}" /></td>
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${useraccount.name}(${useraccount.loginname})</td>
												<td style="vertical-align: middle;">${useraccount.org.name}</td>
												<td style="vertical-align: middle;">${useraccount.systemId}</td>
												<td style="vertical-align: middle;">${useraccount.loginCount}</td>
												<td style="vertical-align: middle;">${useraccount.lastLoginTime}</td>
												<td style="vertical-align: middle;">${useraccount.remoteIpAddr}</td>
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
			function getNodes(treeNode,ids){
				var nodes = treeNode.children;
				if(nodes!=null){
					for(var i=0;i<nodes.length;i++){
						ids.push(nodes[i].id);
						getNodes(nodes[i],ids);
					}
				}
			}
		function gopage(thispage){
			window.location.href="${root}/orgAndUser/listMergeUsers?thispage="+thispage+"&userid=${userid}";
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
			window.showModalDialog('${root}/orgAndUser/gotoMergeUser?userid=${userid}',window,'dialogHeight=500;dialogWidth=960'); 
		}
		function deleteItem(id) {
				window.bootbox.confirm("确定取消关联吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "userid=" + id, 
						url : '${root}/orgAndUser/deleteMerge',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}else if(data == "false"){
								alert("取消关联时出现错误！");
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
				window.bootbox.confirm("确定取消关联吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "userid=" + ids,
						url : '${root}/orgAndUser/deleteMerge',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}else{
								alert("取消关联时出现错误！");
							}
						}
					});
				}
			});
			}else{
				window.parent.bootbox.alert("请选择要取消关联的选项！");
			}
	}
	
	
	</script>

	<!-- END JAVASCRIPTS -->
</html>
