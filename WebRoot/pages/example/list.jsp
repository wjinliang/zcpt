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
<title>示例列表</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../admin/include/style.jsp"%>
</head>
<!-- END HEAD -->

<!-- BEGIN HEADER -->
<%@include file="../admin/include/head.jsp"%>
<!-- END HEADER -->
<!-- BEGIN SIDEBAR -->
<%@include file="../admin/include/sidebar.jsp"%>
<!-- END SIDEBAR -->
<!-- BEGIN PAGE -->
<div class="page-content">
	<!-- BEGIN PAGE CONTAINER-->
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<h3 class="page-title">
					示例列表 <small>列表增删改查</small>
				</h3>
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
						<i class="icon-angle-right"></i></li>
					<li><a href="${root}/example/list">示例列表</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="portlet box green">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-list"></i>列表
						</div>
					</div>
					<div class="portlet-body">
						<div class="clearfix">
							<button type="button" onclick="newItem()" class="btn green">
								<i class="icon-plus"></i>添加
							</button>
							<button type="button" onclick="deleteItems()" class="btn red">
								<i class="icon-minus-sign"></i>删除
							</button>
						</div>
						<div class="dataTables_wrapper form-inline">
							<table class="table table-striped table-hover" id="example_table">
								<colgroup>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="70%"></col>
									<col width="20%"></col>
								</colgroup>
								<thead>
									<tr>
										<th style="width:8px;"><input type="checkbox"
											class="group-checkable" data-set="#example_table .checkboxes" />
										</th>
										<th>#</th>
										<th>示例名称</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${examples}" var="example" varStatus="status">
										<tr>
											<td style="vertical-align: middle;"><input
												type="checkbox" class="checkboxes" name="checkboxes"
												value="${example.id}" />
											</td>
											<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}</td>
											<td style="vertical-align: middle;">${example.name}</td>
											<td style="vertical-align: middle;"><a class="btn green"
												href="javascript:viewItem('${example.id}')">查看</a> <a
												class="btn green"
												href="javascript:editItem('${example.id}')">修改</a> <a
												class="btn red"
												href="javascript:deleteItem('${example.id}')">删除</a></td>
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
	</div>
	<!-- END PAGE CONTAINER-->
</div>
<!-- END PAGE -->
<!-- BEGIN FOOTER -->
<%@include file="../admin/include/foot.jsp"%>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../admin/include/js.jsp"%>
<script>
		jQuery(document).ready(function() {
			jQuery('#example_table .group-checkable').change(function() {
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
		});
		function gopage(thispage){
				window.location.href="${root}/example/list?thispage="+thispage;
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
			window.location.href="${root}/example/form/new";
		}
		function editItem(id){
			window.location.href="${root}/example/form/edit?exampleid="+id;
		}
		function viewItem(id){
			window.location.href="${root}/example/form/view?exampleid="+id;
		}
		function deleteItem(id) {
				window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "exampleid=" + id,
						url : '${root}/example/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
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
						data : "exampleid=" + ids,
						url : '${root}/example/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
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
