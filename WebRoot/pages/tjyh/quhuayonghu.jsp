<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@page import="java.util.List"%>
<%@page import="com.app.model.JKApplicationInfo"%>
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
<title>用户统计</title>
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
					用户统计 <small>统计各个区划下用户数量</small>
				</h3>
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${root}/syn/listSynApp">主页</a>
						<i class="icon-angle-right"></i></li>
				</ul>
			</div>
		</div>
		<div class="fszt">
			<div class="cg" id="timeCount"></div>
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
<p><button type="button" onclick="excelExport('1','')" class="btn green">
										导出为Excel
									</button><button type="button" onclick="gopage('0');" class="btn" style="float:right">
										查询 
									</button>
									<i style="float:right">&nbsp;&nbsp;</i>
									<select  class="m-wrap" id="tjcx" style="float:right">
										<option value="动物标识及动物产品追溯系统" ${xt=='动物标识及动物产品追溯系统'?'selected':'' }>动物标识及动物产品追溯系统</option>
										<option value="重大动物疫病防控信息管理系统" ${xt=='重大动物疫病防控信息管理系统'?'selected':'' }>重大动物疫病防控信息管理系统</option>
										<option value="全国兽医实验室信息管理系统" ${xt=='全国兽医实验室信息管理系统'?'selected':'' }>全国兽医实验室信息管理系统</option>
									</select>
									<label class="control-label" style="float:right;font-size: 18px;text-align: center">选择系统:&nbsp;&nbsp;</label>
								</p>
						<table class="table table-condensed table-hover"
							id="useraccount_table">
							<colgroup>
								<col width="5%"></col>
								<col width="15%"></col>
								<col></col>
								<col></col>
								<col></col>
								<col></col>
								<col></col>
							</colgroup>
							<thead>
								<tr>
									<!-- <th style="width:8px;"><input type="checkbox"
										class="group-checkable"
										data-set="#useraccount_table .checkboxes" /></th> -->
									<th>#</th>
									<th>区划</th>
									<th>省级用户</th>
									<th>市级用户</th>
									<th>县级用户</th>
									<th>乡镇用户</th>
									<th>村级用户</th>
								</tr>
							</thead>
							<tbody>
								<c:set value="0" var="sum0" />
								<c:set value="0" var="sum1" />
								<c:set value="0" var="sum2" />
								<c:set value="0" var="sum3" />
								<c:set value="0" var="sum4" />
								<c:forEach items="${tjsj}" var="app" varStatus="status">
									<tr>
										<%-- <td style="vertical-align: middle;"><input
											type="checkbox" class="checkboxes" name="checkboxes"
											value="${app.id}" /></td> --%>
										<td style="vertical-align: middle;">
											${thispage*pagesize+status.count}</td>
										<td style="vertical-align: middle;">${app.divisionName}</td>
										<td style="vertical-align: middle;">${app.shengcount}</td>
										<td style="vertical-align: middle;">${app.shicount}</td>
										<td style="vertical-align: middle;">${app.xiancount}</td>
										<td style="vertical-align: middle;">${app.xiangcount}</td>
										<td style="vertical-align: middle;">${app.cuncount}</td>
										<c:set value="${sum0 + app.shengcount}" var="sum0" />
										<c:set value="${sum1 + app.shicount}" var="sum1" />
										<c:set value="${sum2 + app.xiancount}" var="sum2" />
										<c:set value="${sum3 + app.xiangcount}" var="sum3" />
										<c:set value="${sum4 + app.cuncount}" var="sum4" />
									</tr>
									<c:if test="${status.last=='true'}">
									<tr style="background-color: #ccc;">
										<%-- <td style="vertical-align: middle;"><input
											type="checkbox" class="checkboxes" name="checkboxes"
											value="${app.id}" /></td> --%>
										<td style="vertical-align: middle;"></td>
										<td style="vertical-align: middle;">合计(${sum0+sum1+sum2+sum3+sum4})</td>
										<td style="vertical-align: middle;">${sum0}</td>
										<td style="vertical-align: middle;">${sum1}</td>
										<td style="vertical-align: middle;">${sum2}</td>
										<td style="vertical-align: middle;">${sum3}</td>
										<td style="vertical-align: middle;">${sum4}</td>

									</tr>
									</c:if>
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
	function getcheckedids() {
		var ids = [];
		var cbs = document.getElementsByName("checkboxes");
		for (var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked == true) {
				ids.push(cbs[i].value);
			}
		}
		return ids;
	}
	function gopage(thispage) {
		/* if (thispage > ${totalpage-1}) {
			thispage = ${totalpage-1};
		} */
		var systemId = $("#tjcx").val();
		window.location.href = "${root}/tjyh/qhyh?systemId="+systemId;
	}
	function nextpage() {
		if (${thispage} < ${totalpage-1}) {
			gopage(${thispage+1});
		}
	}
	function prepage() {
		if (${thispage} > 0) {
			gopage(${thispage-1});
		}
	}
	function excelExport(type,systemId){
		var systemId = $("#tjcx").val();
		var url = "${root}/tjyh/excelExport?type="+type+"&systemId="+systemId;
		window.open(url);
	}
</script>
<!-- END JAVASCRIPTS -->
</html>
