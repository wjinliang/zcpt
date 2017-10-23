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
<title>选择AIS设备的处理和输出</title>
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
<link href="<%=basePath%>themes/media/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" />
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
						<a href="${root}/siteinfo/report/advanced/form/${siteInfoId}" class="btn" data-title="Reporting Rates">Reporting Rates</a><b></b>
					</li>

					<li class="sent" title="Data Link Management">
						<a href="${root}/siteinfo/setting/advanced/dlmForm/${siteInfoId}" class="btn" data-title="Data Link Management">Data Link Manage..</a><b></b>
					</li>

					<li class="trash active" title="VSI FSR">
						<a href="${root}/siteinfo/advanced/output/form/${siteInfoId}" class="btn" >VSI FSR</a><b></b>
					</li>

				</ul>

			</div>
			
			<!-- 横条开始 -->
			<div class="span10">
			
			 <div class="breadcrumb">
			 <div class="portlet-title" style="margin-bottom:0px">
								<div class="caption">
									<i class="icon-reorder"></i>VSI FSR 参数设置
								</div>
							</div>
			 </div>
			</div>
			<!-- 横条结束 -->
			<div class="span10">
			<form name="form1" id="form-validate1" action="${root}/siteinfo/advanced/output/saveSetting" method="post">
				<div class="alert alert-error hide">

				<button class="close" data-dismiss="alert"></button>

				表单填写不正确，请仔细核查。

				</div>

				<div class="alert alert-success hide">

				<button class="close" data-dismiss="alert"></button>

				提交成功，等待跳转！

				</div>
			<table>
			
															<tr>
                                                                    <th><label class="">&nbsp;&nbsp;&nbsp;Channel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                                    </th>
                                                                    <td colspan="3">
                                                                    <select name="channel" id="channel" class="input-select input-wd200"
                                                                        datatype="*" sucmsg=" " nullmsg="请选择频道" style="width:329px">
                                                                        <option value="">请选择</option>
                                                                        <option value="A" <c:if test="${entity.channel=='A' }">selected="selected"</c:if>>频道A（Enable VSI/FSR Sentences About Channel A）</option>
                                                                        <option value="B" <c:if test="${entity.channel=='B' }">selected="selected"</c:if>>频道B（Enable VSI/FSR Sentences About Channel B）</option>
                                                                        <option value="E" <c:if test="${entity.channel=='E' }">selected="selected"</c:if>>每个频道（Enable VSI/FSR Sentences About Every Channel）</option>
                                                                        <option value="N" <c:if test="${entity.channel=='N' }">selected="selected"</c:if>>对任何频道都没有VSI或FSR语句（No VSI/FSR  Sentences About Any Channel)</option>
                                                                    </select>
                                                                    </td>
                                                                </tr>
			</table>
			<div class="row-fluid">
			<div class="span6">
			<div class="portlet box">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>VSI 
								</div>
							</div>
							<!--BEGIN TABS-->
							
											<div class="portlet-body form">													
													<input type="hidden" name="status" value="" id="status1" />
													<input type="hidden" name = "agreementid" value = "${agreementid}" id = "agreementid" />
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
													<input type="hidden" name="id" value="${entity.id}" id="id" />
													<!-- VSI语句的输出 -->
													<div class="dataTables_wrapper form-inline">
														<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
														
															<colgroup>
																<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
																<col width="250"></col>
																<col width="270"></col>
																
															</colgroup>
															<tbody>
																<tr>
																	<th><label class="">Output with Each VDM Sentence</label>
																	</th>
																	<td>
									            					<input type="radio" name="vdmSentence" id="vdmSentence1" value="1" checked="checked" />
																	<label for="vdmSentence1">开启</label>
																	<input type="radio" name="vdmSentence" id="vdmSentence2" value="0" <c:if test="${entity.vdmSentence=='0' }">checked="checked"</c:if> />
																	<label for="vdmSentence2">关闭</label>
																	</td>
																</tr>
																<tr>
																	<th><label class="">Output with Each VDO Sentence</label>
																	</th>
																	<td>
									            					<input type="radio" name="vdoSentence" id="vdoSentence1" value="1" checked="checked" />
																	<label for="vdoSentence1">开启</label>
																	<input type="radio" name="vdoSentence" id="vdoSentence2" value="0" <c:if test="${entity.vdoSentence=='0' }">checked="checked"</c:if> />
																	<label for="vdoSentence2">关闭</label>
																	</td>
																	
																	
																</tr>
																<tr>
																	<th><label class="">Output Signal<br/> Strength</label></th>
																	<td>
																	<select name="signalStrength" id="signalStrength" class="input-select input-wd200"
																		datatype="*" sucmsg=" " nullmsg="请选择VDL报文接受信号强度">
														                <option value="">请选择</option>
														                <option value="0" <c:if test="${entity.signalStrength=='0' }">selected="selected"</c:if>>无输出</option>
														                <option value="1" <c:if test="${entity.signalStrength=='1' }">selected="selected"</c:if>>连续输出</option>
														                <option value="2" <c:if test="${entity.signalStrength=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
									            					</select>
																	</td>
																	
																
																	
																</tr>
																<tr>
																	<th><label class="">Output First Slot Nr</label>
																	</th>
																	<td>
																	<select name="firstSlotNum" id="firstSlotNum" class="input-select input-wd200"
																		datatype="*" sucmsg=" " nullmsg="请选择每条报文第一时隙数">
														                <option value="">请选择</option>
														                <option value="0" <c:if test="${entity.firstSlotNum=='0' }">selected="selected"</c:if>>无输出</option>
														                <option value="1" <c:if test="${entity.firstSlotNum=='1' }">selected="selected"</c:if>>连续输出</option>
														                <option value="2" <c:if test="${entity.firstSlotNum=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
									            					</select>
																	</td>
																	
																	
																</tr>
																<tr>
																	<th><label class="">Output&nbsp; Msg&nbsp; Arrival&nbsp; Time</label>
																	</th>
																	<td>
																	<select name="msgArriveTime" id="msgArriveTime" class="input-select input-wd200"
																		datatype="*" sucmsg=" " nullmsg="请选择报文到达时间">
														                <option value="">请选择</option>
														                <option value="0" <c:if test="${entity.msgArriveTime=='0' }">selected="selected"</c:if>>无输出</option>
														                <option value="1" <c:if test="${entity.msgArriveTime=='1' }">selected="selected"</c:if>>连续输出</option>
														                <option value="2" <c:if test="${entity.msgArriveTime=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
									            					</select>
																	</td>
																	
																	
																</tr>
																<tr>
																	<th><label class="">Output Signal to Noise Ratio</label>
																	</th>
																	<td>
																	<select name="signalNoiseRatio" id="signalNoiseRatio" class="input-select input-wd200"
																		datatype="*" sucmsg=" " nullmsg="请选择信噪比">
														                <option value="">请选择</option>
														                <option value="0" <c:if test="${entity.signalNoiseRatio=='0' }">selected="selected"</c:if>>无输出</option>
														                <option value="1" <c:if test="${entity.signalNoiseRatio=='1' }">selected="selected"</c:if>>连续输出</option>
														                <option value="2" <c:if test="${entity.signalNoiseRatio=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
									            					</select>
																	</td>
																	
																	
																</tr>
																</tbody>
														</table>
													</div>
												
											</div>
										</div>
									
							<!--END TABS-->
			</div>
			
			<div class="span6">
			<div class="portlet box">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>FSR 
								</div>
							</div>
							<!--BEGIN TABS-->
											<div class="portlet-body form">
													<!-- VSI语句的输出 -->
													<div class="dataTables_wrapper form-inline">
														<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
															<colgroup>
																<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
																<col width="250"></col>
																<col width="270"></col>
															</colgroup>
															<tbody>
																<tr>
																	<th><label class="">Output FSR Sentence After Each Frame</label>
                                                                    </th>
                                                                    <td>
                                                                    <input type="radio" name="fsrSentenceOfAfterFrame" id="fsrSentenceOfAfterFrame1" value="1" checked="checked" />
                                                                    <label for="fsrSentenceOfAfterFrame1">开启</label>
                                                                    <input type="radio" name="fsrSentenceOfAfterFrame" id="fsrSentenceOfAfterFrame2" value="0" <c:if test="${entity.fsrSentenceOfAfterFrame=='0' }">checked="checked"</c:if> />
                                                                    <label for="fsrSentenceOfAfterFrame2">关闭</label>
                                                                    </td>
																</tr>
																
																<tr>
																	<th><label class="">Output Channel Load</label>
                                                                </th>
                                                                <td>
                                                                <select name="channelLoad" id="channelLoad" class="input-select input-wd200"
                                                                    datatype="*" sucmsg=" " nullmsg="请选择上一帧频道负载" >
                                                                    <option value="">请选择</option>
                                                                    <option value="0" <c:if test="${entity.channelLoad=='0' }">selected="selected"</c:if>>无输出</option>
                                                                    <option value="1" <c:if test="${entity.channelLoad=='1' }">selected="selected"</c:if>>每一帧输出一次</option>
                                                                    <option value="2" <c:if test="${entity.channelLoad=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
                                                                </select>
                                                                </td>
																</tr>
																
																<tr>
																	 <th><label class="">Output Nr of Msgs with Bad CRC</label>
                                                                </th>
                                                                <td>
                                                                <select name="badCRCMsgNum" id="badCRCMsgNum" class="input-select input-wd200"
                                                                    datatype="*" sucmsg=" " nullmsg="请选择不合格CRC报文数量" >
                                                                    <option value="">请选择</option>
                                                                    <option value="0" <c:if test="${entity.badCRCMsgNum=='0' }">selected="selected"</c:if>>无输出</option>
                                                                    <option value="1" <c:if test="${entity.badCRCMsgNum=='1' }">selected="selected"</c:if>>每一帧输出一次</option>
                                                                    <option value="2" <c:if test="${entity.badCRCMsgNum=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
                                                                </select>
                                                                </td>
																</tr>
																
																<tr>
																	<th><label class="">Output Forecast Channel Load</label>
                                                                </th>
                                                                <td>
                                                                <select name="forecastChannelLoad" id="forecastChannelLoad" class="input-select input-wd200"
                                                                    datatype="*" sucmsg=" " nullmsg="请选择预报频道负载!">
                                                                    <option value="">请选择</option>
                                                                    <option value="0" <c:if test="${entity.forecastChannelLoad=='0' }">selected="selected"</c:if>>无输出</option>
                                                                    <option value="1" <c:if test="${entity.forecastChannelLoad=='1' }">selected="selected"</c:if>>每一帧输出一次</option>
                                                                    <option value="2" <c:if test="${entity.forecastChannelLoad=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
                                                                </select>
                                                                </td>
																</tr>
																
																<tr>
																	 <th><label class="">Output Avarage Noise Level</label>
                                                                </th>
                                                                <td>
                                                                <select name="avarageNoiseLevel" id="avarageNoiseLevel" class="input-select input-wd200"
                                                                    datatype="*" sucmsg=" " nullmsg="请选择平均噪音水平!">
                                                                    <option value="">请选择</option>
                                                                    <option value="0" <c:if test="${entity.avarageNoiseLevel=='0' }">selected="selected"</c:if>>无输出</option>
                                                                    <option value="1" <c:if test="${entity.avarageNoiseLevel=='1' }">selected="selected"</c:if>>每一帧输出一次</option>
                                                                    <option value="2" <c:if test="${entity.avarageNoiseLevel=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
                                                                </select>
                                                                </td>
																</tr>
																
																<tr>
																	<th><label class="">Output Recieved Signal Strength</label>
                                                                    </th>
                                                                    <td>
                                                                    <select name="receivedSignalStrength" id="receivedSignalStrength" class="input-select input-wd200"
                                                                        datatype="*" sucmsg=" " nullmsg="请选择VDL报文接受信号强度!">
                                                                        <option value="">请选择</option>
                                                                        <option value="0" <c:if test="${entity.receivedSignalStrength=='0' }">selected="selected"</c:if>>无输出</option>
                                                                        <option value="1" <c:if test="${entity.receivedSignalStrength=='1' }">selected="selected"</c:if>>连续输出</option>
                                                                        <option value="2" <c:if test="${entity.receivedSignalStrength=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
                                                                    </select>
                                                                    </td>
																</tr>
																
																</tbody>
														</table>
													</div>
											</div>
										</div>
									
							<!--END TABS-->
				<div id="note" class="alert alert-success hide">
					<button class="close" data-dismiss="alert"></button>
					<span id="note_msg">操作成功！</span>
				</div>
			</div>
			</div>
			<table id=""  cellpadding="0" cellspacing="0" border="0" width="100%"  height="100%"  summary="这是一个1行1列的表格样式模板">
																<tr>
																<td colspan="4" style="text-align:center;">
																<button type="submit" class="btn green" onclick="setStatus('0','1')">保存</button>
																<button type="submit" class="btn btn-submit" onclick="setStatus('1','1')"style="background-color: #FF7F50">设置</button></td>
																</tr>
																</table>
			</form>
			
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
<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
<!-- js验证 -->
	<script>
		jQuery(document).ready(function() {
			var form = $('#form-validate1');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	channel:{
                		required:true
                	},
                	signalStrength:{
                		required:true
                	},
                	firstSlotNum:{
                		required:true
                	},
                	msgArriveTime:{
                		required:true
                	},
                	signalNoiseRatio:{
                		required:true
                	},

                	channelLoad:{
                		required:true
                	},
                	badCRCMsgNum:{
                		required:true
                	},
                	forecastChannelLoad:{
                		required:true
                	},
                	avarageNoiseLevel:{
                		required:true
                	},
                	receivedSignalStrength:{
                	required:true
                	}
                },

                messages: { // custom messages for radio buttons and checkboxes
                	channel:{
                		required:"请选择频道"
                	},
                	signalStrength:{
                		required:"请选择VDL报文接受信号强度"
                	},
                	firstSlotNum:{
                		required:"请选择每条报文第一时隙数"
                	},
                	msgArriveTime:{
                		required:"请选择报文到达时间"
                	},
                	signalNoiseRatio:{
                		required:"请选择信噪比"
                	},
                	channelLoad:{
                		required:"请选择上一帧频道负载"
                	},
                	badCRCMsgNum:{
                		required:"请选择不合格CRC报文数量"
                	},
                	forecastChannelLoad:{
                		required:"请选择预报频道负载!"
                	},
                	avarageNoiseLevel:{
                		required:"请选择平均噪音水平"
                	},
                	receivedSignalStrength:{
                	required:"请选择VDL报文接受信号强度!"
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
