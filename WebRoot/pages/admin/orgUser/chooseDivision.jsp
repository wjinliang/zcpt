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
<title>区划管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<%@include file="../include/style.jsp"%>
</head>
<!-- <body class="page-full-width"> -->
<!-- <div class="page-content" style="height: 500px">
	<div class="span12" style="height: 450px;overflow-y:auto;" >
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>区划选择
								</div>
							</div>
							<div class="portlet-body"> -->
							<ul id="treeOrg" style="font-weight: bold" class="ztree"></ul>
							<!-- </div>
						</div>-->
	<!-- </div>  -->
	<div algin="center">
	<button type="button" onclick="synOrgq()" class="btn green">
			<i>确&nbsp;&nbsp;定</i>
	</button>
	<button type="button" onclick="closes();" class="btn red">
			<i>关&nbsp;&nbsp;闭</i>
	</button>
	<!-- <div>
</div> -->
	<%-- <script type="text/javascript" src="${root}/themes/zTree/js/jquery-1.4.4.min.js"></script> --%>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	<SCRIPT type="text/javascript">
	var setting = {
			check: {
				enable: true,
				chkStyle: "radio",
				radioType: "level"
			},
			async: {
				enable: true,
				url:"${root}/orgAndUser/loadSonDivision",
				autoParam:["id=divisionid"]
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
	});
	function synOrgq(){
		var treeObj=$.fn.zTree.getZTreeObj("treeOrg");
        nodes=treeObj.getCheckedNodes(true);
        var orgIds="";
        var names="";
        for(var i=0;i<nodes.length;i++){
        	if(i==(nodes.length-1)){
        		orgIds+=nodes[i].id;
        		names+=nodes[i].name;
        	}else{
        		orgIds+=nodes[i].id + ",";
        		names+=nodes[i].name+",";
        	}
        }
        if(orgIds==''){
        	alert("请选择区划");
        	return false;
        }
		$.ajax({
			type:'post',
			url:'${root}/orgAndUser/getOrgLsh',
			data:{
				divisionid:orgIds,
				orgid:'${orgid}'
			},
			dataType:'text',
			success:function(data) { 
// 			window.dialogArguments.document.getElementById("code").value=data;
//         	window.dialogArguments.document.getElementById("divisionid").value=orgIds;
//         	window.dialogArguments.document.getElementById("divisionName").value=names;
//         	window.close();
			document.getElementById("code").value=data;
			document.getElementById("divisionid").value=orgIds;
			document.getElementById("divisionName").value=names;
//         	window.close();
			modalDivision.close();
			}
		});
	}
	function closes(){
		modalDivision.close();
	}
</SCRIPT>
<!-- </body> -->
</html>
