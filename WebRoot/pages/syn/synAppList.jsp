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
<title>系統管理</title>
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
		<!--[if lt IE 9]>
		<script src="<%=basePath%>/themes/assets/js/html5shiv.min.js"></script>
		<script src="<%=basePath%>/themes/assets/js/respond.min.js"></script>
		<![endif]-->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<h3 class="page-title">
							系统管理 <small>组织用户同步</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/syn/listSynApp">主页</a>
								<i class="icon-angle-right"></i>
							</li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>管理
								</div>
							</div>
							<div class="portlet-body">
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
											<th>系统名称</th>
											<th>系统编号</th>
											<th>系统同步类型</th>
											<th>系统状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${appList}" var="app" varStatus="status">
											<tr >
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${app.id}" /></td>
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${app.appName}</td>
												<td style="vertical-align: middle;">${app.appCode}</td>
												<td style="vertical-align: middle;">${app.synType}</td>
												<td style="vertical-align: middle;"><c:choose>
												<c:when test="${app.status=='1'}">
													<font color="green">启用</font>
												</c:when>
												<c:otherwise>
													<font color="red">禁用</font>
												</c:otherwise>
											</c:choose></td>
												<td style="vertical-align: middle;">
													<div class="btn-group">
														<a class="btn mini green" href="#" data-toggle="dropdown">
															<i class="icon-cog"></i>
															<!--[if gt IE 7]>&nbsp;<![endif]-->
															<!--[if lte IE 7]>操作&nbsp;▽<![endif]--><i class="icon-angle-down"></i>
														</a>
														<ul class="dropdown-menu">
															<%-- <li>
															<a href="javascript:synDivision('${app.id}')"> <i class="icon-list-alt"></i> 区划同步
															</a>
															</li> --%>
															<li><a href="javascript:synOrg('${app.id}')"> <i class="icon-list-alt"></i>
																	组织同步 </a>
															</li>
															<li>
															<a href="javascript:synUser('${app.id}')"> <i class="icon-list-alt"></i> 用户同步
															</a>
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
	<%@include file="../admin/include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../admin/include/js.jsp"%>
	<script>
	function newItem(){
			window.location.href="${root}/syn/form/new";
		}
	function deleteItem(id) {
		window.bootbox.confirm("确定删除吗？", function(result) {
			if (result) {
				$.ajax({
				type : "POST",
				data : "appid=" + id,
				url : '${root}/syn/delete',
				success : function(data) {
					if (data == "ok") {
						window.location.reload();
					}
				}
			});
		}
	});
}
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
	function deleteItems(){
		var ids = getcheckedids();
		if(ids.length>0){
				window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "appid=" + ids,
						url : '${root}/syn/delete',
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
	function synDivision(id){ 
		window.location.href="${root}/syn/listSynDivision?appId="+id;
		}
	function synOrg(id){ 
		window.location.href="${root}/syn/listSynOrg?appId="+id;
		}
	function synUser(id){
		window.location.href="${root}/syn/listSynUser?appId="+id;
		}
	function gopage(thispage){
		if(thispage>${totalpage-1}){
			thispage=${totalpage-1};
		}
		window.location.href="${root}/syn/listApp?thispage="+thispage+"&opType=syn";
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
	</script>
	<!-- END JAVASCRIPTS -->
</html>
