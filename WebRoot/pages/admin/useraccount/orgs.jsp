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
<title>用户管理-选择组织</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">

	<!-- END PAGE LEVEL STYLES -->
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
							选择组织 
						</h3>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>组织列表
								</div>
							</div>
							<div class="portlet-body form">
								<div id="success" class="alert alert-success hide">

									<button class="close" data-dismiss="alert"></button>

									<strong>设置成功!</strong> 即将跳转回列表...

								</div>
								<!-- BEGIN FORM-->

								<div class="form-horizontal form-view">
									<div class="row-fluid">
							<div class="portlet-body">
								<p>
								<c:if test="${not empty parentid}"> 
								<a type="button" href="${root}/useraccount/selectorg/${useraccountid}" class="btn green"></i>返回顶级组织
									</a>
									</c:if>
									<button type="button" onclick="gopage('0');" class="btn" style="float:right">
										查询 
									</button>
									<i style="float:right">&nbsp;&nbsp;</i>
									<input type="text" class="m-wrap" id="tjcx" style="float:right" value="${param.tj}">
									<label class="control-label" style="float:right;font-size: 18px;text-align: center">名称搜索:&nbsp;&nbsp;</label>
									<%-- <i style="float:right">&nbsp;&nbsp;</i>
									<select id="xt" style="float:right">
										<option value="all">==请选择==</option>
										<c:forEach items="${appList}" var="app" varStatus="status">
											<option value="${app.appName}" <c:if test="${app.appName==param.xt}">selected="selected"</c:if>>${app.appName}</option>
										</c:forEach>
									</select>
									<label class="control-label" style="float:right;font-size: 18px;text-align: center">所属系统:&nbsp;&nbsp;</label> --%>
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
											<th style="width:8px;"><input type="checkbox"
												class="group-checkable"
												data-set="#useraccount_table .checkboxes" /></th>
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
												<td style="vertical-align: middle;"><input type="checkbox" class="checkboxes" name="checkboxes"
													value="${org.id}" /></td>
												<td style="vertical-align: middle;">
												${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;">${org.name}</td>
												<td style="vertical-align: middle;">${org.code}</td>
												<td style="vertical-align: middle;">${org.division.name}</td>
												<td style="vertical-align: middle;"><a href="${root}/useraccount/selectorg/${useraccountid}?orgid=${org.id}&tj=${param.tj}">查看</></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								${pagination}
							</div>
						</div>
									<!--/row-->
									<div class="form-actions">
										<button type="button" onclick="setMenus('${useraccountid}')"
											class="btn blue">
											<i class="icon-pencil"></i> 确认
										</button>
										<button type="button" onclick="window.history.back();"
											class="btn">返回</button>
									</div>
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

		<!-- BEGIN PAGE LEVEL PLUGINS -->

		<script type="text/javascript"
			src="<%=basePath%>themes/media/js/select2.min.js"></script>

		<script type="text/javascript"
			src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>

		<script type="text/javascript"
			src="${root}/themes/zTree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript"
			src="${root}/themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>

		<!-- END PAGE LEVEL PLUGINS -->
		<script type="text/javascript">
		function setMenus() {
			window.bootbox.confirm("确定选择组织吗？", function(result) {
				if (result) {
					var orgid =getcheckedids();
					$.ajax({
						url : "${root}/useraccount/setorg",
						type : "POST",
						data : "useraccountid=${useraccountid}&orgid=" + orgid,
						success : function(data) {
							if (data == "ok") {
							$("#success").fadeIn(1500, function() {
								window.location.href = "${root}/orgAndUser/listUsers?orgid="+orgid;
							});
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
					break;
				}
			}
			return ids;
			}
		function gopage(thispage){
			//var xt=$("#xt").val();
			var tj=$("#tjcx").val();
			var orgid=document.getElementById('orgid').value;
			window.location.href="${root}/useraccount/selectorg/${useraccountid}?thispage="+thispage+"&orgid="+orgid+"&tj="+tj;//+"&xt="+xt;
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
