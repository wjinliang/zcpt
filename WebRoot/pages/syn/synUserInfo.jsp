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
<title>同步情况</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<%@include file="../admin/include/style.jsp"%>
</head>
<!-- <div class="page-content" style="height: 500px">
	<div class="span3" style="height: 450px;overflow-y:auto;" >
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>用户同步
								</div>
							</div>
							<div class="portlet-body"> -->
								<table class="table table-condensed table-hover"
									id="syn_user_info">
									<colgroup>
										<col width="5%"></col>
										<col ></col>
										<col ></col>
									</colgroup>
									<thead>
										<tr>
											<th>#</th>
											<th>系统名称</th>
											<th>操作类型</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${resultlist}" var="app" varStatus="status">
										<c:if test="${app[2]!='无' }">
											<tr >
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${app[1]}</td>
												<td style="vertical-align: middle;"><c:if test="${app[2]=='删除'}"><font color="red"></c:if>${app[2]}</td>
											</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							<!-- </div>
						</div>
	</div> -->
	<div align="center">
	<button type="button" onclick="synUser()" class="btn green">
			<i>确&nbsp;&nbsp;定</i>
	</button>
	<button type="button" onclick="hidemode();" class="btn red">
			<i>关&nbsp;&nbsp;闭</i>
	</button>
	<div>
<!-- </div> -->
	<SCRIPT type="text/javascript">
	function synUser(){
        //window.dialogArguments.doTongBu();
		//App.blockUI($('#editPop_box'));
        doTongBu();
        modalCheck.close();
	}
	function hidemode(){
		modalCheck.close();
	}
</SCRIPT>
</html>
