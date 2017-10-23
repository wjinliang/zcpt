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
							基站管理<small>新增/修改基站基本信息</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i><a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="${root}/siteinfo/list">基站连接</a>
								<i class="icon-angle-right"></i>
							</li>
							<li>
								<a>表单</a>
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
									<input type="hidden" name="id" value="${siteInfo.id}" />
									<div class="alert alert-error hide">

										<button class="close" data-dismiss="alert"></button>

										表单填写不正确，请仔细核查。

									</div>

									<div class="alert alert-success hide">

										<button class="close" data-dismiss="alert"></button>

										提交成功，等待跳转！

									</div>

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
													<th>
														<label class="control-label">Site Name<span class="required">*</span></label>
													</th>
													<!--数据项名称用th-->
													<td><input type="text" id="sitename" <c:if test="${mode == 'view'}">readonly</c:if> name="sitename" value="${siteInfo.sitename}" 
															datatype="*" sucmsg=" " nullmsg="请输入基站名称!" class="input-normal input-wd200  fn-left" /></td>
													
													<th><label class="control-label">基站类型<span class="required">*</span></label></th>
													<!--数据项名称用th-->
													<td>
													
													<select name="siteType" id="siteType" datatype="*" sucmsg=" " nullmsg="请选择功率!" 
														onchange="changeSingleOrDouble();" class="input-select input-wd200" >
										                <option value="0" >单</option>
										                <option value="1" >双</option>
						           					</select>
													</td>
												</tr>
												<tr id="single">
													<th><label class="control-label">IP Address A<span class="required">*</span></label>
													</th>
													<td>
														<input type="text" id="ipAddressA" name="ipAddressA" <c:if test="${mode == 'view'}">readonly</c:if>  value="${siteInfo.ipAddressA}" 
														datatype="/^([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/" 
														sucmsg=" " nullmsg="请输入IP!" errormsg="请输入正确的IP地址!" class="input-normal input-wd200  fn-left" />
													</td>
												
													<th><label class="control-label">Port A<span class="required">*</span></label>
													</th>
													<td>
														<input type="text" id="portA" name="portA" <c:if test="${mode == 'view'}">readonly</c:if> value="${siteInfo.portA}" 
														datatype="n" sucmsg=" " nullmsg="请输入Port!" class="input-normal input-wd200  fn-left" />
													</td>
													
												</tr>
												<tr id="double">
													<th><label class="control-label">IP Address B<span class="required">*</span></label>
													</th>
													<td>
														<input type="text" id="ipAddressB" name="ipAddressB" class="input-normal input-wd200  fn-left" />
													</td>
												
													<th><label class="control-label">Port B<span class="required">*</span></label>
													</th>
													<td>
														<input type="text" id="portB" name="portB" class="input-normal input-wd200  fn-left" />
													</td>
													
												</tr>
												<tr>
													<th>
													<label class="control-label">Power<span class="required">*</span></label>
													</th>
													<!--数据项名称用th-->
													<td>
													
													<select name="power" id="power" datatype="*" sucmsg=" " nullmsg="请选择功率!" class="input-select input-wd200" >
										                <option value="">请选择</option>
										                <option value="0" <c:if test="${siteInfo.power=='0' }">selected="selected"</c:if>>高功率</option>
										                <option value="1" <c:if test="${siteInfo.power=='1' }">selected="selected"</c:if>>低功率</option>
						           					</select>
													</td>
													
													<th>
													<label class="control-label">Talker ID<span class="required">*</span></label>
													</th>
													<!--数据项名称用th-->
													<td>
													<select name="talkerID" id="talkerID" class="input-select input-wd200" >
										                <option value="AB" <c:if test="${siteInfo.talkerID=='AB' }">selected="selected"</c:if>>AIS基站</option>
										                <option value="AL" <c:if test="${siteInfo.talkerID=='AL' }">selected="selected"</c:if>>受限AIS基站</option>
										                <option value="AS" <c:if test="${siteInfo.talkerID=='AS' }">selected="selected"</c:if>>单一中继站</option>
										                <option value="AD" <c:if test="${siteInfo.talkerID=='AD' }">selected="selected"</c:if>>双重中继站</option>
										                <option value="AR" <c:if test="${siteInfo.talkerID=='AR' }">selected="selected"</c:if>>接收站</option>
						           					</select>
													</td>
												</tr>
												<tr>
													<th><label class="control-label">Area<span class="required">*</span></label></th>
													<td>
														<select id="areaId" name="areaId" datatype="*" sucmsg=" " nullmsg="请选择海区!"  class="input-select input-wd200" 
															onchange="getSub('jurisdictionsId','areaId');getSub('addressId','jurisdictionsId');setArea();">
															<option>请选择</option>
														</select>
														<input type="hidden" id="area" name="area" value="${siteInfo.area }"/>
													</td>
													
													<th><label class="control-label">Jurisdictions<span class="required">*</span></label></th>
													<td>
														<select id="jurisdictionsId" name="jurisdictionsId" datatype="*" sucmsg=" " nullmsg="请选择辖区!"  class="input-select input-wd200" 
															onchange="getSub('addressId','jurisdictionsId');setJurisdictions();">
															<option>请选择</option>
														</select>
														<input type="hidden" id="jurisdictions" name="jurisdictions" value="${siteInfo.jurisdictions }"/>
													</td>
												</tr>
												<tr>
													<th><label class="control-label">Address<span class="required">*</span></label></th>
													<td>
														<select id="addressId" name="addressId" datatype="*" sucmsg=" " nullmsg="请选择地址!"  class="input-select input-wd200" 
															onclick="setAddress();setAgreementId();">
															<option>请选择</option>
														</select>
														<input type="hidden" id="address" name="address" value="${siteInfo.address }"/>
														<input type="hidden" id="agreementId" name="agreementId" value="${siteInfo.agreementId }"/>
													</td>
													
													<th><label class="control-label">Manufacturer<span class="required">*</span></label></th>
													<td>
														<select id="manufacturerId" name="manufacturerId" class="input-select input-wd200"
															datatype="*" sucmsg=" " nullmsg="请选择厂商!" onchange="setManufacturer();">
															<option>请选择</option>
														</select>
														<input type="hidden" id="manufacturer" name="manufacturer" value="${siteInfo.manufacturer }"/>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									
									<div class="form-actions">

										<button type="submit" class="btn green">提交</button>

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
	
	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>

	<script type="text/javascript" src="<%=basePath%>themes/media/js/additional-methods.min.js"></script>

	<script type="text/javascript" src="<%=basePath%>themes/media/js/select2.min.js"></script>

	<script type="text/javascript" src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->
	
	<script>
	//初始化页面样式
	changeSingleOrDouble();
	function changeSingleOrDouble() {
		if($("#siteType").val()=="0") {
			$("#double").hide();
		} else {
			$("#double").show();
		}
	}
	</script>
	
	<script>
		jQuery(document).ready(function() {
			var form = $('#formValidate');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	sitename: {
                        minlength: 2,
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	sitename: {
                        required: "请输入基站名称",
                        minlength: jQuery.format("至少 输入{0}长度的实例名称")
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

	<!-- END JAVASCRIPTS -->
</html>
