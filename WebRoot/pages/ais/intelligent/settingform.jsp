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
<title>基站管理-智能配置</title>
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
								<a>基站设置</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>基站配置信息
								</div>
							</div>
							
							<div class="portlet-body form">
								<!-- BEGIN FORM-->
								<form name="form" id="form-validate" class="form-horizontal" action="${root}/siteinfo/setting/nextConfigure" method="post">
									<div class="alert alert-error hide">

										<button class="close" data-dismiss="alert"></button>

										表单填写不正确，请仔细核查。

									</div>

									<div class="alert alert-success hide">

										<button class="close" data-dismiss="alert"></button>

										提交成功，等待跳转！

									</div>
									<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
									<input type="hidden" name="id" value="${entity.id}" id="id" />
									<input type="hidden" name="status" value="" id="status" />
									<div class="dataTables_wrapper form-inline">
										<table id="setting_table" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
											<colgroup>
												<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
												<col width="145"></col>
												<col width="390"></col>
												<col width="150"></col>
							               		<col width="400"></col>
											</colgroup>
											<tbody>
												<tr>
													<th><label class="control-label" title="mmsi">MMSI</label></th>
													<td>
														<input type="text" name="mmsi" id="mmsi" value="${entity.mmsi}"  class="input-normal input-wd200  fn-left" />
													</td>
													
													<th><label class="control-label" title="Unique id">Unique id</label></th>
													<td>
														<input type="text" name="uid" id="uid" value="${entity.uid}"  disabled="disabled" class="input-normal input-wd200  fn-left" />
													</td>
												</tr>
												<tr>
													<th>
													<label class="control-label">Lat</label>
													</th>
													<!--数据项名称用th-->
													<td>
													<input type="text" name="lat" id="lat" value="${entity.lat}"  disabled="disabled" class="input-normal input-wd200  fn-left" 
														datatype="/^-?(90|[0-8]?\d(\.\d{1,6})?)$/" sucmsg=" " nullmsg="请输入纬度值!" errormsg="请输入正确的纬度值!" />
													</td>
												
													<th>
													<label class="control-label">S/N</label>
													</th>
													<td>
													<input type="radio" name="latType" id="latType1"  disabled="disabled" value="S" <c:if test="${entity.latType=='S' }">checked="checked"</c:if>/>
													<label for="latType1" >S</label>
													<input type="radio" name="latType" id="latType2"  disabled="disabled" value="N" <c:if test="${entity.latType=='N' }">checked="checked"</c:if> />
													<label for="latType2" >N</label>
													</td>
												</tr>
												<tr>
													<th>
													<label class="control-label">Lon</label>
													</th>
													<td>
													<input type="text" name="lon" id="lon" value="${entity.lon}"  disabled="disabled" class="input-normal input-wd200  fn-left" 
														datatype="/^-?(180|1?[0-7]?\d(\.\d{1,6})?)$/" sucmsg=" " nullmsg="请输入经度值!" errormsg="请输入正确的经度值!" />
													</td>
													<th>
													<label class="control-label">E/W</label>
													</th>
													<td>
													<input type="radio" name="lonType"  disabled="disabled" id="lonType1" value="E" <c:if test="${entity.lonType=='E' }">checked="checked"</c:if>/>
													<label for="lonType1">E</label>
													<input type="radio" name="lonType"  disabled="disabled"  id="lonType2" value="W" <c:if test="${entity.lonType=='W' }">checked="checked"</c:if> />
													<label for="lonType2">W</label>
													</td>
												</tr>
												<tr>
													<th>
													<label class="control-label">Accuracy</label>
													</th>
													<!--数据项名称用th-->
													<td>
													<select name="highAccuracySel" id="highAccuracySel"   disabled="disabled" class="input-select input-wd200" >
										                <option value="1" <c:if test="${entity.highAccuracy=='1' }">selected="selected"</c:if>>高</option>
										                <option value="0" <c:if test="${entity.highAccuracy=='0' }">selected="selected"</c:if>>低</option>
							          					</select>
							          					<input type="hidden" name="highAccuracy" id="highAccuracy" />
													</td>
													<th><label class="control-label" >Position Source</label></th>
													<td>
														<select name="positionSourceSel" id="positionSourceSel" disabled="disabled" class="input-select input-wd210" >
											                <option value="0">Surveyed</option>
											                <option value="1" <c:if test="${entity.positionSource=='1' }">selected="selected"</c:if>>Internal</option>
											                <option value="2" <c:if test="${entity.positionSource=='2' }">selected="selected"</c:if>>External</option>
											                <option value="3" <c:if test="${entity.positionSource=='3' }">selected="selected"</c:if>>Internal with Fallback to Surveyed</option>
											                <option value="4" <c:if test="${entity.positionSource=='4' }">selected="selected"</c:if>>Internal with Fallback to External</option>
											                <option value="5" <c:if test="${entity.positionSource=='5' }">selected="selected"</c:if>>External with Fallback to Surveyed</option>
											                <option value="6" <c:if test="${entity.positionSource=='6' }">selected="selected"</c:if>>Exteranl with Fallback to Internal</option>
							           					</select>
							           					<input type="hidden" name="positionSource" id="positionSource" />
													</td>
												</tr>
												<tr>
													<th>
													<label class="control-label">Channel A</label>
													</th>
													<!--数据项名称用th-->
													<td>
													<input type="text" name="rxChannelA" id="rxChannelA"  disabled="disabled" value="${entity.rxChannelA}" class="input-normal input-wd200  fn-left" />
													</td>
							
													<th>
													<label class="control-label">Channel B</label>
													</th>
													<!--数据项名称用th-->
													<td>
													<input type="text" name="rxChannelB" id="rxChannelB"  disabled="disabled" value="${entity.rxChannelB}" class="input-normal input-wd200  fn-left" />
													</td>
												</tr>
												<tr>
													<th>
													<label class="control-label">Msg Retries</label>
													</th>
													<!--数据项名称用th-->
													<td>
														<select name="retriesNumberSel" id="retriesNumberSel"   disabled="disabled"class="input-select input-wd200" >
											                <option value="0" <c:if test="${entity.retriesNumber=='0' }">selected="selected"</c:if>>0次</option>
											                <option value="1" <c:if test="${entity.retriesNumber=='1' }">selected="selected"</c:if>>1次</option>
											                <option value="2" <c:if test="${entity.retriesNumber=='2' }">selected="selected"</c:if>>2次</option>
											                <option value="3" <c:if test="${entity.retriesNumber=='3' }">selected="selected"</c:if>>3次</option>
							          					</select>
							          					<input type="hidden" name="retriesNumber" id="retriesNumber" />
													</td>
												
													<th>
													<label class="control-label">Repeat Indicatior</label>
													</th>
													<!--数据项名称用th-->
													<td>
														<select name="repeatIndicatorSel" id="repeatIndicatorSel"  disabled="disabled" class="input-select input-wd200" >
											                <option value="0" <c:if test="${entity.repeatIndicator=='0' }">selected="selected"</c:if>>0次</option>
											                <option value="1" <c:if test="${entity.repeatIndicator=='1' }">selected="selected"</c:if>>1次</option>
											                <option value="2" <c:if test="${entity.repeatIndicator=='2' }">selected="selected"</c:if>>2次</option>
											                <option value="3" <c:if test="${entity.repeatIndicator=='3' }">selected="selected"</c:if>>3次</option>
							          					</select>
							          					<input type="hidden" name="repeatIndicator" id="repeatIndicator" />
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="form-actions"  style="padding-left: 0px;text-align:center;">
										<button type="submit" class="btn green">下一步</button> 
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
	<!-- js验证 -->
	<script>
		jQuery(document).ready(function() {
			var form = $('#form-validate');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	mmsi:{
                	required:true,
                	rangelength:[0,9],
                	digits:true
                	}
                },

                messages: { // custom messages for radio buttons and checkboxes
                	mmsi:{
                	required:"请输入MMSI",
                	rangelength:"MMSI最大为9位有效数字",
                	digits:"MMSI最大为9位有效数字"
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
</body>
</html>