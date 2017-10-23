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
<title>设置AIS信道分配管理</title>
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Window-target" content="_top" />
<!-------样式文件调用注意不要改变顺序------>
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
				<span class="ui-title-icon fn-left"><img
					src="${root}/themes/admin/images/icons/crumb.png" /> </span>
				<h2 class="ui-title-cnt fn-left">设置AIS信道分配管理</h2>
			</div>
			<!--标题栏结束-->
			<span class="x-line fn-clear">&nbsp;</span>

			<form name="form" action="${root}/siteinfo/advanced/aca/saveSetting" method="post">
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity.id}" id="id" />
				<div class="ui-list fn-clear">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="250"></col>
							<col ></col>
							<col width="260"></col>
                 			<col ></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">设置AIS信道分配管理</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><label class="">Select region to configure</label></th>
								<td>
									<select name="seqNumber" id="seqNumber" onchange="getAcaEntity();" class="input-select input-wd200">
						                <option value="1" <c:if test="${entity.seqNumber==1 }">selected="selected"</c:if>>1</option>
						                <option value="2" <c:if test="${entity.seqNumber==2 }">selected="selected"</c:if>>2</option>
						                <option value="3" <c:if test="${entity.seqNumber==3 }">selected="selected"</c:if>>3</option>
						                <option value="4" <c:if test="${entity.seqNumber==4 }">selected="selected"</c:if>>4</option>
						                <option value="5" <c:if test="${entity.seqNumber==5 }">selected="selected"</c:if>>5</option>
						                <option value="6" <c:if test="${entity.seqNumber==6 }">selected="selected"</c:if>>6</option>
						                <option value="7" <c:if test="${entity.seqNumber==7 }">selected="selected"</c:if>>7</option>
						                <option value="8" <c:if test="${entity.seqNumber==8 }">selected="selected"</c:if>>8</option>
	            					</select>
								</td>
								
								<th>
								<label class="">In Use</label>
								</th>
								<!--数据项名称用th-->
								<td>
								<select name="inUseFlag" id="inUseFlag" onchange="changeAttribute();" class="input-select input-wd200">
					                <option value="0" <c:if test="${entity.inUseFlag==0 }">selected="selected"</c:if>>不使用</option>
					                <option value="1" <c:if test="${entity.inUseFlag==1 }">selected="selected"</c:if>>使用</option>
            					</select>
								</td>
							</tr>
							<tr>
								<th><label class="">S/N</label></th>
								<td>
									<input type="radio" name="nelatType" id="nelatType1" value="S" checked="checked" />
									<label for="nelatType1">S</label>
									<input type="radio" name="nelatType" id="nelatType2" value="N" <c:if test="${entity.nelatType=='N' }">checked="checked"</c:if>/>
									<label for="nelatType2">N</label>
								</td>
								
								<th>
								<label class="">nelat</label>
								</th>
								<!--数据项名称用th-->
								<td>
								<input type="text" name="nelat" id="nelat" value="${entity.nelat }" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">E/W</label></th>
								<td>
									<input type="radio" name="nelonType" id="nelonType1" value="E" checked="checked" />
									<label for="nelonType1">E</label>
									<input type="radio" name="nelonType" id="nelonType2" value="W" <c:if test="${entity.nelonType=='W' }">checked="checked"</c:if>/>
									<label for="nelonType2">W</label>
								</td>
								
								<th><label class="">nelon</label></th>
								<!--数据项名称用th-->
								<td>
									<input type="text" name="nelon" id="nelon" value="${entity.nelon }" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">S/N</label></th>
								<td>
									<input type="radio" name="swlatType" id="swlatType1" value="S" checked="checked" />
									<label for="swlatType1">S</label>
									<input type="radio" name="swlatType" id="swlatType2" value="N" <c:if test="${entity.swlatType=='N' }">checked="checked"</c:if> />
									<label for="swlatType1">N</label>
								</td>
								
								<th><label class="">swlat</label></th>
								<!--数据项名称用th-->
								<td>
									<input type="text" name="swlat" id="swlat" value="${entity.swlat }" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">E/W</label></th>
								<td>
									<input type="radio" name="swlonType" id="swlonType1" value="E" checked="checked" />
									<label for="swlonType2">E</label>
									<input type="radio" name="swlonType" id="swlonType2" value="W" <c:if test="${entity.swlonType=='W' }">checked="checked"</c:if> />
									<label for="swlonType2">W</label>
								</td>
								
								<th><label class="">swlon</label></th>
								<!--数据项名称用th-->
								<td>
									<input type="text" name="swlon" id="swlon" value="${entity.swlon }" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th>
								<label class="">Transition Zone Size</label>
								</th>
								<!--数据项名称用th-->
								<td colspan="3">
									<select name="transitionZone" id="transitionZone" class="input-select input-wd200">
						                <option value="">请选择</option>
						                <option value="1" <c:if test="${entity.transitionZone==1 }">selected="selected"</c:if>>1海里</option>
						                <option value="2" <c:if test="${entity.transitionZone==2 }">selected="selected"</c:if>>2海里</option>
						                <option value="3" <c:if test="${entity.transitionZone==3 }">selected="selected"</c:if>>3海里</option>
						                <option value="4" <c:if test="${entity.transitionZone==4 }">selected="selected"</c:if>>4海里</option>
						                <option value="5" <c:if test="${entity.transitionZone==5 }">selected="selected"</c:if>>5海里</option>
						                <option value="6" <c:if test="${entity.transitionZone==6 }">selected="selected"</c:if>>6海里</option>
						                <option value="7" <c:if test="${entity.transitionZone==7 }">selected="selected"</c:if>>7海里</option>
						                <option value="8" <c:if test="${entity.transitionZone==8 }">selected="selected"</c:if>>8海里</option>
	            					</select>
								</td>
								
							</tr>
							<tr>
								<th><label class="">channelA</label></th>
								<!--数据项名称用th-->
								<td>
								<input type="text" name="channelA" id="channelA" value="${entity.channelA }" class="input-normal input-wd200  fn-left" />
								</td>
								<th>
								<label class="">Area VHF channel bandwidth A</label>
								</th>
								<td>
								<select name="bandWidthForChA" id="bandWidthForChA" class="input-select input-wd200">
					                <option>请选择</option>
					                <option value="1" <c:if test="${entity.bandWidthForChA==1 }">selected="selected"</c:if>>带宽12.5kHz</option>
					                <option value="0" <c:if test="${entity.bandWidthForChA==0 }">selected="selected"</c:if>>根据频道数字界定带宽</option>
            					</select>
								</td>
							</tr>
							<tr>
								<th>
								<label class="">Channel B</label>
								</th>
								<!--数据项名称用th-->
								<td>
								<input type="text" name="channelB" id="channelB" value="${entity.channelB }" class="input-normal input-wd200  fn-left" />
								</td>
							
								<th>
								<label class="">Area VHF channel bandwidth B</label>
								</th>
								<td>
								<select name="bandWidthChB" id="bandWidthChB" class="input-select input-wd200">
					                <option>请选择</option>
					                <option value="1" <c:if test="${entity.bandWidthChB==1 }">selected="selected"</c:if>>带宽12.5kHz</option>
					                <option value="0" <c:if test="${entity.bandWidthChB==0 }">selected="selected"</c:if>>根据频道数字界定带宽</option>
            					</select>
								</td>
							</tr>
							<tr>
								<th>
								<label class="">Tx/Rx Mode</label>
								</th>
								<td>
								<select name="trxMode" id="trxMode" class="input-select input-wd200">
					                <option>请选择</option>
					                <option value="0" <c:if test="${entity.trxMode==0 }">selected="selected"</c:if>>传输通道A和B，接收通道A和B</option>
					                <option value="1" <c:if test="${entity.trxMode==1 }">selected="selected"</c:if>>传输通道A，接收通道A和B</option>
					                <option value="2" <c:if test="${entity.trxMode==2 }">selected="selected"</c:if>>传输通道B，接收通道A和B</option>
					                <option value="3" <c:if test="${entity.trxMode==3 }">selected="selected"</c:if>>不传输，接收通道A和B</option>
					                <option value="4" <c:if test="${entity.trxMode==4 }">selected="selected"</c:if>>不传输，接收通道A</option>
					                <option value="5" <c:if test="${entity.trxMode==5 }">selected="selected"</c:if>>不传输，接收通道B</option>
            					</select>
								</td>
								<th>
								<label class="">Area power level</label>
								</th>
								<td>
								<select name="powerLevel" id="powerLevel" class="input-select input-wd200">
					                <option>请选择</option>
					                <option value="0" <c:if test="${entity.powerLevel==0 }">selected="selected"</c:if>>高功率</option>
					                <option value="1" <c:if test="${entity.powerLevel==1 }">selected="selected"</c:if>>低功率</option>
            					</select>
								</td>
							</tr>
							<tr>
								<th><label class="">Information Source</label></th>
								<!--数据项名称用th-->
								<td>
								<select name="informationSource" id="informationSource" class="input-select input-wd200">
					                <option>请选择</option>
					                <option value="A" <c:if test="${entity.informationSource=='A' }">selected="selected"</c:if>>A</option>
					                <option value="B" <c:if test="${entity.informationSource=='B' }">selected="selected"</c:if>>B</option>
					                <option value="C" <c:if test="${entity.informationSource=='C' }">selected="selected"</c:if>>C</option>
					                <option value="D" <c:if test="${entity.informationSource=='D' }">selected="selected"</c:if>>D</option>
					                <option value="M" <c:if test="${entity.informationSource=='M' }">selected="selected"</c:if>>M</option>
					                <option value="Null" <c:if test="${entity.informationSource=='Null' }">selected="selected"</c:if>>Null</option>
            					</select>
								</td>
								
								<th><label class="">In Use Change Time</label></th>
								<!--数据项名称用th-->
								<td>
					            <input type="text" name="inUseChangeTime" id="inUseChangeTime" value="${entity.inUseChangeTime }" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
							<td colspan="4"><button type="submit" class="btn btn-submit">保存</button>
							<button type="submit" class="btn btn-submit" style="background-color: #FF7F50">设置</button></td>
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
							<a href="${root}/siteinfo/setting/advanced/acaForm/${siteInfoId}" class="current"> 
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
	<!-- Javascripts 注意不要改变顺序 -->
	<script type="text/javascript" src="${root}/themes/ais/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${root}/themes/ais/js/baseframe.js"></script>
	<script type="text/javascript" src="${root}/themes/ais/js/tplbase.js"></script>
	
	<script type="text/javascript">
		$(function() {
			//初始化页面元素
			changeAttribute();
		});
		function changeAttribute() {
			if($("#inUseFlag").val()=="0") {
				$("#nelatType1").attr("disabled","disabled");
				$("#nelatType1").attr("ignore","ignore");
				$("#nelatType2").attr("disabled","disabled");
				$("#nelatType2").attr("ignore","ignore");
				$("#nelat").attr("disabled","disabled");
				$("#nelat").attr("ignore","ignore");
				$("#nelonType1").attr("disabled","disabled");
				$("#nelonType1").attr("ignore","ignore");
				$("#nelonType2").attr("disabled","disabled");
				$("#nelonType2").attr("ignore","ignore");
				$("#nelon").attr("disabled","disabled");
				$("#nelon").attr("ignore","ignore");
				$("#swlatType1").attr("disabled","disabled");
				$("#swlatType1").attr("ignore","ignore");
				$("#swlatType2").attr("disabled","disabled");
				$("#swlatType2").attr("ignore","ignore");
				$("#swlat").attr("disabled","disabled");
				$("#swlat").attr("ignore","ignore");
				$("#swlonType1").attr("disabled","disabled");
				$("#swlonType1").attr("ignore","ignore");
				$("#swlonType2").attr("disabled","disabled");
				$("#swlonType2").attr("ignore","ignore");
				$("#swlon").attr("disabled","disabled");
				$("#swlon").attr("ignore","ignore");
				$("#transitionZone").attr("disabled","disabled");
				$("#transitionZone").attr("ignore","ignore");
				$("#channelA").attr("disabled","disabled");
				$("#channelA").attr("ignore","ignore");
				$("#bandWidthForChA").attr("disabled","disabled");
				$("#bandWidthForChA").attr("ignore","ignore");
				$("#channelB").attr("disabled","disabled");
				$("#channelB").attr("ignore","ignore");
				$("#bandWidthChB").attr("disabled","disabled");
				$("#bandWidthChB").attr("ignore","ignore");
				$("#trxMode").attr("disabled","disabled");
				$("#trxMode").attr("ignore","ignore");
				$("#powerLevel").attr("disabled","disabled");
				$("#powerLevel").attr("ignore","ignore");
				$("#informationSource").attr("disabled","disabled");
				$("#informationSource").attr("ignore","ignore");
				$("#inUseChangeTime").attr("disabled","disabled");
				$("#inUseChangeTime").attr("ignore","ignore");
			} else {
				$("#nelatType1").removeAttr("disabled");
				$("#nelatType1").removeAttr("ignore");
				$("#nelatType2").removeAttr("disabled");
				$("#nelatType2").removeAttr("ignore");
				$("#nelat").removeAttr("disabled");
				$("#nelat").removeAttr("ignore");
				$("#nelonType1").removeAttr("disabled");
				$("#nelonType1").removeAttr("ignore");
				$("#nelonType2").removeAttr("disabled");
				$("#nelonType2").removeAttr("ignore");
				$("#nelon").removeAttr("disabled");
				$("#nelon").removeAttr("ignore");
				$("#swlatType1").removeAttr("disabled");
				$("#swlatType1").removeAttr("ignore");
				$("#swlatType2").removeAttr("disabled");
				$("#swlatType2").removeAttr("ignore");
				$("#swlat").removeAttr("disabled");
				$("#swlat").removeAttr("ignore");
				$("#swlonType1").removeAttr("disabled");
				$("#swlonType1").removeAttr("ignore");
				$("#swlonType2").removeAttr("disabled");
				$("#swlonType2").removeAttr("ignore");
				$("#swlon").removeAttr("disabled");
				$("#swlon").removeAttr("ignore");
				$("#transitionZone").removeAttr("disabled");
				$("#transitionZone").removeAttr("ignore");
				$("#channelA").removeAttr("disabled");
				$("#channelA").removeAttr("ignore");
				$("#bandWidthForChA").removeAttr("disabled");
				$("#bandWidthForChA").removeAttr("ignore");
				$("#channelB").removeAttr("disabled");
				$("#channelB").removeAttr("ignore");
				$("#bandWidthChB").removeAttr("disabled");
				$("#bandWidthChB").removeAttr("ignore");
				$("#trxMode").removeAttr("disabled");
				$("#trxMode").removeAttr("ignore");
				$("#powerLevel").removeAttr("disabled");
				$("#powerLevel").removeAttr("ignore");
				$("#informationSource").removeAttr("disabled");
				$("#informationSource").removeAttr("ignore");
				$("#inUseChangeTime").removeAttr("disabled");
				$("#inUseChangeTime").removeAttr("ignore");
			}
		}
		
		//seqNumber的值改变的时候，重新获取实体信息
		function getAcaEntity() {
			var seqNumber = $("#seqNumber").val();
			var siteInfoId = $("#siteInfoId").val();
			$.ajax({
				type : "POST",
				data : "siteInfoId=" + siteInfoId + "&seqNumber="+seqNumber,
				dataType : "json",
				url : '${root}/siteinfo/advanced/showAcaEntity',
				success : function(data) {
					if(data.entity!=null) {
						$("#inUseFlag").val(data.entity.inUseFlag);
						if(data.entity.nelatType=="S") {
							$("#nelatType1").attr("checked","checked");
						} else {
							$("#nelatType2").attr("checked","checked");
						}
						$("#nelat").val(data.entity.nelat);
						if(data.entity.nelonType=="E") {
							$("#nelonType1").attr("checked","checked");
						} else {
							$("#nelonType2").attr("checked","checked");
						}
						$("#nelon").val(data.entity.nelon);
						if(data.entity.swlatType=="S") {
							$("#swlatType1").attr("checked","checked");
						} else {
							$("#swlatType2").attr("checked","checked");
						}
						$("#swlat").val(data.entity.swlat);
						if(data.entity.swlonType=="E") {
							$("#swlonType1").attr("checked","checked");
						} else {
							$("#swlonType2").attr("checked","checked");
						}
						$("#swlon").val(data.entity.swlon);
						$("#transitionZone").val(data.entity.transitionZone);
						$("#channelA").val(data.entity.channelA);
						$("#bandWidthForChA").val(data.entity.bandWidthForChA);
						$("#channelB").val(data.entity.channelB);
						$("#bandWidthChB").val(data.entity.bandWidthChB);
						$("#trxMode").val(data.entity.trxMode);
						$("#powerLevel").val(data.entity.powerLevel);
						$("#informationSource").val(data.entity.informationSource);
						$("#inUseChangeTime").val(data.entity.inUseChangeTime);
					} else {
						$("#id").val("");
						$("#inUseFlag").val("0");
						$("#nelatType1").attr("checked","checked");
						$("#nelat").val("");
						$("#nelonType1").attr("checked","checked");
						$("#nelon").val("");
						$("#swlatType1").attr("checked","checked");
						$("#swlat").val("");
						$("#swlonType1").attr("checked","checked");
						$("#swlon").val("");
						$("#transitionZone option:first").prop("selected", 'selected');
						$("#channelA").val("");
						$("#bandWidthForChA option:first").prop("selected", 'selected');
						$("#channelB").val("");
						$("#bandWidthChB option:first").prop("selected", 'selected');
						$("#trxMode option:first").prop("selected", 'selected');
						$("#powerLevel option:first").prop("selected", 'selected');
						$("#informationSource option:first").prop("selected", 'selected');
						$("#inUseChangeTime").val("");
					}
					changeAttribute();
				}
			});
		}
	</script>
</body>
</html>