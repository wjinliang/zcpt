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
<title>菜单组管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
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
							菜单组管理 <small>菜单组增删改查、设置菜单</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="${root}/menugroup/list">菜单组管理</a></li>
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
								<p>
									<button type="button" onclick="newItem()" class="btn green">
										<i class="icon-plus"></i>添加
									</button>
									<button type="button" onclick="deleteItems()" class="btn red">
										<i class="icon-minus-sign"></i>删除 
									</button>
								</p>
								<table class="table table-condensed table-hover"
									id="menugroup_table">
									<colgroup>
										<col width="5%"></col>
										<col width="5%"></col>
										<col width="70%"></col>
										<col width="20%"></col>
									</colgroup>
									<thead>
										<tr>
											<th style="width:8px;"><input type="checkbox"
												class="group-checkable"
												data-set="#menugroup_table .checkboxes" /></th>
											<th>#</th>
											<th>菜单组名称</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${menugroups}" var="menugroup" varStatus="status">
											<tr >
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${menugroup.id}" /></td>
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${menugroup.name}</td>
												<td style="vertical-align: middle;">
													<div class="btn-group">
														<a class="btn mini green" href="#" data-toggle="dropdown">
															<i class="icon-cog"></i>
															<!--[if gt IE 7]>&nbsp;<![endif]-->
															<!--[if lte IE 7]>操作&nbsp;▽<![endif]--><i class="icon-angle-down"></i>
														</a>
														<ul class="dropdown-menu">
															<li><a href="javascript:viewItem('${menugroup.id}')"> <i class="icon-list-alt"></i>
																	查看 </a></li>
															<li><a href="javascript:editItem('${menugroup.id}')"> <i class="icon-pencil"></i> 修改
															</a>
															</li>
															<li><a href="javascript:setMenus('${menugroup.id}')"> <i class="icon-legal"></i>设置菜单 </a>
															</li>
															<li><a href="javascript:deleteItem('${menugroup.id}')"> <i class="icon-remove"></i>删除 </a>
															</li>
														</ul>
													</div></td>
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
	<script>
		jQuery(document).ready(function() {
			jQuery('#menugroup_table .group-checkable').change(function() {
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
				window.location.href="${root}/menugroup/list?thispage="+thispage;
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
			window.location.href="${root}/menugroup/form/new";
		}
		function editItem(id){
			window.location.href="${root}/menugroup/form/edit?menugroupid="+id;
		}
		function viewItem(id){
			window.location.href="${root}/menugroup/form/view?menugroupid="+id;
		}
		function setMenus(id) {
			var title = "选择菜单";
			var url = "${root}/menugroup/selectmenus?menugroupid=" + id;
			window.location.href=url;
		}
		function deleteItem(id) {
				window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "menugroupid=" + id,
						url : '${root}/menugroup/delete',
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
						data : "roleid=" + ids,
						url : '${root}/menugroup/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}
						}
					});
				}
			});
			}else{
				window.bootbox.alert("请选择要删除的选项！");
			}
	}
	</script>

	<!-- END JAVASCRIPTS -->
</html>
