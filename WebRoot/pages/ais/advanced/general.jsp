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
<title>基站设置参数</title>
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

					<li class="inbox active" title="General">
						<a href="${root}/siteinfo/setting/form/${siteInfoId}/1" class="btn" data-title="General">General</a><b></b>
					</li>
						
					<li class="mark" title="Reporting Rates">
						<a href="${root}/siteinfo/report/advanced/form/${siteInfoId}" class="btn" data-title="Reporting Rates">Reporting Rates</a><b></b>
					</li>

					<li class="sent" title="Data Link Management">
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
				<div class="portlet box">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-reorder"></i>基站设置类接口参数
						</div>
					</div>
					<div class="portlet-body form">
	
						<form name="form" id="form-validate" action="${root}/siteinfo/setting/generalSetting" method="post">
							<div class="alert alert-error hide">

								<button class="close" data-dismiss="alert"></button>

									表单填写不正确，请仔细核查。

							</div>

							<div class="alert alert-success hide">

								<button class="close" data-dismiss="alert"></button>

									提交成功，等待跳转！

							</div>
							<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
							<input type="hidden" name="agreementid" value="${entity.agreementid}" id="agreementid" />
							<input type="hidden" name="id" value="${entity.id}" id="id" />
							<input type="hidden" name="status" value="" id="status" />
							<div class="dataTables_wrapper form-inline">
								<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
									<colgroup>
										<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
										<col width="145"></col>
										<col width="390"></col>
										<col width="150"></col>
			                 			<col width="400"></col>
									</colgroup>
									<tbody>
										<tr>
											<th><label class="control-label" title="mmsi">MMSI:</label></th>
											<td>
												<input type="text" name="mmsi" id="mmsi" value="${entity.mmsi}" 
													datatype="n9-9" sucmsg=" " nullmsg="请输入mmsi!" errormsg="mmsi为9位有效数字!" class="input-normal input-wd200  fn-left" />
											</td>
											<th><label class="control-label" title="Unique id">Unique id</label></th>
											<td>
												<input type="text" name="uid" id="uid" value="${entity.uid}" class="input-normal input-wd200  fn-left" />
											</td>
										</tr>
										<tr>
											<th>
											<label class="control-label">lat</label>
											</th>
											<!--数据项名称用th-->
											<td>
											<input type="text" name="lat" id="lat" maxlength="10" value="${entity.lat}" class="input-normal input-wd200  fn-left" 
												datatype="^/-?(90|[0-8]?\d(\.\d{1,6})?)$/" sucmsg=" " nullmsg="请输入纬度值!" errormsg="请输入正确的纬度值!" />
											</td>
										
											<th>
											<label class="control-label">S/N</label>
											</th>
											<td>
											<input type="radio" name="latType" id="latType1" value="S" checked="checked" />
											<label for="latType1">S</label>
											<input type="radio" name="latType" id="latType2" value="N" <c:if test="${entity.latType=='N' }">checked="checked"</c:if> />
											<label for="latType2">N</label>
											</td>
										</tr>
										<tr>
											<th>
											<label class="control-label">Lon</label>
											</th>
											<td>
											<input type="text" name="lon" id="lon" value="${entity.lon}" maxlength="11" class="input-normal input-wd200  fn-left" 
												datatype="/^-?(180|1?[0-7]?\d(\.\d{1,6})?)$/" sucmsg=" " nullmsg="请输入经度值!" errormsg="请输入正确的经度值!" />
											</td>
											<th>
											<label class="control-label">E/W</label>
											</th>
											<td>
											<input type="radio" name="lonType" id="lonType1" value="E" checked="checked" />
											<label for="lonType1">E</label>
											<input type="radio" name="lonType" id="lonType2" value="W" <c:if test="${entity.lonType=='W' }">checked="checked"</c:if> />
											<label for="lonType2">W</label>
											</td>
										</tr>
										<tr>
											<th>
											<label class="control-label">Accuracy</label>
											</th>
											<!--数据项名称用th-->
											<td>
											
											<select name="highAccuracy" id="highAccuracy" class="input-select input-wd200" 
													datatype="*" sucmsg=" " nullmsg="请选择位置精确度!" >
								                <option value="">请选择</option>
								                <option value="1" <c:if test="${entity.highAccuracy=='1' }">selected="selected"</c:if>>高</option>
								                <option value="0" <c:if test="${entity.highAccuracy=='0' }">selected="selected"</c:if>>低</option>
			            					</select>
											</td>
											
											<th><label class="control-label" >Position Source</label></th>
											<td>
												<select name="positionSource" id="positionSource" class="input-select input-wd210" >
									                <option value="0">Surveyed</option>
									                <option value="1" <c:if test="${entity.positionSource=='1' }">selected="selected"</c:if>>Internal</option>
									                <option value="2" <c:if test="${entity.positionSource=='2' }">selected="selected"</c:if>>External</option>
									                <option value="3" <c:if test="${entity.positionSource=='3' }">selected="selected"</c:if>>Internal with Fallback to Surveyed</option>
									                <option value="4" <c:if test="${entity.positionSource=='4' }">selected="selected"</c:if>>Internal with Fallback to External</option>
									                <option value="5" <c:if test="${entity.positionSource=='5' }">selected="selected"</c:if>>External with Fallback to Surveyed</option>
									                <option value="6" <c:if test="${entity.positionSource=='6' }">selected="selected"</c:if>>Exteranl with Fallback to Internal</option>
				            					</select>
											</td>
										</tr>
										<tr>
											<th>
											<label class="control-label">RX Channel A</label>
											</th>
											<!--数据项名称用th-->
											<td>
											<input type="text" name="rxChannelA" id="rxChannelA" value="${entity.rxChannelA}" class="input-normal input-wd200  fn-left"
												datatype="/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/" sucmsg=" " nullmsg="请输入RX频道A值!" errormsg="请输入正确的RX频道A值!范围值:1001-2287" />
											</td>
			
											<th>
											<label class="control-label">RX Channel B</label>
											</th>
											<!--数据项名称用th-->
											<td>
											<input type="text" name="rxChannelB" id="rxChannelB" value="${entity.rxChannelB}" class="input-normal input-wd200  fn-left" 
												datatype="/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/" sucmsg=" " nullmsg="请输入RX频道B值!" errormsg="请输入正确的RX频道B值!范围值:1001-2287" />
											</td>
										</tr>
										<tr>
											<th>
											<label class="control-label">TX Channel A</label>
											</th>
											<!--数据项名称用th-->
											<td>
											<input type="text" name="txChannelA" id="txChannelA" value="${entity.txChannelA}" class="input-normal input-wd200  fn-left"
												datatype="/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/" sucmsg=" " nullmsg="请输入TX频道A!" errormsg="请输入正确的TX频道A!范围值:1001-2287" />
											</td>
			
											<th>
											<label class="control-label">TX Channel B</label>
											</th>
											<!--数据项名称用th-->
											<td>
											<input type="text" name="txChannelB" id="txChannelB" value="${entity.txChannelB}" class="input-normal input-wd200  fn-left"
												datatype="/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/" sucmsg=" " nullmsg="请输入TX频道B!" errormsg="请输入正确的TX频道B!范围值:1001-2287"  />
											</td>
										</tr>
										<tr>
											<th>
											<label class="control-label">High Power A</label>
											</th>
											<!--数据项名称用th-->
											<td>
											
											<select name="highPowerA" id="highPowerA" class="input-select input-wd200" 
													datatype="*" sucmsg=" " nullmsg="请选择基站A频道功率!">
								                <option value="">请选择</option>
								                <option value="0" <c:if test="${entity.highPowerA=='0' }">selected="selected"</c:if>>高功率</option>
								                <option value="1" <c:if test="${entity.highPowerA=='1' }">selected="selected"</c:if>>低功率</option>
			            					</select>
											</td>
			
											<th>
											<label class="control-label">High Power B</label>
											</th>
											<!--数据项名称用th-->
											<td>
											
											<select name="highPowerB" id="highPowerB" class="input-select input-wd200"
													datatype="*" sucmsg=" " nullmsg="请选择基站B频道功率!" >
								                <option value="">请选择</option>
								                <option value="0" <c:if test="${entity.highPowerB=='0' }">selected="selected"</c:if>>高功率</option>
								                <option value="1" <c:if test="${entity.highPowerB=='1' }">selected="selected"</c:if>>低功率</option>
			            					</select>
											</td>
										</tr>
										<tr>
											<th>
											<label class="control-label">Msg Retries</label>
											</th>
											<!--数据项名称用th-->
											<td>
											
											<select name="retriesNumber" id="retriesNumber" class="input-select input-wd200"
													datatype="*" sucmsg=" " nullmsg="请选择基站报文重试次数!">
								                <option value="">请选择</option>
								                <option value="0" <c:if test="${entity.retriesNumber=='0' }">selected="selected"</c:if>>0次</option>
								                <option value="1" <c:if test="${entity.retriesNumber=='1' }">selected="selected"</c:if>>1次</option>
								                <option value="2" <c:if test="${entity.retriesNumber=='2' }">selected="selected"</c:if>>2次</option>
								                <option value="3" <c:if test="${entity.retriesNumber=='3' }">selected="selected"</c:if>>3次</option>
			            					</select>
											</td>
										
											<th>
											<label class="control-label">Repeat Indicatior</label>
											</th>
											<!--数据项名称用th-->
											<td>
											
											<select name="repeatIndicator" id="repeatIndicator" class="input-select input-wd200"
													datatype="*" sucmsg=" " nullmsg="请选择报文重复指示次数!" >
								                <option value="">请选择</option>
								                <option value="0" <c:if test="${entity.repeatIndicator=='0' }">selected="selected"</c:if>>0次</option>
								                <option value="1" <c:if test="${entity.repeatIndicator=='1' }">selected="selected"</c:if>>1次</option>
								                <option value="2" <c:if test="${entity.repeatIndicator=='2' }">selected="selected"</c:if>>2次</option>
								                <option value="3" <c:if test="${entity.repeatIndicator=='3' }">selected="selected"</c:if>>3次</option>
			            					</select>
											</td>
										</tr>
									</tbody>
									<tfoot>
										<tr>
										<td colspan="4" style="text-align:center;">
										<button type="submit" class="btn green" onclick="setStatus('0')">保存</button>
										<button type="submit" class="btn btn-submit" onclick="setStatus('1')" style="background-color: #FF7F50">设置</button></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</form>
	
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
		function setStatus(status){
			$("#status").val(status);
		}
	</script>
	<!-- js验证 -->
	<script>
		jQuery(document).ready(function() {
			var form = $('#form-validate');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
            
            jQuery.validator.addMethod("lat", function(value, element) {
            var lat=/^-?(90|[0-8]?\d(\.\d{1,6})?)$/;
            return this.optional(element) || lat.test(value) ;
          }, "请输入正确的纬度值");
          
          jQuery.validator.addMethod("lon", function(value, element) {
            var lon=/^-?(180|1?[0-7]?\d(\.\d{1,6})?)$/;
            return this.optional(element) || lon.test(value) ;
          }, "请输入正确的经度值");
          
          jQuery.validator.addMethod("Channel", function(value, element) {
            var Channel=/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/;
            return this.optional(element) || Channel.test(value) ;
          }, "请输入正确的频道值，范围值:1001-2287");
          
          jQuery.validator.addMethod("uid", function(value, element) {
              var uid=/^[0-9A-Za-z//]{0,15}$/;
              return this.optional(element) || uid.test(value) ;
            }, "Unique id是0~15位的数字和字母的组合");
          
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
                	},
                	uid:{
                	required:true,
                	uid:true,
                	},
                	lat:{
                	required:true,
                	lat:true
                	},
                	lon:{
                	required:true,
                	lon:true
                	},
                	highAccuracy:{
                	required:true
                	},
                	rxChannelA:{
                	required:true,
                	Channel:true
                	},
                	rxChannelB:{
                	required:true,
                	Channel:true
                	},
                	txChannelA:{
                	required:true,
                	Channel:true
                	},
                	txChannelB:{
                	required:true,
                	Channel:true
                	},
                	highPowerA:{
                	required:true
                	},
                	highPowerB:{
                	required:true
                	},
                	retriesNumber:{
                	required:true
                	},
                	repeatIndicator:{
                	required:true
                	}
                },

                messages: { // custom messages for radio buttons and checkboxes
                	mmsi:{
                	required:"请输入MMSI",
                	rangelength:"MMSI最大为9位有效数字",
                	digits:"MMSI最大为9位有效数字"
                	},
                	uid:{
                	required:"请输入Unique id",
                	},
                	lat:{
                	required:"请输入纬度值"
                	},
                	lon:{
                	required:"请输入经度值"
                	},
                	highAccuracy:{
                	required:"请选择位置精确度"
                	},
                	rxChannelA:{
                	required:"请输入RX频道A值!",
                	Channel:"请输入正确的RX频道A值!范围值:1001-2287"
                	},
                	rxChannelB:{
                	required:"请输入RX频道B值!",
                	Channel:"请输入正确的RX频道B值!范围值:1001-2287"
                	},
                	txChannelA:{
                	required:"请输入TX频道A!",
                	Channel:"请输入正确的TX频道A!范围值:1001-2287"
                	},
                	txChannelB:{
                	required:"请输入TX频道B!",
                	Channel:"请输入正确的TX频道B!范围值:1001-2287"
                	},
                	highPowerA:{
                	required:"请选择基站A频道功率!"
                	},
                	highPowerB:{
                	required:"请选择基站B频道功率!"
                	},
                	retriesNumber:{
                	required:"请选择基站报文重试次数!"
                	},
                	repeatIndicator:{
                	required:"请选择报文重复指示次数!"
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
