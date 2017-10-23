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
<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<%@include file="../admin/include/style.jsp"%>
<style type="text/css">
.myimg{
	height:18px;
}
</style>
</head>
<body class="page-full-width">
<div class="page-content">
<div class="row-fluid" >
	<div class="span12" >
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>组织同步
								</div>
							</div>
							<div class="portlet-body">
							<p>
								<c:if test="${not empty parentid}"> 
								<a type="button" href="${root}/syn/gotoSynOrg?appId=${appId}" class="btn green"></i>返回顶级组织
									</a>
									<a type="button" href="javascript:history.back();" class="btn green"></i>后退
									</a>
									</c:if>
									<button type="button" onclick="gopage('0');" class="btn" style="float:right">
										查询 
									</button>
									<i style="float:right">&nbsp;&nbsp;</i>
									<input type="text" class="m-wrap" id="tjcx" style="float:right" value="${param.tj}">
									<label class="control-label" style="float:right;font-size: 18px;text-align: center">名称搜索:&nbsp;&nbsp;</label>
									<input type="hidden" class="m-wrap" id="orgid" style="float:right" value="${parentid}">
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
									</colgroup>
									<thead>
										<tr>
											<th style="width:8px;"><!-- <input type="checkbox"
												class="group-checkable"
												data-set="#useraccount_table .checkboxes" /> --></th>
											<th>#</th>
											<th>组织名</th>
											<th>组织编码</th>
											<th>所在区划</th>
											<th>查看下级组织</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${orgList}" var="org" varStatus="status">
											<tr >
											<c:if test="${org.type =='checked'}">
												<td style="vertical-align: middle;"><img class="myimg" src="${root}/themes/hplus/img/success.png"></td>
											</c:if>
											<c:if test="${empty org.type}">
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${org.id}" /></td>
											</c:if>		
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${org.name}</td>
												<td style="vertical-align: middle;">${org.code}</td>
												<td style="vertical-align: middle;">${org.division.name}</td>
												<td style="vertical-align: middle;"><a href="${root}/syn/gotoSynOrg?appId=${appId }&orgid=${org.id}">查看</></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								${pagination}
							</div>
						</div>
	</div>
	<div class="form-actions">
	<button type="button" onclick="synOrg()" class="btn green">
			<i>确&nbsp;&nbsp;定</i>
	</button>
	<button type="button" onclick="window.close();" class="btn red">
			<i>关&nbsp;&nbsp;闭</i>
	</button>
	<div>
</div>
</div></div></div></body>
	<script type="text/javascript" src="${root}/themes/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript"
	src="${root}/themes/media/js/jquery.blockui.min.js"></script>
	<script type="text/javascript"
	src="${root}/themes/media/js/app.js"></script>
	<SCRIPT type="text/javascript">
	var dm_root = '${root}';
	function getcheckedids(){
		var ids=[];
		var cbs = document.getElementsByName("checkboxes");
		for(var i = 0 ; i < cbs.length; i++){
			if(cbs[i].checked == true){
				ids.push(cbs[i].value);
				break;
			}
		}
		return ids;
		}
	function gopage(thispage){
		//App.blockUI($('body'));
		var tj=$("#tjcx").val();
		var orgid=document.getElementById('orgid').value;
		window.location.href="${root}/syn/gotoSynOrg?appId=${appId}&thispage="+thispage+"&orgid="+orgid+"&tj="+tj;
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
	function synOrg(){
		var orgIds = getcheckedids();
		if(orgIds.length==0){
			alert("请选择要同步的组织");
			return ;
		}
        window.dialogArguments.location.href="${root}/syn/synCreateOrg?appId=${appId}&orgIds="+orgIds;
        window.close();
	}
</SCRIPT>
</html>
