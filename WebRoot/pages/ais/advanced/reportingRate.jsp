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
<title>分配基站报文报告率</title>
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
						
					<li class="mark active" title="Reporting Rates">
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
				<div class="portlet-body form">
					<div class="row-fluid profile">
						<div class="span12">
	
							<!--BEGIN TABS-->
	
							<div class="tabbable tabbable-custom tabbable-full-width">
	
								<ul class="nav nav-tabs">
	
									<li class="active"><a href="#tab_1_1" data-toggle="tab">Msg 4(Base Station Report)</a>
									</li>
	
									<li><a href="#tab_1_2" data-toggle="tab">Msg 17(DGNSS)</a>
									</li>
	
									<li><a href="#tab_1_3" data-toggle="tab">Msg 20(Data Link Mgmt)</a>
									</li>
	
								</ul>
								<div class="tab-content" style="padding: 0px">
									<div class="tab-pane row-fluid active" id="tab_1_1">
										<div class="portlet box">
											<div class="portlet-body form">
											<form name="form1" id="form-validate1" action="${root}/siteinfo/report/advanced/saveSetting" method="post">
												<div class="alert alert-error hide">

										         	<button class="close" data-dismiss="alert"></button>

										                              表单填写不正确，请仔细核查。

									            </div>

									            <div class="alert alert-success hide">

									             	<button class="close" data-dismiss="alert"></button>

									            	提交成功，等待跳转！

									             </div>
												<input type="hidden" name="msgId" value="4" id="msgId1" />
												<input type="hidden" name="reportRatesForMsgType" value="1" id="reportRatesForMsgType1" />
												<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId1" />
												<input type="hidden" name="agreementid" value="${entity1.agreementid}" id="agreementid" />
												<input type="hidden" name="id" value="${entity1.id}" id="id1" />
												<input type="hidden" name="status" value="" id="status1" />
												<!-- 报文4 -->
												<div class="dataTables_wrapper form-inline">
													<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
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
																	<input type="text" name="chAutcMinute" id="chAutcMinute1" value="${entity1.chAutcMinute }" class="input-normal input-wd200  fn-left" />
																</td>
																
																<th><label class="">UTC Minute(Ch B)</label></th>
																<td>
																	<input type="text" name="chButcMinute" id="chButcMinute1" value="${entity1.chButcMinute }" class="input-normal input-wd200  fn-left"/>
																</td>
															</tr>
															<tr>
																<th><label class="">Start Slot(Ch A)</label>
																</th>
																<td><input type="text" name="chASlot" id="chASlot1" value="${entity1.chASlot}" class="input-normal input-wd200  fn-left" />
																</td>
																<th><label class="">Start Slot(Ch B)</label></th>
																<td>
																	<input type="text" name="chBSlot" id="chBSlot1" value="${entity1.chBSlot}" class="input-normal input-wd200  fn-left" />
																</td>
															</tr>
															<tr>
																<th><label class="">Increment(Ch A)</label></th>
																<td>
																	<input type="text" name="chAIncrement" id="chAIncrement1" value="${entity1.chAIncrement}" class="input-normal input-wd200  fn-left" />
																</td>
																
																<th><label class="">Increment(Ch B)</label></th>
																<td>
																	<input type="text" name="chBIncrement" id="chBIncrement1" value="${entity1.chBIncrement}" class="input-normal input-wd200  fn-left" />
																</td>
																
															</tr>
														</tbody>
														<tfoot>
															<tr>
															<td colspan="4" style="text-align: center;">
															<button type="submit" class="btn green" onclick="setStatus('4', '0')">保存</button>
															<button type="submit" class="btn btn-submit" style="background-color: #FF7F50" onclick="setStatus('4', '1')">设置</button></td>
															</tr>
														</tfoot>
													</table>
												</div>
											</form>
											</div>
										</div>
									</div>
									<div class="tab-pane profile-classic row-fluid" id="tab_1_2">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form2" id="form-validate2" action="${root}/siteinfo/report/advanced/saveSetting" method="post">
													<div class="alert alert-error hide">

										         	<button class="close" data-dismiss="alert"></button>

										                              表单填写不正确，请仔细核查。

									            </div>

									            <div class="alert alert-success hide">

									             	<button class="close" data-dismiss="alert"></button>

									            	提交成功，等待跳转！

									             </div>
													<input type="hidden" name="msgId" value="17" id="msgId2" />
													<input type="hidden" name="reportRatesForMsgType" value="2" id="reportRatesForMsgType2" />
													<input type="hidden" name="agreementid" value="${agreementid}" id="agreementid2" />
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId2" />
													<input type="hidden" name="id" value="${entity2.id}" id="id2" />
													<input type="hidden" name="status" value="" id="status2" />
													<!-- 报文17 -->
													<div class="dataTables_wrapper form-inline">
														<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
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
																	<td><input type="text" name="chAutcMinute" id="chAutcMinute2" value="${entity2.chAutcMinute}" class="input-normal input-wd200  fn-left" />
																	</td>
																
																	<th><label class="">UTC Minute(Ch B)</label>
																	</th>
																	<td><input type="text" name="chButcMinute" id="chButcMinute2" value="${entity2.chButcMinute}" class="input-normal input-wd200  fn-left" />
																	</td>
																</tr>
																<tr>
																	<th><label class="">Start Slot(Ch A)</label>
																	</th>
																	<td><input type="text" name="chASlot" id="chASlot2" value="${entity2.chASlot}"  class="input-normal input-wd200  fn-left" />
																	</td>
																	
																	<th><label class="">Start Slot(Ch B)</label>
																	</th>
																	<td><input type="text" name="chBSlot" id="chBSlot2" value="${entity2.chBSlot}"  class="input-normal input-wd200  fn-left" />
																	</td>
																</tr>
																<tr>
																	<th><label class="">Increment(Ch A)</label>
																	</th>
																	<td>
															            <input type="text" name="chAIncrement" id="chAIncrement2" value="${entity2.chAIncrement}"  class="input-normal input-wd200  fn-left" />   
																	</td>
																
																	<th><label class="">Increment(Ch B)</label>
																	</th>
																	<td>
																		<input type="text" name="chBIncrement" id="chBIncrement2" value="${entity2.chBIncrement}"  class="input-normal input-wd200  fn-left" />
																	</td>
																</tr>
																<tr>
																	<th><label class="">Num. of slots(Ch A)</label>
																	</th>
																	<td>
																		<input type="text" name="chASlotsNum" id="chASlotsNum2" value="${entity2.chASlotsNum }"  class="input-normal input-wd200  fn-left" />
																	</td>
																
																	<th><label class="">Num. of slots(Ch B)</label>
																	</th>
																	<td>
																		<input type="text" name="chBSlotsNum" id="chBSlotsNum2" value="${entity2.chBSlotsNum }"  class="input-normal input-wd200  fn-left" />
																	</td>
																</tr>
															</tbody>
															<tfoot>
																<tr>
																<td colspan="4" style="text-align:center;">
																<button type="submit" class="btn green" onclick="setStatus('17', '0')">保存</button>
																<button type="submit" class="btn btn-submit" style="background-color: #FF7F50" onclick="setStatus('17', '1')">设置</button></td>
																</tr>
															</tfoot>
														</table>
													</div>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-pane row-fluid profile-account" id="tab_1_3">
										<div class="portlet box">
											<div class="portlet-body form">
												<form name="form3" id="form-validate3" action="${root}/siteinfo/report/advanced/saveSetting" method="post">
													<div class="alert alert-error hide">

										         	<button class="close" data-dismiss="alert"></button>

										                              表单填写不正确，请仔细核查。

									            </div>

									            <div class="alert alert-success hide">

									             	<button class="close" data-dismiss="alert"></button>

									            	提交成功，等待跳转！

									             </div>
													<input type="hidden" name="msgId" value="20" id="msgId3" />
													<input type="hidden" name="reportRatesForMsgType" value="3" id="reportRatesForMsgType3" />
													<input type="hidden" name="agreementid" value="${agreementid}" id="agreementid3" />
													<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId3" />
													<input type="hidden" name="id" value="${entity3.id}" id="id3" />
													<input type="hidden" name="status" value="" id="status20" />
													<!-- 报文20 -->
													<div class="dataTables_wrapper form-inline">
														<table id="" class="table table-striped table-hover" summary="这是一个1行1列的表格样式模板">
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
																	<td><input type="text" name="chAutcMinute" id="chAutcMinute3" value="${entity3.chAutcMinute }" class="input-normal input-wd200  fn-left" />
																	</td>
																
																	<th><label class="">UTC Minute(Ch B)</label>
																	</th>
																	<td><input type="text" name="chButcMinute" id="chButcMinute3" value="${entity3.chButcMinute }" class="input-normal input-wd200  fn-left" />
																	</td>
																</tr>
																<tr>
																	<th><label class="">Start Slot(Ch A)</label>
																	</th>
																	<td><input type="text" name="chASlot" id="chASlot3" value="${entity3.chASlot }" class="input-normal input-wd200  fn-left" />
																	</td>
																	
																	<th><label class="">Start Slot(Ch B)</label>
																	</th>
																	<td><input type="text" name="chBSlot" id="chBSlot3" value="${entity3.chBSlot }" class="input-normal input-wd200  fn-left" />
																	</td>
																</tr>
																<tr>
																	<th><label class="">Increment(Ch A)</label>
																	</th>
																	<td>
																		<input type="text" name="chAIncrement" id="chAIncrement3" value="${entity3.chAIncrement }" class="input-normal input-wd200  fn-left" />
																	</td>
																	
																	<th><label class="">Increment(Ch B)</label>
																	</th>
																	<td>
																		<input type="text" name="chBIncrement" id="chBIncrement3" value="${entity3.chBIncrement }" class="input-normal input-wd200  fn-left" />
																	</td>
																</tr>
															</tbody>
															<tfoot>
																<tr>
																<td colspan="4" style="text-align: center;">
																<button type="submit" class="btn green" onclick="setStatus('20', '0')">保存</button>
																<button type="submit" class="btn btn-submit" style="background-color: #FF7F50" onclick="setStatus('20', '1')">设置</button></td>
																</tr>
															</tfoot>
														</table>
													</div>
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
</div>
<!-- END PAGE -->
<!-- BEGIN FOOTER -->
<%@include file="../../admin/include/foot.jsp"%>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../../admin/include/js.jsp"%>
<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
<!-- END JAVASCRIPTS -->
	<script type="text/javascript">
	function setStatus(id, status){
		$("#status" + id).val(status);
	}
	</script>
	<!-- js验证 -->
	<script>
	     //4
		jQuery(document).ready(function() {
			var form = $('#form-validate1');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
            var ex =/^-?\d+$/;
            
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
          
          
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: true, // do not focus the last invalid input
                ignore: "",
                rules: {
                	chAutcMinute:{
                		required:true,
                		range:[0,59]
                	},
                	chButcMinute:{
                		required:true,
                		range:[0,59]
                	},
                	chASlot:{
                	    required:true,
                	    Integer:true,
                	    range:[-1,749]
                	},
                	chBSlot:{
                	    required:true,
                	    Integer:true,
                	    range:[-1,2249]
                	},
                	chAIncrement:{
                		required:true,
                		Integer:true,
                	    range:[0,13500]
                	},
                	chBIncrement:{
                		required:true,
                		Integer:true,
                	    range:[0,13500]
                	}
                	
                },

                messages: { // custom messages for radio buttons and checkboxes
                	chAutcMinute:{
                		required:"请输入A启动时隙UTC",
                		range:"A启动时隙UTC的取值是0~59的整数!"
                	},
                	chButcMinute:{
                		required:"请输入B启动时隙UTC",
                		range:"B启动时隙UTC的取值是0~59的整数!"
                	},
                	chASlot:{
                	    required:"请输入频道A启动时隙",
                	    Integer:"A启动时隙范围是0~749的整数,-1:关闭传输",
                	    range:"A启动时隙范围是0~749的整数,-1:关闭传输"
                	},
                	chBSlot:{
                	    required:"请输入频道B启动时隙",
                	    range:"B启动时隙范围是0~2249的整数,-1:关闭传输",
                	    Integer:"B启动时隙范围是0~2249的整数,-1:关闭传输"
                	},
                	chAIncrement:{
                		required:"请输入频道A时隙间隔",
                	    range:"频道A时隙间隔范围是0~13500的整数",
                	    Integer:"频道A时隙间隔范围是0~13500的整数"
                	},
                	chBIncrement:{
                		required:"请输入频道B时隙间隔",
                	    range:"频道B时隙间隔范围是0~13500的整数",
                	    Integer:"频道B时隙间隔范围是0~13500的整数"
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
		//17
		jQuery(document).ready(function() {
			var form = $('#form-validate2');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
 			var ex =/^-?\d+$/;
            
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
          
            jQuery.validator.addMethod("utcMinute", function(value, element) {
            var utcMinute=/(^[0-9]{1}$)|(^[1-5][0-9]$)/;
            return this.optional(element) || utcMinute.test(value) ;
          }, "时隙范围0–59的整数");

          /*jQuery.validator.addMethod("StartSlot", function(value, element) {
            var StartSlot=/(^(-)1|0$)|(^[1-9]\d{0,3}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/;
            return this.optional(element) || StartSlot.test(value) ;
          }, "启动时隙范围0-2249;-1=关闭传输");*/
          
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: true, // do not focus the last invalid input
                ignore: "",
                rules: {
                	chAutcMinute:{
                	required:true,
                	utcMinute:true,
                	},
                	chButcMinute:{
                	required:true,
                	utcMinute:true,
                	},
                	chASlot:{
                		required:true,
                		range:[-1,2249],
                		Integer:true
                	},
                	chBSlot:{
                		required:true,
                		range:[0,2249],
                		Integer:true
                	},
                	chAIncrement:{
                		required:true,
                		range:[0,13500],
                		Integer:true
                	},
                	chBIncrement:{
                		required:true,
                		range:[0,13500],
                		Integer:true
                	},
                	chASlotsNum:{
                		required:true,
                		range:[1,4],
                		Integer:true
                	},
                	chBSlotsNum:{
                		required:true,
                		range:[1,4],
                		Integer:true
                	}
                },

                messages: { // custom messages for radio buttons and checkboxes
                	chAutcMinute:{
                	required:"请输入A启动时隙UTC!",
                	},
                	chButcMinute:{
                	required:"请输入B启动时隙UTC!",
                	},
                	chASlot:{
                		required:"请输入频道A启动时隙!",
                		range:"时隙范围是0-2249的整数，-1:关闭传输",
                		Integer:"时隙范围是0-2249的整数，-1:关闭传输",
                	},
                	chBSlot:{
                		required:"请输入频道B启动时隙!",
                		range:"时隙范围是0-2249的整数",
                		Integer:"时隙范围是0-2249的整数，-1:关闭传输",
                	},

                	chAIncrement:{
                		required:"请输入频道A时隙间隔!",
                		range:"频道A时隙间隔范围是0~13500的整数",
                		Integer:"频道A时隙间隔范围是0~13500的整数"
                	},
                	chBIncrement:{
                		required:"请输入频道B时隙间隔!",
                		range:"频道B时隙间隔取值范围是0~13500的整数",
                		Integer:"频道B时隙间隔取值范围是0~13500的整数"
                	},
                	chASlotsNum:{
                		required:"请输入频道A时隙数目!",
                		range:"频道A时隙数目取值范围是1~4的整数",
                		Integer:"频道A时隙数目取值范围是1~4的整数"
                	},
                	chBSlotsNum:{
                		required:"请输入频道B时隙数目!",
                		range:"频道B时隙数目取值范围是1~4的整数",
                		digtis:"频道B时隙数目取值范围是1~4的整数"
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
    //20
    	jQuery(document).ready(function() {
			var form = $('#form-validate3');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
			var ex =/^-?\d+$/;
            
            jQuery.validator.addMethod("Integer", function(value, element) {
            var Integer=/^-?\d+$/;
            return this.optional(element) || Integer.test(value) ;
          }, "输入应为整数");
          
            jQuery.validator.addMethod("utcMinute", function(value, element) {
            var utcMinute=/(^[0-9]{1}$)|(^[1-5][0-9]$)/;
            return this.optional(element) || utcMinute.test(value) ;
          }, "时隙范围是0–59的整数");

          /*jQuery.validator.addMethod("StartSlot", function(value, element) {
            var StartSlot=/(^(-)1|0$)|(^[1-9]\d{0,3}$)|(^2[0-1]\d{2}$)|(^22[0-3]\d{1}$)|(^224[0-9]$)/;
            return this.optional(element) || StartSlot.test(value) ;
          }, "启动时隙范围0-2249;-1=关闭传输");*/
          
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: true, // do not focus the last invalid input
                ignore: "",
                rules: {
                	chAutcMinute:{
                	required:true,
                	utcMinute:true
                	},
                	chButcMinute:{
                	required:true,
                	utcMinute:true
                	},
                	chASlot:{
                		required:true,
                		range:[-1,2249],
                		Integer:true
                	},
                	chBSlot:{
                		required:true,
                		range:[0,2249],
                		Integer:true
                	},
                	chAIncrement:{
                		required:true,
                		range:[0,13500],
                		Integer:true
                	},
                	chBIncrement:{
                		required:true,
                		range:[0,13500],
                		Integer:true
                	}
                },

                messages: { // custom messages for radio buttons and checkboxes
                	chAutcMinute:{
                	required:"请输入A启动时隙UTC!",
                	},
                	chButcMinute:{
                	required:"请输入B启动时隙UTC!",
                	},
                	chASlot:{
                		required:"请输入频道A启动时隙!",
                		range:"时隙范围是0-2249的整数，-1:关闭传输",
                		Integer:"时隙范围是0-2249的整数，-1:关闭传输"
                	},
                	chBSlot:{
                		required:"请输入频道B启动时隙!",
                		range:"时隙范围是0-2249的整数",
                		Integer:"时隙范围是0-2249的整数，-1:关闭传输"
                	},

                	chAIncrement:{
                		required:"请输入频道A时隙间隔!",
                		range:"频道A时隙间隔取值为0~13500的整数",
                		Integer:"频道A时隙间隔取值为0~13500的整数"
                	},
                	chBIncrement:{
                		required:"请输入频道B时隙间隔!",
                		range:"频道B时隙间隔取值为0~13500的整数",
                		Integer:"频道B时隙间隔取值为0~13500的整数"
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
	<style type="text/css">
	    span.help-inline{
	    color:red;
	}
	</style>
</html>
