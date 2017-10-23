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
<title>基站管理-基站连接-表单</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/media/css/select2_metro.css" />

<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/media/css/chosen.css" />

<!-- END PAGE LEVEL STYLES -->

</head>
<!-- END HEAD -->

	<!-- BEGIN HEADER -->
	<%@include file="../../admin/include/head.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<%@include file="../../admin/include/sidebar.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<h3 class="page-title">
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i><a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="${root}/siteinfo/list">基站连接</a>
								<i class="icon-angle-right"></i>
							</li>
							<li>
								<a>基站基本信息</a>
							</li>
						</ul>
						</div>
					</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>基站基本信息
								</div>
							</div>

							<div class="portlet-body form">

								<!-- BEGIN FORM-->
								<form action="${root}/siteinfo/save" method="post" id="formValidate" class="form-horizontal">
									<div class="dataTables_wrapper form-inline">
										<table class="table table-striped table-hover" id="siteinfo_table">
											<colgroup>
												<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
												<col width="110"></col>
												<col width="425"></col>
												<col width="120"></col>
						                		<col width="430"></col>
											</colgroup>
											<tbody>
												<tr>
													<th><label class="control-label">海区：</label></th>
													<td>
														<label class="control-label"><span class="text">${siteInfo.area }</span></label>
													</td>
													
													<th><label class="control-label">辖区：</label></th>
													<td>
														<label class="control-label"><span class="text">${siteInfo.jurisdictions }</span></label>
													</td>
												</tr>
												<tr>
													<th><label class="control-label">地址：</label></th>
													<td>
														<label class="control-label"><span class="text">${siteInfo.address }</span></label>
													</td>
													
													<th><label class="control-label">制造商：</label></th>
													<td>
														<label class="control-label"><span class="text">${siteInfo.manufacturer }</span></label>
													</td>
												</tr>
												<tr>
													<th>
														<label class="control-label">Site Name：</label>
													</th>
													<!--数据项名称用th-->
													<td>
														<label class="control-label"><span class="text">${siteInfo.sitename}</span></label>
													</td>
													
													<th><label class="control-label">基站类型：</label></th>
													<!--数据项名称用th-->
													<td>
														<label class="control-label"><span class="text">${siteInfo.siteType==0?'单':'双'}</span></label>
													</td>
												</tr>
												<tr id="single">
													<th><label class="control-label">IP Address A：</label>
													</th>
													<td>
														<label class="control-label"><span class="text">${siteInfo.ipAddressA }</span></label>
													</td>
												
													<th><label class="control-label">Port A：</label>
													</th>
													<td>
														<label class="control-label"><span class="text">${siteInfo.portA }</span></label>
													</td>
													
												</tr>
												<c:if test="${siteInfo.siteType=='1'}">
													<tr id="double">
														<th><label class="control-label">IP Address B：</label>
														</th>
														<td>
															<label class="control-label"><span class="text">${siteInfo.ipAddressB }</span></label>
														</td>
													
														<th><label class="control-label">Port B：</label>
														</th>
														<td>
															<label class="control-label"><span class="text">${siteInfo.portB }</span></label>
														</td>
													</tr>
												</c:if>
												<tr>
													<th>
													<label class="control-label">Power：</label>
													</th>
													<!--数据项名称用th-->
													<td>
														<label class="control-label"><span class="text">${siteInfo.power=='0'?'高功率':'低功率' }</span></label>
													</td>
													
													<th>
													<label class="control-label">Talker ID：</label>
													</th>
													<!--数据项名称用th-->
													<td>
														<c:if test="${siteInfo.talkerID=='AB' }"><label class="control-label"><span class="text">AIS基站</span></label></c:if>
														<c:if test="${siteInfo.talkerID=='AL' }"><label class="control-label"><span class="text">受限AIS基站</span></label></c:if>
														<c:if test="${siteInfo.talkerID=='AS' }"><label class="control-label"><span class="text">单一中继站</span></label></c:if>
														<c:if test="${siteInfo.talkerID=='AD' }"><label class="control-label"><span class="text">双重中继站</span></label></c:if>
														<c:if test="${siteInfo.talkerID=='AR' }"><label class="control-label"><span class="text">接收站</span></label></c:if>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									
									<div class="form-actions"  style="padding-left: 0px;text-align:center;">
										<button type="button" onclick="window.history.back();" class="btn">返回</button>
									</div>
								</form>
								<!-- END FORM-->
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	<!-- BEGIN FOOTER -->
	<%@include file="../../admin/include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../../admin/include/js.jsp"%>
	
</html>
