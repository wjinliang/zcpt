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
<title>组织管理</title>
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
							组织同步管理 <small>组织同步</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/syn/listSynApp">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="${root}/syn/listApp?opType=syn">组织同步管理</a></li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<input type="hidden" name="appId" id="appId" value="${appId}">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>管理
								</div>
							</div>
							<div class="portlet-body">
								<p><c:if test="${state=='1'}">
									<button type="button" onclick="addSyn()" class="btn green">
										<i class="icon-plus"></i>组织同步
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
											<th>组织名称</th>
											<th>组织编码</th>
											<th>同步时间</th>
											<c:if test="${state=='1'}">
											<th>操作</th>
											</c:if>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${orgList}" var="org" varStatus="status">
											<tr >
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${org[0]}" /></td>
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${org[1]}</td>
												<td style="vertical-align: middle;">${org[2]}</td>
												<td style="vertical-align: middle;">${org[3]}</td>
												<c:if test="${state=='1'}">
												<td style="vertical-align: middle;">
													<div class="btn-group">
														<a class="btn mini green" href="#" data-toggle="dropdown">
															<i class="icon-cog"></i>
															<!--[if gt IE 7]>&nbsp;<![endif]-->
															<!--[if lte IE 7]>操作&nbsp;▽<![endif]--><i class="icon-angle-down"></i>
														</a>
														<ul class="dropdown-menu">
															<li><a href="javascript:updateSyn('${org[0]}')"> <i class="icon-pencil"></i>
																	同步更新 </a>
															</li>
															<li><a href="javascript:deleteSyn('${org[0]}')"> <i class="icon-remove"></i>
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
		window.showModalDialog('${root}/syn/gotoSynOrg?appId=${appId}',window,'dialogHeight='+height+';dialogWidth='+width) 
	}
	function updateSyn(orgId){
		window.location.href="${root}/syn/synUpdateOrg?appId=${appId}&orgIds="+orgId;
	}
	function deleteSyn(orgId){
		window.location.href="${root}/syn/synDeleteOrg?appId=${appId}&orgIds="+orgId;
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
		window.location.href="${root}/syn/listSynOrg?thispage="+thispage+"&appId=${appId}";
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
