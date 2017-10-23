<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>选择AIS设备的处理和输出类接口</title>
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Window-target" content="_top" />
<!-------样式文件调用注意不要改变顺序------>
<link href="${root}/themes/validform/css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="${root}/themes/ais/css/syssubmenu.css" rel="stylesheet" type="text/css" />
<link href="${root}/themes/ais/css/base.css" rel="stylesheet" type="text/css" />
<link href="${root}/themes/ais/css/sysframe.css" rel="stylesheet" type="text/css" />
<link href="${root}/themes/ais/css/sysmain.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<!-- Main -->
	<div class="right-wrap">
		<div class="right-container">
			<!--标题栏开始-->
			<div class="ui-title fn-clear">
				<span class="ui-title-icon fn-left"><img src="${root}/themes/admin/images/icons/crumb.png" /> </span>
				<h2 class="ui-title-cnt fn-left">选择AIS设备的处理和输出类接口</h2>
			</div>
			<div class="formtabs ">
	          <ul>
	             <li class="formtabs-on" onclick="showCard(this,'formtabs2_cont','formtabs')">VSI</li>
	             <li  class="formtabs-off" onclick="showCard(this,'formtabs2_cont','formtabs')">FSR</li>
	            
	         </ul>
       		 </div>
			<!--标题栏结束-->
			<span class="x-line fn-clear">&nbsp;</span>

			<form name="form1" id="form-validate1" action="${root}/siteinfo/advanced/output/saveSetting" method="post">
				<input type="hidden" name="status" value="" id="status1" />
				<input type="hidden" name="outputType" value="1" id="outputType" />
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity1.id}" id="id" />
				<!-- VSI语句的输出 -->
				<div class="ui-list fn-clear" id="formtabs2_cont0">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="250"></col>
							<col width="270"></col>
							<col width="250"></col>
                 			<col width="300"></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">设置VSI语句的输出</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><label class="">channel</label>
								</th>
								<td colspan="3">
								<select name="channel" id="channel" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择频道" >
					                <option value="">请选择</option>
					                <option value="A" <c:if test="${entity1.channel=='A' }">selected="selected"</c:if>>频道A（Enable VSI/FSR Sentences About Channel A）</option>
					                <option value="B" <c:if test="${entity1.channel=='B' }">selected="selected"</c:if>>频道B（Enable VSI/FSR Sentences About Channel B）</option>
					                <option value="E" <c:if test="${entity1.channel=='E' }">selected="selected"</c:if>>每个频道（Enable VSI/FSR Sentences About Every Channel）</option>
					                <option value="N" <c:if test="${entity1.channel=='N' }">selected="selected"</c:if>>对任何频道都没有VSI或者FSR语句（No VSI or FSR Sentences About Any Channel</option>
            					</select>
								</td>
							</tr>
							<tr>
								<th><label class="">Output Singal Strength</label></th>
								<td>
								<select name="signalStrength" id="signalStrength" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择VDL报文接受信号强度">
					                <option value="">请选择</option>
					                <option value="0" <c:if test="${entity1.signalStrength=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity1.signalStrength=='1' }">selected="selected"</c:if>>连续输出</option>
					                <option value="2" <c:if test="${entity1.signalStrength=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
            					</select>
								</td>
							
								<th><label class="">Output First Slot Nr</label>
								</th>
								<td>
								<select name="firstSlotNum" id="firstSlotNum" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择每条报文第一时隙数">
					                <option value="">请选择</option>
					                <option value="0" <c:if test="${entity1.firstSlotNum=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity1.firstSlotNum=='1' }">selected="selected"</c:if>>连续输出</option>
					                <option value="2" <c:if test="${entity1.firstSlotNum=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
            					</select>
								</td>
							
							</tr>
							<tr>
								<th><label class="">Output Msg Arrival Time</label>
								</th>
								<td>
								<select name="msgArriveTime" id="msgArriveTime" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择报文到达时间">
					                <option value="">请选择</option>
					                <option value="0" <c:if test="${entity1.msgArriveTime=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity1.msgArriveTime=='1' }">selected="selected"</c:if>>连续输出</option>
					                <option value="2" <c:if test="${entity1.msgArriveTime=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
            					</select>
								</td>
								
								<th><label class="">Output Signal to Noise Radio</label>
								</th>
								<td>
								<select name="signalNoiseRatio" id="signalNoiseRatio" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择信噪比">
					                <option value="">请选择</option>
					                <option value="0" <c:if test="${entity1.signalNoiseRatio=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity1.signalNoiseRatio=='1' }">selected="selected"</c:if>>连续输出</option>
					                <option value="2" <c:if test="${entity1.signalNoiseRatio=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
            					</select>
								</td>
							</tr>
							<tr>
								<th><label class="">Output with Each VDM sentence</label>
								</th>
								<td>
								 
            					<input type="radio" name="vdmSentence" id="vdmSentence1" value="1" checked="checked" />
								<label for="vdmSentence1">开启</label>
								<input type="radio" name="vdmSentence" id="vdmSentence2" value="0" <c:if test="${entity1.vdmSentence=='0' }">checked="checked"</c:if> />
								<label for="vdmSentence2">关闭</label>
								</td>
								
								<th><label class="">Output with Each VDO sentence</label>
								</th>
								<td>
            					<input type="radio" name="vdoSentence" id="vdoSentence1" value="1" checked="checked" />
								<label for="vdoSentence1">开启</label>
								<input type="radio" name="vdoSentence" id="vdoSentence2" value="0" <c:if test="${entity1.vdoSentence=='0' }">checked="checked"</c:if> />
								<label for="vdoSentence2">关闭</label>
								</td>
							</tr>
							</tbody>
						<tfoot>
							<tr>
							<td colspan="4">
							<button type="submit" class="btn btn-submit" onclick="setStatus('0','1')">保存</button>
							<button type="submit" class="btn btn-submit" onclick="setStatus('1','1')"style="background-color: #FF7F50">设置</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</form>			
							
			<form name="form2" id="form-validate2" action="${root}/siteinfo/advanced/output/saveSetting" method="post">
				<input type="hidden" name="status" value="" id="status1" />
				<input type="hidden" name="outputType" value="2" id="outputType" />
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity2.id}" id="id" />
				<!-- FSR语句的输出 -->
				<div class="ui-list fn-clear" id="formtabs2_cont1" style="display: none;">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="250"></col>
							<col width="270"></col>
							<col width="280"></col>
                 			<col width="270"></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">设置FSR语句的输出</th>
							</tr>
						</thead>
						<tbody>			
							<tr>
								<th><label class="">channel</label>
								</th>
								<td colspan="3">
								<select name="channel" id="channel" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择频道" >
					                <option value="">请选择</option>
					                <option value="A" <c:if test="${entity2.channel=='A' }">selected="selected"</c:if>>频道A（Enable VSI/FSR Sentences About Channel A）</option>
					                <option value="B" <c:if test="${entity2.channel=='B' }">selected="selected"</c:if>>频道B（Enable VSI/FSR Sentences About Channel B）</option>
					                <option value="E" <c:if test="${entity2.channel=='E' }">selected="selected"</c:if>>每个频道（Enable VSI/FSR Sentences About Every Channel）</option>
					                <option value="N" <c:if test="${entity2.channel=='N' }">selected="selected"</c:if>>对任何频道都没有VSI或者FSR语句（No VSI or FSR Sentences About Any Channel</option>
            					</select>
								</td>
								
							</tr>
							<tr>
								<th><label class="">Output Channel Load</label>
								</th>
								<td>
								<select name="channelLoad" id="channelLoad" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择上一帧频道负载" >
					                <option value="">请选择</option>
					                <option value="0" <c:if test="${entity2.channelLoad=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity2.channelLoad=='1' }">selected="selected"</c:if>>每一帧输出一次</option>
					                <option value="2" <c:if test="${entity2.channelLoad=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
            					</select>
								</td>
								
								<th><label class="">Output Nr of Msgs with Bad CRC</label>
								</th>
								<td>
								<select name="badCRCMsgNum" id="badCRCMsgNum" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择不合格CRC报文数量" >
					                <option value="">请选择</option>
					                <option value="0" <c:if test="${entity2.badCRCMsgNum=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity2.badCRCMsgNum=='1' }">selected="selected"</c:if>>每一帧输出一次</option>
					                <option value="2" <c:if test="${entity2.badCRCMsgNum=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
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
					                <option value="0" <c:if test="${entity2.forecastChannelLoad=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity2.forecastChannelLoad=='1' }">selected="selected"</c:if>>每一帧输出一次</option>
					                <option value="2" <c:if test="${entity2.forecastChannelLoad=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
            					</select>
								</td>
								
								<th><label class="">Output Avarage Noise Level</label>
								</th>
								<td>
								<select name="avarageNoiseLevel" id="avarageNoiseLevel" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择平均噪音水平!">
					                <option value="">请选择</option>
					                <option value="0" <c:if test="${entity2.avarageNoiseLevel=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity2.avarageNoiseLevel=='1' }">selected="selected"</c:if>>每一帧输出一次</option>
					                <option value="2" <c:if test="${entity2.avarageNoiseLevel=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
            					</select>
								</td>
								
							</tr>
							<tr>
								<th><label class="">Output Recieved Signal Strength</label>
								</th>
								<td>
								<select name="signalStrength" id="signalStrength" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择VDL报文接受信号强度!">
					                <option value="">请选择</option>
					                <option value="0" <c:if test="${entity2.signalStrength=='0' }">selected="selected"</c:if>>无输出</option>
					                <option value="1" <c:if test="${entity2.signalStrength=='1' }">selected="selected"</c:if>>连续输出</option>
					                <option value="2" <c:if test="${entity2.signalStrength=='2' }">selected="selected"</c:if>>仅下一帧输出</option>
            					</select>
								</td>
								
								<th><label class="">Output FSR Sentence After Each Time</label>
								</th>
								<td>
								<input type="radio" name="fsrSentenceOfAfterFrame" id="fsrSentenceOfAfterFrame1" value="1" checked="checked" />
								<label for="fsrSentenceOfAfterFrame1">开启</label>
								<input type="radio" name="fsrSentenceOfAfterFrame" id="fsrSentenceOfAfterFrame2" value="0" <c:if test="${entity2.fsrSentenceOfAfterFrame=='0' }">checked="checked"</c:if> />
								<label for="fsrSentenceOfAfterFrame2">关闭</label>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
							<td colspan="4">
							<button type="submit" class="btn btn-submit" onclick="setStatus('0','2')">保存</button>
							<button type="submit" class="btn btn-submit" onclick="setStatus('1','1')" style="background-color: #FF7F50">设置</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</form>
		</div>
		<!-- #right-wrap-->
	</div>
	<!--left-wrap开始-->
	<div id="sidebar" class="fn-clear left-wrap" style="padding-top: 38px;">
		<!--注意使用了id-->
		<div id="sidebar-wrapper">
			<ul id="main-subnav">
				<li title="全部">
					<a href="javascript:searchType('')" class="nav-top-item current"> 
						<span>全部</span> 
					</a>
					<ul>
						<li title="General">
							<a href="${root}/siteinfo/setting/form/${siteInfoId}/1" class=""> 
								<span class="arrow"></span> 
								<span>General</span> 
							</a>
						</li>
						<li title="Reporting Rates">
							<a href="${root}/siteinfo/msg/form/${siteInfoId}/2" class=""> 
								<span class="arrow"></span> 
								<span>Reporting Rates</span> 
							</a>
						</li>
						<li title="Data Link Management">
							<a href="${root}/siteinfo/setting/advanced/dlmForm/${siteInfoId}" class=""> 
								<span class="arrow"></span> 
								<span>Data Link Management</span> 
							</a>
						</li>
						<li title="Channel Management">
							<a href="${root}/siteinfo/setting/advanced/acaForm/${siteInfoId}" class=""> 
								<span class="arrow"></span> 
								<span>Channel Management</span> 
							</a>
						</li>
						<li title="选择AIS设备的处理和输出">
							<a href="${root}/siteinfo/advanced/output/form/${siteInfoId}" class="current"> 
								<span class="arrow"></span> 
								<span>VSI FSR</span> 
							</a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<!--left-wrap结束-->
	<!-- Javascripts 注意不要改变顺序 -->
	<script type="text/javascript" src="${root}/themes/ais/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${root}/themes/ais/js/baseframe.js"></script>
	<script type="text/javascript" src="${root}/themes/ais/js/tplbase.js"></script>
	
	<!-- js验证 -->
	<script type="text/javascript" src="${root}/themes/validform/js/Validform_v5.3.2_min.js"></script>
	<script type="text/javascript">
		$(function() {
			var regfrom1 = $("#form-validate1").Validform({
				tiptype : 3,
				ignoreHidden : true,
				showAllError : true
			});
			var regfrom2 = $("#form-validate2").Validform({
				tiptype : 3,
				ignoreHidden : true,
				showAllError : true
			});
		});
		function resetForm() {
			$("#form-validate1").Validform().resetForm();
			$("#form-validate2").Validform().resetForm();
		}
		function setStatus(status, id){
			$("#status"+id).val(status);
		}
	</script>
</body>
</html>