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
<title>公告管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->

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
				<h3 class="page-title">公告列表</h3>
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
						<i class="icon-angle-right"></i></li>
					<li><a href="${root}/notice/list">公告列表</a>
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
						<p>
							<button type="button" onclick="newItem()" class="btn green">
								<i class="icon-plus"></i>添加
							</button>
							<button type="button" onclick="deleteItems()" class="btn red">
								<i class="icon-minus-sign"></i>删除
							</button>
						</p>
						<table class="table table-condensed table-hover" id="notice_table">
							<colgroup>
								<col width="5%"></col>
								<col width="5%"></col>
								<col width="20%"></col>
								<col width="50%"></col>
								<col width="20%"></col>
							</colgroup>
							<thead>
								<tr>
									<th style="width:8px;"><input type="checkbox"
										class="group-checkable" data-set="#notice_table .checkboxes" />
									</th>
									<th>#</th>
									<th>公告标题</th>
									<th>发布时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${notices}" var="notice" varStatus="status">
									<tr>
										<td style="vertical-align: middle;"><input
											type="checkbox" class="checkboxes" name="checkboxes"
											value="${notice.noticeId}" />
										</td>
										<td style="vertical-align: middle;">
											${thispage*pagesize+status.count}
											<c:if test="${notice.isTop==1}"><i class="icon-upload"></i></c:if>
										</td>
										<td style="vertical-align: middle;"><a
											href="javascript:viewItem('${notice.noticeId}')">${notice.noticeTitle}</a>
										</td>
										<td style="vertical-align: middle;">${notice.noticeDate}</td>
										<td style="vertical-align: middle;">
											<div class="btn-group">
												<a class="btn mini green" href="#" data-toggle="dropdown">
													<i class="icon-cog"></i>
															<!--[if gt IE 7]>&nbsp;<![endif]-->
															<!--[if lte IE 7]>操作&nbsp;▽<![endif]--><i class="icon-angle-down"></i>
												</a>
												<ul class="dropdown-menu">
													<li><a
														href="javascript:viewItem('${notice.noticeId}')"> <i
															class="icon-list-alt"></i> 查看 </a></li>
													<li><a
														href="javascript:editItem('${notice.noticeId}')"> <i
															class="icon-pencil"></i> 修改 </a></li>
													<li><a href="javascript:setTop('${notice.noticeId}')"> <i class="icon-upload"></i>置顶 </a></li>
													<li><a href="javascript:cancelTop('${notice.noticeId}')"> <i class="icon-download"></i>取消置顶
													</a></li>
													<li><a
														href="javascript:deleteItem('${notice.noticeId}')"> <i
															class="icon-remove"></i>删除 </a></li>
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
			jQuery('#notice_table .group-checkable').change(function() {
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
				window.location.href="${root}/notice/list?thispage="+thispage;
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
			window.location.href="${root}/notice/form/new";
		}
		function editItem(id){
			window.location.href="${root}/notice/form/edit?noticeId="+id;
		}
		function viewItem(id){
			window.location.href="${root}/notice/form/view?noticeId="+id;
		}
	function setTop(id) {
		$.ajax({
			type : "POST",
			data : "noticeId=" + id,
			url : '${root}/notice/setTop',
			success : function(data) {
				if (data == "ok") {
					window.location.reload();
				}
			}
		});
			
}

function cancelTop(id) {
		$.ajax({
			type : "POST",
			data : "noticeId=" + id,
			url : '${root}/notice/cancelTop',
			success : function(data) {
				if (data == "ok") {
					window.location.reload();
				}
			}
		});
			
}	
	function deleteItem(id) {
			window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "noticeId=" + id,
						url : '${root}/notice/delete',
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
						data : "noticeId=" + ids,
						url : '${root}/notice/delete',
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
