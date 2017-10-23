<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim" %>
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
						<div class="portlet box">
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
													<th><label class="control-label">海区<span class="required">*</span></label></th>
													<td>
														<select id="areaId" name="areaId" datatype="*" sucmsg=" " nullmsg="请选择海区!"  class="input-select input-wd200" 
															onchange="getSub('jurisdictionsId','areaId');getSub('addressId','jurisdictionsId');setArea();">
															<option>请选择</option>
														</select>
														<input type="hidden" id="area" name="area" value="${siteInfo.area }"/>
													</td>
													
													<th><label class="control-label">辖区<span class="required">*</span></label></th>
													<td>
														<select id="jurisdictionsId" name="jurisdictionsId" datatype="*" sucmsg=" " nullmsg="请选择辖区!"  class="input-select input-wd200" 
															onchange="getSub('addressId','jurisdictionsId');setJurisdictions();">
															<option>请选择</option>
														</select>
														<input type="hidden" id="jurisdictions" name="jurisdictions" value="${siteInfo.jurisdictions }"/>
													</td>
												</tr>
												<tr>
													<th><label class="control-label">地址<span class="required">*</span></label></th>
													<td>
														<select id="addressId" name="addressId" datatype="*" sucmsg=" " nullmsg="请选择地址!"  class="input-select input-wd200" 
															onclick="setAddress();setAgreementId();" onchange="HanziToPinyin();setTimeout('isExist2()',1000);">
															<option>请选择</option>
														</select>
														<input type="hidden" id="address" name="address" value="${siteInfo.address }"/>
														<input type="hidden" id="agreementId" name="agreementId" value="${siteInfo.agreementId }"/>
													</td>
													
													<th><label class="control-label">制造商<span class="required">*</span></label></th>
													<td>
														<select id="manufacturerId" name="manufacturerId" class="input-select input-wd200"
															datatype="*" sucmsg=" " nullmsg="请选择厂商!" onchange="setManufacturer();">
															<option>请选择</option>
														</select>
														<input type="hidden" id="manufacturer" name="manufacturer" value="${siteInfo.manufacturer }"/>
													</td>
												</tr>
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
														onchange="changeSingleOrDouble(),HanziToPinyin();"  class="input-select input-wd200" >
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
											</tbody>
										</table>
									</div>
									<div class="form-actions" style="padding-left:0px;text-align:center" >

										<button type="submit" onclick="isExist();" class="btn green">提交</button>

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

	<script type="text/javascript" src="<%=basePath%>themes/media/js/Pinyin.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->
	
	
	<script>
		//初始化页面样式
		changeSingleOrDouble();
		function changeSingleOrDouble() {
			if($("#siteType").val()=="0") {
				$("#double").hide();
				$("#ipAddressB").attr('disabled',"true");
				$("#portB").attr('disabled',"true");
				$("#ipAddressB").val("");
				$("#portB").val("");
			} else {
				$("#double").show();
				$("#ipAddressB").removeAttr('disabled',"false");
				$("#portB").removeAttr('disabled',"false");
				$("#ipAddressB").val("");
				$("#portB").val("");
			}
		}
	</script>
	
	<script type="text/javascript">
		//汉字转换拼音
	    function HanziToPinyin(){
	        var hanzi = $("#addressId option:selected").text();
	        var pinyin = codefans_net_CC2PY(hanzi);
	        var pinyin2 = pinyin+"A/B";
	        var ds = $("#siteType option:selected").text();
	        if (pinyin!="QingXuanZe") {
	        	if (ds=="单") {
	        		$("#sitename").val(pinyin);
				}else if (ds=="双") {
					$("#sitename").val(pinyin2);
				}
	    }
		}
		//判断用户是否存在
		function isExist() {
			var agreementId = $("#agreementId").val();
			$.ajax({
				type : "POST",
				data : "agreementId="+agreementId,
				url : '${root}/siteinfo/isExist',
				success : function(data) {
					if (data == "1") {
						alert("此基站已经存在，请重新创建!");
						return false;
					} 
				}
			});
		}	
		
		//判断协议ID是否存在
		function isExist2(){
			var agreementId = $("#agreementId").val();
			var jid = $("#jurisdictionsid").val();
			$.ajax({
				type : "POST",
				data : "agreementId="+agreementId,
				url : '${root}/siteinfo/isExist2',
				success : function(data) {
					if (data == "1") {
						alert("此基站已经存在，请重新创建!");
						$("#addressId").val("");
						$("#sitename").val("");
					} else {
						//alert(data);
						if(data!=""){
							//
							getaid();
						}
					}
				}
			});
		}
		
		//获取最新的agreementid
		function getaid(){
			var name = $("#address").val();
			$.ajax({
				type : "POST",
				data : "name="+name,
				url : '${root}/siteinfo/getaid',
				success : function(data){
					$("#agreementId").val(data);
					}
		});
		}
	
		//设置厂商名称在隐藏域的值
		function setManufacturer() {
			$("#manufacturer").val($("#manufacturerId option:selected").text());
		}
		//设置海区名称在隐藏域的值
		function setArea() {
			$("#area").val($("#areaId option:selected").text());
		}
		//设置辖区名称在隐藏域的值
		function setJurisdictions() {
			$("#jurisdictions").val($("#jurisdictionsId option:selected").text());
		}
		//设置地点名称在隐藏域的值
		function setAddress() {
			$("#address").val($("#addressId option:selected").text());
		}
		//设置地点名称在隐藏域的值
		function setAgreementId() {
			$("#agreementId").val($("#addressId").val());
		}
	
		//初始化数据字典项 
		jQuery(document).ready(function() {
			getManufacturer('manufacturerId');
			getFirstlist('areaId');
		});
		var json = eval('${dim:json("2c9ba3874bf6a55f014bf6ab447b0005")}');
		var manufacturerJson = eval('${dim:json("2c9ba3874bf6a55f014bf6ad166a0006")}');
		
		function getFirstlist(domId){
			var options="<option value=\"\">请选择</option>";
			if(json!=null){
				for(var i = 0;i<json.length;i++){
				 	if(json[i].pid==0){
				 		options+="<option title='"+json[i].id+"' value='"+json[i].itemCode+"'>"+json[i].itemName+"</option>";
				 	}
				}
			}
			$("#"+domId).html(options);
			$("#jurisdictionsId").html("<option value=\"\">请选择</option>");
			$("#addressId").html("<option value=\"\">请选择</option>");
		}
		
		function getSub(domId,itemId){
			var id = $('#'+itemId).find("option:selected").attr("title");
			var options="<option value=\"\">请选择</option>";
			for(var i = 0;i<json.length;i++){
			 	if(json[i].pid==id){
			 		options+="<option title='"+json[i].id+"' value='"+json[i].itemCode+"'>"+json[i].itemName+"</option>";
			 	}
			}
			$("#"+domId).html(options);
		}
		
		function getManufacturer(domId) {
			var options="<option value=\"\">请选择</option>";
			if(manufacturerJson!=null){
				for(var i = 0;i<manufacturerJson.length;i++){
				 	if(manufacturerJson[i].pid==0){
				 		options+="<option title='"+manufacturerJson[i].id+"' value='"+manufacturerJson[i].itemCode+"'>"+manufacturerJson[i].itemName+"</option>";
				 	}
				}
			}
			$("#"+domId).html(options);
		}
	</script>
	
	<!-- js验证 -->
	<script>
		jQuery(document).ready(function() {
			var form = $('#formValidate');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
            
            jQuery.validator.addMethod("ipAddress", function(value, element) {
                var ipAddress =/^([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/;
                return this.optional(element) || (ipAddress.test(value) && (RegExp.$1 < 256 && RegExp.$2 < 256 && RegExp.$3 < 256 && RegExp.$4 < 256));
              }, "Ip地址格式错误");
            jQuery.validator.addMethod("sitename", function(value, element) {
                var sitename=/^[0-9A-Za-z//]{0,15}$/;
                return this.optional(element) || sitename.test(value) ;
              }, "基站名称是0~15位的数字和字母的组合");
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	sitename: {
                        required: true,
                        //rangelength:[0,15],
                        sitename:true
                    },
                    power:{
                       required:true
                    },
                    ipAddressA:{
                    required:true,
                    ipAddress:true
                    },
                    portA:{
                    required:true,
                    range:[0,65535],
                    digits:true
                    },
                    ipAddressB:{
                    required:true,
                    ipAddress:true
                    },
                    portB:{
                    required:true,
                    range:[0,65535],
                    digits:true,
                    },
                    siteType:{
                    required:true
                    },
                    areaId:{
                    required:true
                    },
                    jurisdictionsId:{
                    required:true
                    },
                    addressId:{
                    required:true
                    },
                    manufacturerId:{
                    required:true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                	sitename: {
                        required: "请输入基站名称",
                        //rangelength:"基站名称是0~15位的数字和字母的组合"
                    },
                    power:{
                       required:"请选择功率"
                    },
                    ipAddressA:{
                    required:"请输入IP地址"
                    },
                    portA:{
                    required:"请输入端口号",
                    digits:"端口号是0~65535的整数",
                    range:"端口号是{0}~{1}的整数"
                    },
                    ipAddressB:{
                    required:"请输入IP地址",
                    },
                    portB:{
                    required:"请输入端口号",
                    digits:"端口号是0~65535的整数",
                    range:jQuery.format("端口号是{0}~{1}的整数")
                    },
                    siteType:{
                    required:"请选择基站类型"
                    },
                    areaId:{
                    required:"请选择海区"
                    },
                    jurisdictionsId:{
                    required:"请选择辖区"
                    },
                    addressId:{
                    required:"请选择地址"
                    },
                    manufacturerId:{
                    required:"请选择厂商"
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
	//校验错误信息样式
	<style type="text/css">
		span.help-inline{
			color:red;
		}
	</style>
	<!-- END JAVASCRIPTS -->
</html>