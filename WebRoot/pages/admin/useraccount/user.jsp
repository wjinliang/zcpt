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
<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<%@include file="../include/style.jsp"%>
</head>
<body class="page-full-width">
<div class="page-content">
<div class="row-fluid" >
	<div  class="span12" >
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>用户关联
								</div>
							</div>
							<div class="portlet-body">
							<!-- <ul id="treeOrg" style="font-weight: bold" class="ztree"></ul> -->
							<p>
							<input type="hidden" value="${userid }" name="userid" id="userid">
								<button type="button" onclick="gopage(0);" class="btn" style="float:right">
										查询 
									</button>
									<i style="float:right">&nbsp;&nbsp;</i>
									<input type="text" class="m-wrap" id="tjcx" style="float:right" value="${param.tj}">
									<label class="control-label" style="float:right;font-size: 18px;text-align: center">用户名搜索:&nbsp;&nbsp;</label>
									<i style="float:right">&nbsp;&nbsp;</i>
									<select id="xt" style="float:right">
										<option value="all">==请选择==</option>
										<c:forEach items="${appList}" var="app" varStatus="status">
											<option value="${app.appName}" <c:if test="${app.appName==param.xt}">selected="selected"</c:if>>${app.appName}</option>
										</c:forEach>
									</select>
									<label class="control-label" style="float:right;font-size: 18px;text-align: center">系统标识:&nbsp;&nbsp;</label>
								
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
									</colgroup>
									<thead>
										<tr>
											<th style="width:8px;"><input type="checkbox"
												class="group-checkable"
												data-set="#useraccount_table .checkboxes" /></th>
											<th>#</th>
											<th>用户</th>
											<th>登录名</th>
											<th>机构名称</th>
											<th>系统标识</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${userList}" var="user" varStatus="status">
											<tr >
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${user.code }" /></td>
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${user.name }</td>
												<td style="vertical-align: middle;">${user.loginname }</td>
												<td style="vertical-align: middle;">${user.org.name }</td>
												<td style="vertical-align: middle;">${user.systemId }</td>
												<td style="vertical-align: middle;">
													<button type="button" onclick="mergUser('${userid }','${user.code}');" class="btn green" >
										关联 
									</button>
													</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								${pagination}
							</div>
						</div>
						</div>
	<div class="form-actions">
<!-- 	<button type="button" onclick="synUser()" class="btn green"> -->
<!-- 			<i>确&nbsp;&nbsp;定</i> -->
<!-- 	</button> -->
	<button type="button" onclick="window.close();" class="btn red">
			<i>关&nbsp;&nbsp;闭</i>
	</button>
	<div>
</div>
</body>
	<script type="text/javascript" src="${root}/themes/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	<SCRIPT type="text/javascript">
	/* var setting = {
			check: {
				enable: true,
				chkStyle: "checkbox",
				chkboxType: { "Y": "ps", "N": "ps" }
			},
			async: {
				enable: true,
				url:"${root}/orgAndUser/loadSonOrgAndUser?userid=${userid}",
				autoParam:["id=orgid"]
			},
			data: {
				simpleData: {
					enable: true
				}
			}
	};

	var zNodes =${orgStr};
	$(document).ready(function(){
		$.fn.zTree.init($("#treeOrg"), setting, zNodes);
	}); */
	function mergUser(userid,mergeid){
        window.dialogArguments.location.href="${root}/orgAndUser/mergeUser?userid=${userid}&userIds="+mergeid;
        window.close();
	}
	function gopage(thispage){
		if(thispage>${totalpage-1}){
			thispage=${totalpage-1};
		}
		var xt=$("#xt").val();
		var tj=$("#tjcx").val();
		var userid=document.getElementById('userid').value;
		window.location.href="${root}/orgAndUser/gotoMergeUser?thispage="+thispage+"&userid="+userid+"&tj="+tj+"&xt="+xt
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
</SCRIPT>
</html>
