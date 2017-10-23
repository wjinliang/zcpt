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
<title>附件管理</title>
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
							附件管理 <small>下载、删除</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="${root}/file/list">附件管理</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>管理页面
								</div>
							</div>
							<div class="portlet-body">
								<p>
									<button type="button" onclick="deleteItems()" class="btn red">
										批量删除
									</button>
								</p>
								<table class="table table-condensed table-hover" id="file_table">
									<colgroup>
										<col width="5%"></col>
										<col width="5%"></col>
										<col></col>
										<col></col>
										<col></col>
										<col></col>
										<col></col>
										<col width="10%"></col>
									</colgroup>
									<thead>
										<tr>
											<th style="width:8px;"><input type="checkbox"
												class="group-checkable" data-set="#file_table .checkboxes" />
											</th>
											<th>#</th>
											<th>文件名</th>
											<th>文件类型</th>
											<th>文件大小</th>
											<th>文件创建时间</th>
											<th>是否使用</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${files}" var="file" varStatus="status">
											<tr>
												<td style="vertical-align: middle;"><input
													type="checkbox" class="checkboxes" name="checkboxes"
													value="${file.id}" />
												</td>
												<td style="vertical-align: middle;">
													${thispage*pagesize+status.count}</td>
												<td style="vertical-align: middle;">${file.name}</td>
												<td style="vertical-align: middle;">${file.type}</td>
												<td style="vertical-align: middle;">${file.filesize2}</td>
												<td style="vertical-align: middle;">${file.cDate}</td>
												<td style="vertical-align: middle;"><c:if
														test="${file.saveFlag=='1'}">是</c:if> <c:if
														test="${file.saveFlag=='0'}">否</c:if></td>
												<td style="vertical-align: middle;">
													<div class="btn-group">
														<a class="btn mini green" href="#" data-toggle="dropdown">
															<i class="icon-cog"></i>
															<!--[if gt IE 7]>&nbsp;<![endif]-->
															<!--[if lte IE 7]>操作&nbsp;▽<![endif]--><i class="icon-angle-down"></i>
														</a>
														<ul class="dropdown-menu">
															<c:if test="${file.saveFlag=='1'}">
																<li><a href="javascript:deleteItem('${file.id}')">
																		<i class="icon-remove"></i> 删除 </a></li>
															</c:if>
															<c:if test="${file.saveFlag=='0'}">
																<li><a href="javascript:deleteReal('${file.id}')">
																		<i class="icon-remove"></i> 物理删除 </a></li>
															</c:if>
															<li><a href="${file.url}" target="_blank">
																	<i class=" icon-download-alt"></i>链接下载 </a></li>
															<li><a href="javascript:downloadFile('${file.id}')" target="_blank">
																	<i class=" icon-download-alt"></i>下载 </a></li>
														</ul>
													</div>
												</td>
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
			jQuery('#file_table .group-checkable').change(function() {
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
				window.location.href="${root}/file/list?thispage="+thispage;
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
	function deleteItem(id) {
				window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "fileid=" + id,
						url : '${root}/file/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}
						}
					});
				}
			});
			}
			
			function deleteReal(id) {
				window.bootbox.confirm("确定物理删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "fileid=" + id,
						url : '${root}/file/deleteReal',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}
						}
					});
				}
			});
			
			}
			function deleteItems() {
				var ids = getcheckedids();
				if(ids.length>0){
					window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "fileid=" + ids,
						url : '${root}/file/delete',
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
		
		function downloadFile(id){
			window.location.href="${root}/file/download/"+id;
		}
	</script>

	<!-- END JAVASCRIPTS -->
</html>
