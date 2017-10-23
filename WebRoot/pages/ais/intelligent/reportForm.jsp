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
<title>基站管理-分配基站报文报告率</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/select2_metro.css" />

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/chosen.css" />

<!-- END PAGE LEVEL STYLES -->

</head>
<!-- END HEAD -->

<!-- BEGIN HEADER -->
<%@include file="../../admin/include/head.jsp"%>
<!-- END HEADER -->

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
							<i class="icon-angle-right"></i></li>
						<li><a href="${root}/siteinfo/list">基站连接</a> <i
							class="icon-angle-right"></i></li>
						<li><a>分配基站报文报告率</a></li>
					</ul>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span12">
					<form name="form" id="form-validate" action="${root}/siteinfo/report/intelligent/saveSetting" method="post">
						<input type="hidden" name="siteInfoId4" value="${siteInfoId}" id="siteInfoId4" />
						<input type="hidden" name="uid4" value="${entity1.uid}" id="uid4" />
						<input type="hidden" name="msgId4" value="${entity1.reportRatesForMsgType}" id="msgId4" />
						<input type="hidden" name="id4" value="${entity1.id}" id="id4" />
						<div class="portlet box">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>Msg 4(Base Station Report)
								</div>
							</div>

							<div class="portlet-body form">
								<!-- BEGIN FORM-->
								<!-- 报文4 -->
								<div class="dataTables_wrapper form-inline" id="formtabs2_cont0">
									<table id="" class="table table-striped table-hover"
										summary="这是一个1行1列的表格样式模板">
										<colgroup>
											<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
											<col width="180"></col>
											<col width="360"></col>
											<col width="180"></col>
											<col width="350"></col>
										</colgroup>
										<tbody>
											<tr>
												<th><label class="">UTC Minute(Ch A)</label>
												</th>
												<td>
												   <input type="text" value="${entity1.chAutcMinute}" id="chAutcMinute4" disabled="disabled" class="input-normal input-wd200  fn-left" />
												   <input type="hidden" name="chAutcMinute4" value="${entity1.chAutcMinute}"/> 
												</td>
												<th><label class="">UTC Minute(Ch B)</label>
												</th>
												<td>
												    <input type="text" value="${entity1.chButcMinute}" id="chButcMinute4" disabled="disabled"  class="input-normal input-wd200  fn-left" />
												    <input type="hidden" name="chButcMinute4" value="${entity1.chButcMinute}"/>
												</td>
											</tr>
											<tr>
												<th><label class="">Start Slot(Ch A)</label></th>
												<td>
													<input type="text" value="${entity1.chASlot }" disabled="disabled" id="chASlot4" class="input-normal input-wd200  fn-left" />
													<input type="hidden" name="chASlot4" value="${entity1.chASlot }" /> 
												</td>
												<th><label class="">Start Slot(Ch B)</label>
												</th>
												<td>
													<input type="text" value="${entity1.chBSlot }" id="chBSlot4" disabled="disabled" class="input-normal input-wd200  fn-left" />
													<input type="hidden" name="chBSlot4" value="${entity1.chBSlot }" />
												</td>
											</tr>
											<tr>
												<th><label class="">Increment(Ch A)</label>
												</th>
												<td>
													<input type="text" name="chAIncrement4" value="${entity1.chAIncrement }" id="chAIncrement4" disabled="disabled"	class="input-normal input-wd200  fn-left" />
													<input type="hidden" name="chAIncrement4" value="${entity1.chAIncrement }" /> 
												</td>
												<th><label class="">Increment(Ch B)</label>
												</th>
												<td>
													<input type="text" value="${entity1.chAIncrement }" id="chBIncrement4" disabled="disabled" class="input-normal input-wd200  fn-left" />
													<input type="hidden" name="chBIncrement4" value="${entity1.chAIncrement }" />
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- END FORM-->
							</div>
						</div>
						<div class="portlet box">
							<input type="hidden" name="siteInfoId20" value="${siteInfoId}" id="siteInfoId20" />
							<input type="hidden" name="uid20" value="${entity3.uid}" id="uid20" />
							<input type="hidden" name="agreementid" value="${entity3.agreementid}" id="agreementid" />
							<input type="hidden" name="msgId20" value="${entity3.reportRatesForMsgType}" id="msgId20" />
							<input type="hidden" name="id20" value="${entity3.id}" id="id20" />
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>Msg 20(Data Link Mgmt)
								</div>
							</div>
							<div class="portlet-body form">
								<!-- BEGIN FORM-->
								<!-- 报文20 -->
								<div class="dataTables_wrapper form-inline" id="formtabs2_cont1">
									<table id="" class="table table-striped table-hover"
										summary="这是一个1行1列的表格样式模板">
										<colgroup>
											<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
											<col width="180"></col>
											<col width="360"></col>
											<col width="180"></col>
											<col width="350"></col>
										</colgroup>
										<tbody>
											<tr>
												<th><label class="">UTC Minute(Ch A)</label></th>
												<td>
												   <input type="text" id="chAutcMinute20" value="${entity3.chAutcMinute }" disabled="disabled" class="input-normal input-wd200  fn-left" />
												   <input type="hidden" name="chAutcMinute20" value="${entity3.chAutcMinute }" /> 
												</td>
												<th><label class="">UTC Minute(Ch B)</label></th>
												<td>
													<input type="text" id="chButcMinute20" value="${entity3.chButcMinute }" disabled="disabled" class="input-normal input-wd200  fn-left" />
													<input type="hidden" name="chButcMinute20" value="${entity3.chButcMinute }" /> 
												</td>
											</tr>
											<tr>
												<th><label class="">Start Slot(Ch A)</label></th>
												<td>
													<input type="text" name="chASlot20" id="chASlot20" value="${entity3.chASlot }" disabled="disabled" class="input-normal input-wd200  fn-left" />
													<input type="hidden" name="chASlot20" value="${entity3.chASlot }" />
												</td>
												<th><label class="">Start Slot(Ch B)</label></th>
												<td>
												    <input type="text" id="chBSlot20" value="${entity3.chBSlot }" disabled="disabled" class="input-normal input-wd200  fn-left" /> 
												    <input type="hidden" name="chBSlot20" value="${entity3.chBSlot }" />
												</td>
											</tr>
											<tr>
												<th><label class="">Increment(Ch A)</label></th>
												<td>
													<input type="text" id="chAIncrement20" value="${entity3.chAIncrement }" disabled="disabled" class="input-normal input-wd200  fn-left" />
													<input type="hidden" name="chAIncrement20"  value="${entity3.chAIncrement }" />	
												</td>

												<th><label class="">Increment(Ch B)</label></th>
												<td>
													<input type="text" id="chBIncrement20" value="${entity3.chAIncrement }" disabled="disabled" class="input-normal input-wd200  fn-left" />
													<input type="hidden" name="chBIncrement20" value="${entity3.chAIncrement }" />
												</td>
											</tr>
										</tbody>
									</table>
									<div class="form-actions"  style="padding-left: 0px;text-align:center;">
							            <button type="submit" class="btn green" onclick = "">保存设置</button> 
						            </div>
								</div>
								<!-- END FORM-->
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- END PAGE CONTAINER-->
	</div>
	<!-- END PAGE -->
</div>
<!-- BEGIN FOOTER -->
<%@include file="../../admin/include/foot.jsp"%>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../../admin/include/js.jsp"%>

<!-- BEGIN PAGE LEVEL PLUGINS -->

<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>

<script type="text/javascript" src="<%=basePath%>themes/media/js/additional-methods.min.js"></script>

<script type="text/javascript" src="<%=basePath%>themes/media/js/select2.min.js"></script>

<script type="text/javascript" src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>

<!-- END PAGE LEVEL PLUGINS -->

</body>
</html>