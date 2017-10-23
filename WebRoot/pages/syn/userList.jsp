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
<title>用户列表</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../admin/include/style.jsp"%>
<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
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
							用户同步列表 <small>用户同步</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/syn/listSynApp">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="${root}/syn/listApp?opType=syn">用户同步列表</a></li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<input type="hidden" name="appId" id="appId" value="${appId}">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>列表
								</div>
							</div>
							<div class="portlet-body">
								<p>
								<c:if test="${state=='1'}">
									<button type="button" onclick="addSyn()" class="btn green">
										<i class="icon-plus"></i>用户同步
									</button>
								</c:if>
								</p>
								<table class="table table-condensed table-hover"
									id="useraccount_table">
									<colgroup>
										<col width="5%"></col>
										<col width="5%"></col>
										<col ></col>
										<col ></col>
										<col ></col>
										<c:if test="${state=='1'}">
										<col width="20%"></col>
										</c:if>
									</colgroup>
									<thead>
										<tr>
											<th style="width:8px;"><input type="checkbox"
												class="group-checkable"
												data-set="#useraccount_table .checkboxes" /></th>
											<th>#</th>
											<th>用户</th>
											<th>登录名</th>
											<th>同步时间</th>
											<c:if test="${state=='1'}">
											<th>操作</th>
											</c:if>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${userList}" var="user" varStatus="status">
											<tr >
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${user[0]}" /></td>
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${user[1]}</td>
												<td style="vertical-align: middle;">${user[2]}</td>
												<td style="vertical-align: middle;">${user[3]}</td>
												<c:if test="${state=='1'}">
												<td style="vertical-align: middle;">
													<div class="btn-group">
														<a class="btn mini green" href="#" data-toggle="dropdown">
															<i class="icon-cog"></i>
															<!--[if gt IE 7]>&nbsp;<![endif]-->
															<!--[if lte IE 7]>操作&nbsp;▽<![endif]--><i class="icon-angle-down"></i>
														</a>
														<ul class="dropdown-menu">
															<li><a href="javascript:updateSyn('${user[0]}')"> <i class="icon-pencil"></i>
																	同步更新 </a>
															</li>
															<li><a href="javascript:deleteSyn('${user[0]}')"> <i class="icon-remove"></i>
																	取消同步 </a>
															</li>
														</ul>
													</div></td>
													</c:if>
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
	<!-- 
	<script type="text/javascript" src="${root}/themes/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	 -->
	<script>
	function addSyn(){
		var height=550;
		var width=800;
		window.showModalDialog('${root}/syn/gotoSynOrgUser?appId=${appId}',window,'dialogHeight='+height+';dialogWidth='+width) 
	}
	function updateSyn(userId){
		window.location.href="${root}/syn/synUpdateUser?appId=${appId}&userIds="+userId;
	}
	function deleteSyn(userId){
		window.location.href="${root}/syn/synDeleteUser?appId=${appId}&userIds="+userId;
	}
	$(document).ready(function(){
		var flag='${flag}';
		if(flag!=null && !flag==""){
			if(flag==0){
				var result='${result}';
				alert(result);
			}
			if(flag==1){
				var successCount='${successCount}';
				var errorCount='${errorCount}';
				alert("同步完成，其中成功"+successCount+"个，失败"+errorCount+"个")
			}
		}
	});
	function gopage(thispage){
		if(thispage>${totalpage-1}){
			thispage=${totalpage-1};
		}
		window.location.href="${root}/syn/listSynUser?thispage="+thispage+"&appId=${appId}";
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
