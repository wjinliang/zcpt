<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
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
<title>高级配置</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link href="<%=basePath%>themes/media/css/bootstrap-tag.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>themes/media/css/jquery.fancybox.css" rel="stylesheet" />
<link href="<%=basePath%>themes/media/css/bootstrap-wysihtml5.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>themes/media/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" >
<link href="<%=basePath%>themes/media/css/inbox.css" rel="stylesheet" type="text/css" />
</head>
<!-- END HEAD -->

<!-- BEGIN HEADER -->
<%@include file="../../admin/include/head.jsp"%>
<!-- END HEADER -->
<!-- BEGIN SIDEBAR -->
<%@include file="../../admin/include/sidebar.jsp"%>
<!-- END SIDEBAR -->
<!-- BEGIN PAGE -->
<div class="page-content">
	<!-- BEGIN PAGE CONTAINER-->
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
			</div>
		</div>
		<div class="row-fluid">

			<div class="span2 inbox">

				<ul class="inbox-nav margin-bottom-10">

					<li class="compose-btn">
						<a href="javascript:;" data-title="Compose" class="btn green"><i class="icon-edit"></i>高级配置 </a>
					</li>

					<li class="inbox" title="General">
						<a href="${root}/siteinfo/setting/form/${siteInfoId}/1" class="btn" data-title="General">General</a><b></b>
					</li>
						
					<li class="mark" title="Reporting Rates">
						<a href="${root}/siteinfo/report/advanced/form/${siteInfoId}"" class="btn" data-title="Reporting Rates">Reporting Rates</a><b></b>
					</li>

					<li class="sent active" title="Data Link Management">
						<a href="${root}/siteinfo/setting/advanced/dlmForm/${siteInfoId}" class="btn" data-title="Data Link Management">Data Link Manage..</a><b></b>
					</li>
					
					<!-- 
					<li class="draft" title="Channel Management">
						<a href="${root}/siteinfo/setting/advanced/acaForm/${siteInfoId}" class="btn" >Channel Manage..</a><b></b>
					</li>
					 -->

					<li class="trash" title="VSI FSR">
						<a href="${root}/siteinfo/advanced/output/form/${siteInfoId}" class="btn" >VSI FSR</a><b></b>
					</li>

				</ul>

			</div>
			<div class="span10">
				<div class="portlet-body form">
					<div class="row-fluid profile">
						<div class="span12">
	
							<!--BEGIN TABS-->
	
							<div class="tabbable tabbable-custom tabbable-full-width">
	
								<ul class="nav nav-tabs">
	
									<li class="active"><a href="#tab_1_1" data-toggle="tab">1-4</a></li>
									<li><a href="#tab_1_2" data-toggle="tab">5-8</a></li>
									<li><a href="#tab_1_3" data-toggle="tab">9-12</a></li>
									<li><a href="#tab_1_4" data-toggle="tab">13-16</a></li>
									<li><a href="#tab_1_5" data-toggle="tab">17-20</a></li>
									<li><a href="#tab_1_6" data-toggle="tab">21-24</a></li>
									<li><a href="#tab_1_7" data-toggle="tab">25-28</a></li>
									<li><a href="#tab_1_8" data-toggle="tab">29-32</a></li>
									<li><a href="#tab_1_9" data-toggle="tab">33-36</a></li>
									<li><a href="#tab_1_10" data-toggle="tab">37-40</a></li>
	
								</ul>
								<div class="tab-content" style="padding: 0px">
									<div class="tab-pane row-fluid active" id="tab_1_1">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate1" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status1" />
													<input type="hidden" name="number" value="1" id="number" />
													
													<input type="hidden" name="id" value="${entityA1.id}" id="idA1" />
													<input type="hidden" name="id" value="${entityA2.id}" id="idA2" />
													<input type="hidden" name="id" value="${entityA3.id}" id="idA3" />
													<input type="hidden" name="id" value="${entityA4.id}" id="idA4" />
													<input type="hidden" name="id" value="${entityB1.id}" id="idB1" />
													<input type="hidden" name="id" value="${entityB2.id}" id="idB2" />
													<input type="hidden" name="id" value="${entityB3.id}" id="idB3" />
													<input type="hidden" name="id" value="${entityB4.id}" id="idB4" />
													<!-- 基站A保留1 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="95"></col>
															<col></col>
															<col width="95"></col> 
								                 			<col></col>
								                 			<col width="95"></col>
								                 			<col></col>
								                 			<col width="95"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA1" value="${entityA1.startSlot==null?0:entityA1.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA2" value="${entityA2.startSlot==null?0:entityA2.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA3" value="${entityA3.startSlot==null?0:entityA3.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA4" value="${entityA4.startSlot==null?0:entityA4.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA1" value="${entityA1.increment==null?0:entityA1.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA2" value="${entityA2.increment==null?0:entityA2.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA3" value="${entityA3.increment==null?0:entityA3.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA4" value="${entityA4.increment==null?0:entityA4.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA1" value="${entityA1.slotNumber==null?0:entityA1.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA2" value="${entityA2.slotNumber==null?0:entityA2.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA3" value="${entityA3.slotNumber==null?0:entityA3.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA4" value="${entityA4.slotNumber==null?0:entityA4.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA1" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA1.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA1.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA1.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA2" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA2.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA2.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA2.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA3" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA3.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA3.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA3.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA4" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA4.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA4.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA4.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA1" value="${entityA1.timeout==null?0:entityA1.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA2" value="${entityA2.timeout==null?0:entityA2.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA3" value="${entityA3.timeout==null?0:entityA3.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA4" value="${entityA4.timeout==null?0:entityA4.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<!-- 基站B保留1 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB1" value="${entityB1.startSlot==null?0:entityB1.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB2" value="${entityB2.startSlot==null?0:entityB2.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB3" value="${entityB3.startSlot==null?0:entityB3.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB4" value="${entityB4.startSlot==null?0:entityB4.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB1" value="${entityB1.increment==null?0:entityB1.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB2" value="${entityB2.increment==null?0:entityB2.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB3" value="${entityB3.increment==null?0:entityB3.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB4" value="${entityB4.increment==null?0:entityB4.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB1" value="${entityB1.slotNumber==null?0:entityB1.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB2" value="${entityB2.slotNumber==null?0:entityB2.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB3" value="${entityB3.slotNumber==null?0:entityB3.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB4" value="${entityB4.slotNumber==null?0:entityB4.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB1" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB1.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB1.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB1.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB2" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB2.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB2.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB2.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB3" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB3.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB3.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB3.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB4" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB4.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB4.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB4.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB1" value="${entityB1.timeout==null?0:entityB1.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB2" value="${entityB2.timeout==null?0:entityB2.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB3" value="${entityB3.timeout==null?0:entityB3.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB4" value="${entityB4.timeout==null?0:entityB4.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','1')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','1')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane profile-classic row-fluid" id="tab_1_2">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate2" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status2" />
													<input type="hidden" name="number" value="2" id="number" />
													
													<input type="hidden" name="id" value="${entityA5.id}" id="idA1" />
													<input type="hidden" name="id" value="${entityA6.id}" id="idA2" />
													<input type="hidden" name="id" value="${entityA7.id}" id="idA3" />
													<input type="hidden" name="id" value="${entityA8.id}" id="idA4" />
													<input type="hidden" name="id" value="${entityB5.id}" id="idB1" />
													<input type="hidden" name="id" value="${entityB6.id}" id="idB2" />
													<input type="hidden" name="id" value="${entityB7.id}" id="idB3" />
													<input type="hidden" name="id" value="${entityB8.id}" id="idB4" />
													<!-- 基站A保留2 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA5" value="${entityA5.startSlot==null?0:entityA5.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA6" value="${entityA6.startSlot==null?0:entityA6.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA7" value="${entityA7.startSlot==null?0:entityA7.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA8" value="${entityA8.startSlot==null?0:entityA8.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA5" value="${entityA5.increment==null?0:entityA5.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA6" value="${entityA6.increment==null?0:entityA6.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA7" value="${entityA7.increment==null?0:entityA7.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA8" value="${entityA8.increment==null?0:entityA8.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA5" value="${entityA5.slotNumber==null?0:entityA5.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA6" value="${entityA6.slotNumber==null?0:entityA6.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA7" value="${entityA7.slotNumber==null?0:entityA7.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA8" value="${entityA8.slotNumber==null?0:entityA8.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA5" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA5.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA5.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA5.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA6" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA6.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA6.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA6.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA7" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA7.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA7.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA7.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA8" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA8.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA8.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA8.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA5" value="${entityA5.timeout==null?0:entityA5.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA6" value="${entityA6.timeout==null?0:entityA6.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA7" value="${entityA7.timeout==null?0:entityA7.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA8" value="${entityA8.timeout==null?0:entityA8.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB5" value="${entityB5.startSlot==null?0:entityB5.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB6" value="${entityB6.startSlot==null?0:entityB6.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB7" value="${entityB7.startSlot==null?0:entityB7.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB8" value="${entityB8.startSlot==null?0:entityB8.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB5" value="${entityB5.increment==null?0:entityB5.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB6" value="${entityB6.increment==null?0:entityB6.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB7" value="${entityB7.increment==null?0:entityB7.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB8" value="${entityB8.increment==null?0:entityB8.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB5" value="${entityB5.slotNumber==null?0:entityB5.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB6" value="${entityB6.slotNumber==null?0:entityB6.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB7" value="${entityB7.slotNumber==null?0:entityB7.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB8" value="${entityB8.slotNumber==null?0:entityB8.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB5" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB5.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB5.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB5.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB6" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB6.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB6.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB6.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB7" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB7.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB7.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB7.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB8" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB8.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB8.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB8.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB5" value="${entityB5.timeout==null?0:entityB5.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB6" value="${entityB6.timeout==null?0:entityB6.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB7" value="${entityB7.timeout==null?0:entityB7.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB8" value="${entityB8.timeout==null?0:entityB8.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','2')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','2')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_3">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate3" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status3" />
													<input type="hidden" name="number" value="3" id="number" />
													
													<input type="hidden" name="id" value="${entityA9.id}" id="idA9" />
													<input type="hidden" name="id" value="${entityA10.id}" id="idA10" />
													<input type="hidden" name="id" value="${entityA11.id}" id="idA11" />
													<input type="hidden" name="id" value="${entityA12.id}" id="idA12" />
													<input type="hidden" name="id" value="${entityB9.id}" id="idB9" />
													<input type="hidden" name="id" value="${entityB10.id}" id="idB10" />
													<input type="hidden" name="id" value="${entityB11.id}" id="idB11" />
													<input type="hidden" name="id" value="${entityB12.id}" id="idB12" />
													<!-- 基站A保留3 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA9" value="${entityA9.startSlot==null?0:entityA9.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA10" value="${entityA10.startSlot==null?0:entityA10.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA11" value="${entityA11.startSlot==null?0:entityA11.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA12" value="${entityA12.startSlot==null?0:entityA12.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA9" value="${entityA9.increment==null?0:entityA9.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA10" value="${entityA10.increment==null?0:entityA10.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA11" value="${entityA11.increment==null?0:entityA11.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA12" value="${entityA12.increment==null?0:entityA12.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumber9" value="${entityA9.slotNumber==null?0:entityA9.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA10" value="${entityA10.slotNumber==null?0:entityA10.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA11" value="${entityA11.slotNumber==null?0:entityA11.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA12" value="${entityA12.slotNumber==null?0:entityA12.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA9" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA9.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA9.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA9.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA10" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA10.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA10.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA10.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA11" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA11.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA11.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA11.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA12" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA12.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA12.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA12.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA9" value="${entityA9.timeout==null?0:entityA9.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA10" value="${entityA10.timeout==null?0:entityA10.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA11" value="${entityA11.timeout==null?0:entityA11.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA12" value="${entityA12.timeout==null?0:entityA12.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB9" value="${entityB9.startSlot==null?0:entityB9.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB10" value="${entityB10.startSlot==null?0:entityB10.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB11" value="${entityB11.startSlot==null?0:entityB11.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB12" value="${entityB12.startSlot==null?0:entityB12.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB9" value="${entityB9.increment==null?0:entityB9.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB10" value="${entityB10.increment==null?0:entityB10.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB11" value="${entityB11.increment==null?0:entityB11.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB12" value="${entityB12.increment==null?0:entityB12.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB9" value="${entityB9.slotNumber==null?0:entityB9.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB10" value="${entityB10.slotNumber==null?0:entityB10.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB11" value="${entityB11.slotNumber==null?0:entityB11.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB12" value="${entityB12.slotNumber==null?0:entityB12.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB9" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB9.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB9.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB9.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB10" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB10.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB10.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB10.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB11" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB11.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB11.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB11.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB12" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB12.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB12.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB12.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB9" value="${entityB9.timeout==null?0:entityB9.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB10" value="${entityB10.timeout==null?0:entityB10.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB11" value="${entityB11.timeout==null?0:entityB11.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB12" value="${entityB12.timeout==null?0:entityB12.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','3')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','3')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_4">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate4" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status4" />
													<input type="hidden" name="number" value="4" id="number" />
													
													<input type="hidden" name="id" value="${entityA13.id}" id="idA13" />
													<input type="hidden" name="id" value="${entityA14.id}" id="idA14" />
													<input type="hidden" name="id" value="${entityA15.id}" id="idA15" />
													<input type="hidden" name="id" value="${entityA16.id}" id="idA16" />
													<input type="hidden" name="id" value="${entityB13.id}" id="idB13" />
													<input type="hidden" name="id" value="${entityB14.id}" id="idB14" />
													<input type="hidden" name="id" value="${entityB15.id}" id="idB15" />
													<input type="hidden" name="id" value="${entityB16.id}" id="idB16" />
													<!-- 基站A保留1 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA13" value="${entityA13.startSlot==null?0:entityA13.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA14" value="${entityA14.startSlot==null?0:entityA14.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA15" value="${entityA15.startSlot==null?0:entityA15.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA16" value="${entityA16.startSlot==null?0:entityA16.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA13" value="${entityA13.increment==null?0:entityA13.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA14" value="${entityA14.increment==null?0:entityA14.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA15" value="${entityA15.increment==null?0:entityA15.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA16" value="${entityA16.increment==null?0:entityA16.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA13" value="${entityA13.slotNumber==null?0:entityA13.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA14" value="${entityA14.slotNumber==null?0:entityA14.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA15" value="${entityA15.slotNumber==null?0:entityA15.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA16" value="${entityA16.slotNumber==null?0:entityA16.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA13" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA13.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA13.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA13.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA14" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA14.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA14.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA14.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA15" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA15ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA15.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA15.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA16" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA16.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA16.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA16.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA13" value="${entityA13.timeout==null?0:entityA13.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA14" value="${entityA14.timeout==null?0:entityA14.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA15" value="${entityA15.timeout==null?0:entityA15.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA16" value="${entityA16.timeout==null?0:entityA16.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB13" value="${entityB13.startSlot==null?0:entityB13.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB14" value="${entityB14.startSlot==null?0:entityB14.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB15" value="${entityB15.startSlot==null?0:entityB15.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB16" value="${entityB16.startSlot==null?0:entityB16.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB13" value="${entityB13.increment==null?0:entityB13.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB14" value="${entityB14.increment==null?0:entityB14.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB15" value="${entityB15.increment==null?0:entityB15.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB16" value="${entityB16.increment==null?0:entityB16.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB13" value="${entityB13.slotNumber==null?0:entityB13.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB14" value="${entityB14.slotNumber==null?0:entityB14.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB15" value="${entityB15.slotNumber==null?0:entityB15.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB16" value="${entityB16.slotNumber==null?0:entityB16.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB13" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB13.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB13.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB13.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB14" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB14.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB14.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB14.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB15" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB15.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB15.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB15.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB16" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB16.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB16.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB16.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB13" value="${entityB13.timeout==null?0:entityB13.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB14" value="${entityB14.timeout==null?0:entityB14.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB15" value="${entityB15.timeout==null?0:entityB15.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB16" value="${entityB16.timeout==null?0:entityB16.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','4')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','4')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_5">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate5" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status5" />
													<input type="hidden" name="number" value="5" id="number" />
									
													<input type="hidden" name="id" value="${entityA17.id}" id="idA17" />
													<input type="hidden" name="id" value="${entityA18.id}" id="idA18" />
													<input type="hidden" name="id" value="${entityA19.id}" id="idA19" />
													<input type="hidden" name="id" value="${entityA20.id}" id="idA20" />
													<input type="hidden" name="id" value="${entityB17.id}" id="idB17" />
													<input type="hidden" name="id" value="${entityB18.id}" id="idB18" />
													<input type="hidden" name="id" value="${entityB19.id}" id="idB19" />
													<input type="hidden" name="id" value="${entityB20.id}" id="idB20" />
													<!-- 基站A保留5 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA17" value="${entityA17.startSlot==null?0:entityA17.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA18" value="${entityA18.startSlot==null?0:entityA18.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA19" value="${entityA19.startSlot==null?0:entityA19.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlot20" value="${entityA20.startSlot==null?0:entityA20.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA17" value="${entityA17.increment==null?0:entityA17.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA18" value="${entityA18.increment==null?0:entityA18.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA19" value="${entityA19.increment==null?0:entityA29.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA20" value="${entityA20.increment==null?0:entityA20.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA17" value="${entityA17.slotNumber==null?0:entityA17.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA18" value="${entityA18.slotNumber==null?0:entityA18.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA19" value="${entityA19.slotNumber==null?0:entityA19.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumber20" value="${entityA20.slotNumber==null?0:entityA20.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA17" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA17.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA17.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA17.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA18" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA18.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA18.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA18.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA19" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA19.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA19.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA19.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA20" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA20.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA20.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA20.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA17" value="${entityA17.timeout==null?0:entityA17.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA18" value="${entityA18.timeout==null?0:entityA18.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA19" value="${entityA19.timeout==null?0:entityA19.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA20" value="${entityA20.timeout==null?0:entityA20.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB17" value="${entityB17.startSlot==null?0:entityB17.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB18" value="${entityB18.startSlot==null?0:entityB18.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB19" value="${entityB19.startSlot==null?0:entityB19.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB20" value="${entityB20.startSlot==null?0:entityB20.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB17" value="${entityB17.increment==null?0:entityB17.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB18" value="${entityB18.increment==null?0:entityB18.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB19" value="${entityB19.increment==null?0:entityB19.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB20" value="${entityB20.increment==null?0:entityB20.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB17" value="${entityB17.slotNumber==null?0:entityB17.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB18" value="${entityB18.slotNumber==null?0:entityB18.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB19" value="${entityB19.slotNumber==null?0:entityB19.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB20" value="${entityB20.slotNumber==null?0:entityB20.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB17" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB17.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB17.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB17.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB18" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB18.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB18.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB18.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB19" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB19.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB19.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB19.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB20" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB20.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB20.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB20.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB17" value="${entityB17.timeout==null?0:entityB17.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB18" value="${entityB18.timeout==null?0:entityB18.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB19" value="${entityB19.timeout==null?0:entityB19.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB20" value="${entityB20.timeout==null?0:entityB20.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','5')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','5')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_6">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate6" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status6" />
													<input type="hidden" name="number" value="6" id="number" />
													
													<input type="hidden" name="id" value="${entityA21.id}" id="idA21" />
													<input type="hidden" name="id" value="${entityA22.id}" id="idA22" />
													<input type="hidden" name="id" value="${entityA23.id}" id="idA23" />
													<input type="hidden" name="id" value="${entityA24.id}" id="idA24" />
													<input type="hidden" name="id" value="${entityB21.id}" id="idB21" />
													<input type="hidden" name="id" value="${entityB22.id}" id="idB22" />
													<input type="hidden" name="id" value="${entityB23.id}" id="idB23" />
													<input type="hidden" name="id" value="${entityB24.id}" id="idB24" />
													<!-- 基站A保留6 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA21" value="${entityA21.startSlot==null?0:entityA21.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA22" value="${entityA22.startSlot==null?0:entityA22.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA23" value="${entityA23.startSlot==null?0:entityA23.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA24" value="${entityA24.startSlot==null?0:entityA24.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA21" value="${entityA21.increment==null?0:entityA21.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA22" value="${entityA22.increment==null?0:entityA22.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA23" value="${entityA23.increment==null?0:entityA23.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA24" value="${entityA24.increment==null?0:entityA24.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA21" value="${entityA21.slotNumber==null?0:entityA21.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA22" value="${entityA22.slotNumber==null?0:entityA22.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA23" value="${entityA23.slotNumber==null?0:entityA23.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA24" value="${entityA24.slotNumber==null?0:entityA24.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA21" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA21.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA21.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA21.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA22" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA22.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA22.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA22.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA23" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA23.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA23.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA23.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA24" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA24.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA24.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA24.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA21" value="${entityA21.timeout==null?0:entityA21.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA22" value="${entityA22.timeout==null?0:entityA22.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA23" value="${entityA23.timeout==null?0:entityA23.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA24" value="${entityA24.timeout==null?0:entityA24.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB21" value="${entityB21.startSlot==null?0:entityB21.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB22" value="${entityB22.startSlot==null?0:entityB22.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB23" value="${entityB23.startSlot==null?0:entityB23.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB24" value="${entityB24.startSlot==null?0:entityB24.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB21" value="${entityB21.increment==null?0:entityB21.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB22" value="${entityB22.increment==null?0:entityB22.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB23" value="${entityB23.increment==null?0:entityB23.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB24" value="${entityB24.increment==null?0:entityB24.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB21" value="${entityB21.slotNumber==null?0:entityB21.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB22" value="${entityB22.slotNumber==null?0:entityB22.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB23" value="${entityB23.slotNumber==null?0:entityB23.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB24" value="${entityB24.slotNumber==null?0:entityB24.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB21" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB21.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB21.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB21.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB22" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB22.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB22.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB22.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB23" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB23.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB23.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB23.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB24" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB24.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB24.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB24.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB21" value="${entityB21.timeout==null?0:entityB21.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB22" value="${entityB22.timeout==null?0:entityB22.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB23" value="${entityB23.timeout==null?0:entityB23.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB24" value="${entityB24.timeout==null?0:entityB24.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','6')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','6')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_7">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate7" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status7" />
													<input type="hidden" name="number" value="7" id="number" />
													
													<input type="hidden" name="id" value="${entityA25.id}" id="idA25" />
													<input type="hidden" name="id" value="${entityA26.id}" id="idA26" />
													<input type="hidden" name="id" value="${entityA27.id}" id="idA27" />
													<input type="hidden" name="id" value="${entityA28.id}" id="idA28" />
													<input type="hidden" name="id" value="${entityB25.id}" id="idB25" />
													<input type="hidden" name="id" value="${entityB26.id}" id="idB26" />
													<input type="hidden" name="id" value="${entityB27.id}" id="idB27" />
													<input type="hidden" name="id" value="${entityB28.id}" id="idB28" />
													<!-- 基站A保留1 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA25" value="${entityA25.startSlot==null?0:entityA25.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA26" value="${entityA26.startSlot==null?0:entityA26.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA27" value="${entityA27.startSlot==null?0:entityA27.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA28" value="${entityA28.startSlot==null?0:entityA28.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA25" value="${entityA25.increment==null?0:entityA25.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA26" value="${entityA26.increment==null?0:entityA26.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA27" value="${entityA27.increment==null?0:entityA27.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA28" value="${entityA28.increment==null?0:entityA28.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumber25" value="${entityA25.slotNumber==null?0:entityA25.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA26" value="${entityA26.slotNumber==null?0:entityA26.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA27" value="${entityA27.slotNumber==null?0:entityA27.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA28" value="${entityA28.slotNumber==null?0:entityA28.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA25" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA25.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA25.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA25.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA26" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA26.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA26.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA26.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA27" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA27.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA27.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA27.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA28" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA28.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA28.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA28.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA25" value="${entityA25.timeout==null?0:entityA25.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA26" value="${entityA26.timeout==null?0:entityA26.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA27" value="${entityA27.timeout==null?0:entityA27.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA28" value="${entityA28.timeout==null?0:entityA28.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB25" value="${entityB25.startSlot==null?0:entityB25.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB26" value="${entityB26.startSlot==null?0:entityB26.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB27" value="${entityB27.startSlot==null?0:entityB27.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB28" value="${entityB28.startSlot==null?0:entityB28.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB25" value="${entityB25.increment==null?0:entityB25.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB26" value="${entityB26.increment==null?0:entityB26.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB27" value="${entityB27.increment==null?0:entityB27.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB28" value="${entityB28.increment==null?0:entityB28.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB25" value="${entityB25.slotNumber==null?0:entityB25.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB26" value="${entityB26.slotNumber==null?0:entityB26.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB27" value="${entityB27.slotNumber==null?0:entityB27.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB28" value="${entityB28.slotNumber==null?0:entityB28.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB25" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB25.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB25.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB25.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB26" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB26.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB26.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB26.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB27" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB27.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB27.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB27.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB28" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB28.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB28.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB28.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB25" value="${entityB25.timeout==null?0:entityB25.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB26" value="${entityB26.timeout==null?0:entityB26.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB27" value="${entityB27.timeout==null?0:entityB27.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB28" value="${entityB28.timeout==null?0:entityB28.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','7')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','7')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_8">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate8" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status8" />
													<input type="hidden" name="number" value="8" id="number" />
													<input type="hidden" name="id" value="${entityA29.id}" id="idA29" />
													<input type="hidden" name="id" value="${entityA30.id}" id="idA30" />
													<input type="hidden" name="id" value="${entityA31.id}" id="idA31" />
													<input type="hidden" name="id" value="${entityA32.id}" id="idA32" />
													<input type="hidden" name="id" value="${entityB29.id}" id="idB29" />
													<input type="hidden" name="id" value="${entityB30.id}" id="idB30" />
													<input type="hidden" name="id" value="${entityB31.id}" id="idB31" />
													<input type="hidden" name="id" value="${entityB32.id}" id="idB32" />
													<!-- 基站A保留1 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA29" value="${entityA29.startSlot==null?0:entityA29.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA30" value="${entityA30.startSlot==null?0:entityA30.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA31" value="${entityA31.startSlot==null?0:entityA31.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA32" value="${entityA32.startSlot==null?0:entityA32.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA29" value="${entityA29.increment==null?0:entityA29.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA30" value="${entityA30.increment==null?0:entityA30.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA31" value="${entityA31.increment==null?0:entityA31.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA32" value="${entityA32.increment==null?0:entityA32.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA29" value="${entityA29.slotNumber==null?0:entityA29.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA30" value="${entityA30.slotNumber==null?0:entityA30.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA31" value="${entityA31.slotNumber==null?0:entityA31.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA32" value="${entityA32.slotNumber==null?0:entityA32.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA29" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA29.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA29.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA29.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA30" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA30.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA30.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA30.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA31" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA31.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA31.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA31.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA32" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA32.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA32.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA32.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA29" value="${entityA29.timeout==null?0:entityA29.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA30" value="${entityA30.timeout==null?0:entityA30.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA31" value="${entityA31.timeout==null?0:entityA31.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA32" value="${entityA32.timeout==null?0:entityA32.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB29" value="${entityB29.startSlot==null?0:entityB29.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB30" value="${entityB30.startSlot==null?0:entityB30.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB31" value="${entityB31.startSlot==null?0:entityB31.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB32" value="${entityB32.startSlot==null?0:entityB32.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB29" value="${entityB29.increment==null?0:entityB29.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB30" value="${entityB30.increment==null?0:entityB30.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB31" value="${entityB31.increment==null?0:entityB31.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB32" value="${entityB32.increment==null?0:entityB32.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB29" value="${entityB29.slotNumber==null?0:entityB29.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB30" value="${entityB30.slotNumber==null?0:entityB30.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB31" value="${entityB31.slotNumber==null?0:entityB31.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB32" value="${entityB32.slotNumber==null?0:entityB32.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB29" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB29.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB29.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB29.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB30" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB30.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB30.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB30.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB31" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB31.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB31.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB31.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB32" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB32.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB32.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB32.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB29" value="${entityB29.timeout==null?0:entityB29.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB30" value="${entityB30.timeout==null?0:entityB30.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB31" value="${entityB31.timeout==null?0:entityB31.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB32" value="${entityB32.timeout==null?0:entityB32.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','8')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','8')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_9">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate9" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status9" />
													<input type="hidden" name="number" value="9" id="number" />
													<input type="hidden" name="id" value="${entityA33.id}" id="idA33" />
													<input type="hidden" name="id" value="${entityA34.id}" id="idA34" />
													<input type="hidden" name="id" value="${entityA35.id}" id="idA35" />
													<input type="hidden" name="id" value="${entityA36.id}" id="idA36" />
													<input type="hidden" name="id" value="${entityB33.id}" id="idB33" />
													<input type="hidden" name="id" value="${entityB34.id}" id="idB34" />
													<input type="hidden" name="id" value="${entityB35.id}" id="idB35" />
													<input type="hidden" name="id" value="${entityB36.id}" id="idB36" />
													<!-- 基站A保留1 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA33" value="${entityA33.startSlot==null?0:entityA33.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA34" value="${entityA34.startSlot==null?0:entityA34.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA35" value="${entityA35.startSlot==null?0:entityA35.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA36" value="${entityA36.startSlot==null?0:entityA36.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA33" value="${entityA33.increment==null?0:entityA33.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA34" value="${entityA34.increment==null?0:entityA34.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA35" value="${entityA35.increment==null?0:entityA35.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA36" value="${entityA36.increment==null?0:entityA36.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA33" value="${entityA33.slotNumber==null?0:entityA33.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA34" value="${entityA34.slotNumber==null?0:entityA34.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA35" value="${entityA35.slotNumber==null?0:entityA35.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA36" value="${entityA36.slotNumber==null?0:entityA36.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA33" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA33.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA33.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA33.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA34" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA34.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA34.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA34.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA35" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA35.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA35.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA35.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA36" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA36.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA36.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA36.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA33" value="${entityA33.timeout==null?0:entityA33.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA34" value="${entityA34.timeout==null?0:entityA34.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA35" value="${entityA35.timeout==null?0:entityA35.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA36" value="${entityA36.timeout==null?0:entityA36.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB33" value="${entityB33.startSlot==null?0:entityB33.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB34" value="${entityB34.startSlot==null?0:entityB34.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB35" value="${entityB35.startSlot==null?0:entityB35.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB36" value="${entityB36.startSlot==null?0:entityB36.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB33" value="${entityB33.increment==null?0:entityB33.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB34" value="${entityB34.increment==null?0:entityB34.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB35" value="${entityB35.increment==null?0:entityB35.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB36" value="${entityB36.increment==null?0:entityB36.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB33" value="${entityB33.slotNumber==null?0:entityB33.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB34" value="${entityB34.slotNumber==null?0:entityB34.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB35" value="${entityB35.slotNumber==null?0:entityB35.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB36" value="${entityB36.slotNumber==null?0:entityB36.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB33" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB33.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB33.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB33.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB34" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB34.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB34.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB34.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB35" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB35.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB35.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB35.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB36" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB36.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB36.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB36.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB33" value="${entityB33.timeout==null?0:entityB33.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB34" value="${entityB34.timeout==null?0:entityB34.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB35" value="${entityB35.timeout==null?0:entityB35.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB36" value="${entityB36.timeout==null?0:entityB36.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','9')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','9')" style="background-color: #FF7F50">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_10">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form1" id="form-validate10" action="${root}/siteinfo/advanced/dlmForm/save" method="post">
													<div class="alert alert-error hide">

										                <button class="close" data-dismiss="alert"></button>

										                                         表单填写不正确，请仔细核查。
 
									                 </div>

									                <div class="alert alert-success hide">

										                <button class="close" data-dismiss="alert"></button>

									                  	提交成功，等待跳转！

									                </div>
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="status" value="" id="status10" />
													<input type="hidden" name="number" value="10" id="number" />
													<input type="hidden" name="id" value="${entityA37.id}" id="idA37" />
													<input type="hidden" name="id" value="${entityA38.id}" id="idA38" />
													<input type="hidden" name="id" value="${entityA39.id}" id="idA39" />
													<input type="hidden" name="id" value="${entityA40.id}" id="idA40" />
													<input type="hidden" name="id" value="${entityB37.id}" id="idB37" />
													<input type="hidden" name="id" value="${entityB38.id}" id="idB38" />
													<input type="hidden" name="id" value="${entityB39.id}" id="idB39" />
													<input type="hidden" name="id" value="${entityB40.id}" id="idB40" />
													<!-- 基站A保留1 -->
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel A</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA37" value="${entityA37.startSlot==null?0:entityA37.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA38" value="${entityA38.startSlot==null?0:entityA38.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA39" value="${entityA39.startSlot==null?0:entityA39.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotA40" value="${entityA40.startSlot==null?0:entityA40.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA37" value="${entityA37.increment==null?0:entityA37.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA38" value="${entityA38.increment==null?0:entityA38.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA39" value="${entityA39.increment==null?0:entityA39.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementA40" value="${entityA40.increment==null?0:entityA40.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA37" value="${entityA37.slotNumber==null?0:entityA37.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA38" value="${entityA38.slotNumber==null?0:entityA38.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA39" value="${entityA39.slotNumber==null?0:entityA39.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberA40" value="${entityA40.slotNumber==null?0:entityA40.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA37" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA37.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA37.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA37.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA38" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA38.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA38.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA38.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA39" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA39.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA39.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA39.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipA40" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityA40.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityA40.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityA40.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA37" value="${entityA37.timeout==null?0:entityA37.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA38" value="${entityA38.timeout==null?0:entityA38.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA39" value="${entityA39.timeout==null?0:entityA39.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutA40" value="${entityA40.timeout==null?0:entityA40.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														<colgroup>
															<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
															<col width="90"></col>
															<col></col>
															<col width="90"></col> 
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
								                 			<col width="90"></col>
								                 			<col></col>
														</colgroup>
														<thead class="portlet-title">
															<tr>
																<th colspan="8">Channel B</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB37" value="${entityB37.startSlot==null?0:entityB37.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB38" value="${entityB38.startSlot==null?0:entityB38.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB39" value="${entityB39.startSlot==null?0:entityB39.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Start Slot</label></th>
																<td>
																<input type="text" name="startSlot" id="startSlotB40" value="${entityB40.startSlot==null?0:entityB40.startSlot}" style="width: 80px"
																	datatype="/(^(-)1|0$)|(^[1-9]\d{0,2}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/" sucmsg=" " nullmsg="请输入启动时隙!" 
																	class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>	
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB37" value="${entityB37.increment==null?0:entityB37.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB38" value="${entityB38.increment==null?0:entityB38.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB39" value="${entityB39.increment==null?0:entityB39.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Increment</label>
																</th>
																<td><input type="text" name="increment" id="incrementB40" value="${entityB40.increment==null?0:entityB40.increment}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入步长!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB37" value="${entityB37.slotNumber==null?0:entityB37.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB38" value="${entityB38.slotNumber==null?0:entityB38.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB39" value="${entityB39.slotNumber==null?0:entityB39.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
																<th><label class="">Block Size</label></th>
																<td><input type="text" name="slotNumber" id="slotNumberB40" value="${entityB40.slotNumber==null?0:entityB40.slotNumber}" style="width: 80px"
																	datatype="*" sucmsg=" " nullmsg="请输入时隙数目!" class="input-normal input-wd20  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB37" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB37.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB37.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB37.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB38" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB38.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB38.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB38.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB39" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB39.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB39.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB39.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
																<th><label class="">Ownership</label>
																</th>
																<td>
																	<select name="ownership" id="ownershipB40" class="m-wrap span10"
																		datatype="*" sucmsg=" " nullmsg="请选择所有权!" onchange="changeAttribute('A')">
														                <option value="L" <c:if test="${entityB40.ownership=='L' }">selected="selected"</c:if>>Local</option>
														                <option value="R" <c:if test="${entityB40.ownership=='R' }">selected="selected"</c:if>>Remote</option>
														                <option value="C" <c:if test="${entityB40.ownership=='C' }">selected="selected"</c:if>>Clear</option>
									            					</select>
																</td>
															</tr>
															<tr>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB37" value="${entityB37.timeout==null?0:entityB37.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB38" value="${entityB38.timeout==null?0:entityB38.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB39" value="${entityB39.timeout==null?0:entityB39.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
																<th><label class="">Timeout</label>
																</th>
																<td><input type="text" name="timeout" id="timeoutB40" value="${entityB40.timeout==null?0:entityB40.timeout}" style="width: 80px"
																		datatype="*" sucmsg=" " nullmsg="请输入超时!" class="input-normal input-wd10  fn-left" />
																</td>
															</tr>
														</tbody>
													</table>
													</div>
													<table class="table table-striped table-hover" >
														<tfoot>
															<tr>
															<td colspan="4" style="text-align:center;">
															<button type="submit" class="btn green" onclick="setStatus('0','10')">保存</button>
															<button type="submit" class="btn btn-submit" onclick="setStatus('1','10')" style="background-color: #FF7F50">设置</button>
															</td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--END TABS-->
						</div>
					</div>
				</div>
				<div id="note" class="alert alert-success hide">
					<button class="close" data-dismiss="alert"></button>
					<span id="note_msg">操作成功！</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END PAGE CONTAINER-->
<!-- END PAGE -->
<!-- BEGIN FOOTER -->
<%@include file="../../admin/include/foot.jsp"%>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../../admin/include/js.jsp"%>
<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
<!-- END JAVASCRIPTS -->
	<script type="text/javascript">
		function setStatus(status, id){
			$("#status" + id).val(status);
		}
	</script>
	<!-- js验证 -->
	<script>
		jQuery(document).ready(function() {
			var form = $('#form-validate1');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate2');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate3');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate4');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate5');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate6');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate7');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate8');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate9');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		jQuery(document).ready(function() {
			var form = $('#form-validate10');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
         
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	startSlot:{
                		required:true,
                		Integer:true,
                		number:true,
                		range:[0,2249]
                	},
                	increment:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,1125]
                    },
                    slotNumber:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,5]
                    },
                    timeout:{
                        required:true,
                		number:true,
                		Integer:true,
                        range:[0,7]
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	startSlot:{
                		required:"请输入启动时隙",
                		Integer:"时隙取值为整数",
                		number:"时隙取值为整数",
                		range:"时隙范围是0-2249",
                	},
                	increment:{
                        required:"请输入增益值",
                        range:"增益取值为0~1125",
                		number:"增益取值为整数",
                        Integer:"增益取值为整数"
                    },
                    slotNumber:{
                        required:"请输入时隙数目",
                        range:"时隙取值为0~5",
                        number:"时隙取值为整数",
                        Integer:"时隙取值为整数"
                    },
                    timeout:{
                        required:"请输入超时",
                        range:"超时取值为0~7",
                        number:"超时取值为整数",
                        Integer:"超时取值为整数"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		
		
	</script>
	
    <style type="text/css">
         span.help-inline{
         color:red;
        }
    </style>
</html>
