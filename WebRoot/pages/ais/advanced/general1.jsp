<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>基站设置类接口</title>
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
				<h2 class="ui-title-cnt fn-left">基站设置类接口</h2>
			</div>
			<!--标题栏结束-->
			<span class="x-line fn-clear">&nbsp;</span>

			<form name="form" id="form-validate" action="${root}/siteinfo/setting/generalSetting" method="post">
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity.id}" id="id" />
				<input type="hidden" name="status" value="" id="status" />
				<div class="ui-list fn-clear">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="145"></col>
							<col width="390"></col>
							<col width="150"></col>
                 			<col width="400"></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">基站设置类接口参数</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><label class="" title="mmsi">MMSI</label></th>
								<td>
									<input type="text" name="mmsi" id="mmsi" value="${entity.mmsi}" 
										datatype="n9-9" sucmsg=" " nullmsg="请输入mmsi!" errormsg="mmsi为9位有效数字!" class="input-normal input-wd200  fn-left" />
								</td>
								<th><label class="" title="Unique id">Unique id</label></th>
								<td>
									<input type="text" name="uid" id="uid" value="${entity.uid}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th>
								<label class="">lat</label>
								</th>
								<!--数据项名称用th-->
								<td>
								<input type="text" name="lat" id="lat" maxlength="10" value="${entity.lat}" class="input-normal input-wd200  fn-left" 
									datatype="^/-?(90|[0-8]?\d(\.\d{1,6})?)$/" sucmsg=" " nullmsg="请输入纬度值!" errormsg="请输入正确的纬度值!" />
								</td>
							
								<th>
								<label class="">S/N</label>
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
								<label class="">Lon</label>
								</th>
								<td>
								<input type="text" name="lon" id="lon" value="${entity.lon}" maxlength="11" class="input-normal input-wd200  fn-left" 
									datatype="/^-?(180|1?[0-7]?\d(\.\d{1,6})?)$/" sucmsg=" " nullmsg="请输入经度值!" errormsg="请输入正确的经度值!" />
								</td>
								<th>
								<label class="">E/W</label>
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
								<label class="">Accuracy</label>
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
								
								<th><label class="" >Position Source</label></th>
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
								<label class="">RX Channel A</label>
								</th>
								<!--数据项名称用th-->
								<td>
								<input type="text" name="rxChannelA" id="rxChannelA" value="${entity.rxChannelA}" class="input-normal input-wd200  fn-left"
									datatype="/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/" sucmsg=" " nullmsg="请输入RX频道A值!" errormsg="请输入正确的RX频道A值!范围值:1001-2287" />
								</td>

								<th>
								<label class="">RX Channel B</label>
								</th>
								<!--数据项名称用th-->
								<td>
								<input type="text" name="rxChannelB" id="rxChannelB" value="${entity.rxChannelB}" class="input-normal input-wd200  fn-left" 
									datatype="/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/" sucmsg=" " nullmsg="请输入RX频道B值!" errormsg="请输入正确的RX频道B值!范围值:1001-2287" />
								</td>
							</tr>
							<tr>
								<th>
								<label class="">TX Channel A</label>
								</th>
								<!--数据项名称用th-->
								<td>
								<input type="text" name="txChannelA" id="txChannelA" value="${entity.txChannelA}" class="input-normal input-wd200  fn-left"
									datatype="/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/" sucmsg=" " nullmsg="请输入TX频道A!" errormsg="请输入正确的TX频道A!范围值:1001-2287" />
								</td>

								<th>
								<label class="">TX Channel B</label>
								</th>
								<!--数据项名称用th-->
								<td>
								<input type="text" name="txChannelB" id="txChannelB" value="${entity.txChannelB}" class="input-normal input-wd200  fn-left"
									datatype="/^(100[1-9]|1[1-9][1-9][0-9]|2([0-1][0-9]\d|2[0-7]\d|28[0-7]))$/" sucmsg=" " nullmsg="请输入TX频道B!" errormsg="请输入正确的TX频道B!范围值:1001-2287"  />
								</td>
							</tr>
							<tr>
								<th>
								<label class="">High Power A</label>
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
								<label class="">High Power B</label>
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
								<label class="">Msg Retries</label>
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
								<label class="">Repeat Indicatior</label>
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
							<td colspan="4">
							<button type="submit" class="btn btn-submit" onclick="setStatus('0')">保存</button>
							<button type="submit" class="btn btn-submit" onclick="setStatus('1')" style="background-color: #FF7F50">设置</button></td>
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
							<a href="${root}/siteinfo/setting/form/${siteInfoId}/1" class="current"> 
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
							<a href="${root}/siteinfo/advanced/output/form/${siteInfoId}" class=""> 
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
	<!--   Javascripts 注意不要改变顺序                      -->
	<script type="text/javascript" src="${root}/themes/ais/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${root}/themes/ais/js/baseframe.js"></script>
	<script type="text/javascript" src="${root}/themes/ais/js/tplbase.js"></script>
	<script language="javascript" type="text/javascript" src="${root}/themes/calendar/WdatePicker.js"></script>
	
	<!-- js验证 -->
	<script type="text/javascript" src="${root}/themes/validform/js/Validform_v5.3.2_min.js"></script>
	<script type="text/javascript">
		$(function() {
			var regfrom = $("#form-validate").Validform({
				tiptype : 1,
				ignoreHidden : true,
				showAllError : false
			});
		});
		function resetForm() {
			$("#form-validate").Validform().resetForm();
		}
		function setStatus(status){
			$("#status").val(status);
		}
	</script>
</body>
</html>