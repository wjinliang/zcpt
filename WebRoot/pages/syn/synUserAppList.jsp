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
<title>单点登录</title>
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
							系统列表 <small>单点登录</small>
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
									<i class="icon-list"></i>列表
								</div>
							</div>
							<div class="portlet-body">
								<!--  
								<p>
									<button type="button" onclick="newItem()" class="btn green">
										<i class="icon-plus"></i>添加
									</button>
									<button type="button" onclick="deleteItems()" class="btn red">
										<i class="icon-minus-sign"></i>删除 
									</button>
								</p>
								-->
								<table class="table table-condensed table-hover"
									id="useraccount_table">
									<colgroup>
										<col width="5%"></col>
										<col ></col>
										<col ></col>
										<col ></col>
										<col ></col>
										<col width="20%"></col>
									</colgroup>
									<thead>
										<tr>
											<th>#</th>
											<th>系统名称</th>
											<th>系统标示</th>
											<th>单点登录</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${synAppList}" var="app" varStatus="status">
											<tr >
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${app.appName}</td>
												<td style="vertical-align: middle;">${app.appCode}</td>
												<td style="vertical-align: middle;"><a href="${root}/synuseraccount/ssoServiceBySession?xtbs=${app.appCode}" target="_blank">登录</a></td>
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
	<!-- END JAVASCRIPTS -->
	<script>
	function gopage(thispage){
		if(thispage>${totalpage-1}){
			thispage=${totalpage-1};
		}
		window.location.href="${root}/syn/listSynApp?thispage="+thispage;
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
</html>
