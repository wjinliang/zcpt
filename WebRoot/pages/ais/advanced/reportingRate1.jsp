<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>分配基站报文报告率类接口</title>
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
				<h2 class="ui-title-cnt fn-left">分配基站报文报告率类接口</h2>
			</div>
			<div class="formtabs ">
	          <ul>
	             <li class="formtabs-on" style="font-size: 12px" onclick="showCard(this,'formtabs2_cont','formtabs')">Msg 4(Base Station Report)</li>
	             <li class="formtabs-off" style="font-size: 12px" onclick="showCard(this,'formtabs2_cont','formtabs')">Msg 17(DGNSS)</li>
	             <li class="formtabs-off" style="font-size: 12px" onclick="showCard(this,'formtabs2_cont','formtabs')">Msg 20(Data Link Mgmt)</li>
	             <%-- 
	             <li class="formtabs-off" style="font-size: 12px" onclick="showCard(this,'formtabs2_cont','formtabs')">Msg 22(Channel Mgmt)</li>
	             <li class="formtabs-off" style="font-size: 12px" onclick="showCard(this,'formtabs2_cont','formtabs')">Msg 23(Group Assignment)</li>
	             --%>
	         </ul>
       		 </div>
			<!--标题栏结束-->
			<span class="x-line fn-clear">&nbsp;</span>

			<form name="form1" id="form-validate1" action="${root}/siteinfo/msg/advanced/saveSetting" method="post">
				<input type="hidden" name="msgType" value="4" id="msgType4" />
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity.id}" id="id" />
				<!-- 报文4 -->
				<div class="ui-list fn-clear"  id="formtabs2_cont0">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="180"></col>
							<col width="360"></col>
							<col width="180"></col>
                 			<col width="350"></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">Msg 4(Base Station Report)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><label class="">UTC Minute(Ch A)</label></th>
								<td>
									<input type="text" name="chAutcMinute4" value="0" id="chAutcMinute4" value="${entity.chAutcMinute4 }" class="input-normal input-wd200  fn-left" />
								</td>
								
								<th><label class="">UTC Minute(Ch B)</label></th>
								<td>
									<input type="text" name="chButcMinute4" value="0" id="chButcMinute4" value="${entity.chButcMinute4 }" class="input-normal input-wd200  fn-left"/>
								</td>
							</tr>
							<tr>
								<th><label class="">Start Slot(Ch A)</label>
								</th>
								<td><input type="text" name="chASlot4" id="chASlot4" value="${entity.chASlot4}" class="input-normal input-wd200  fn-left" />
								</td>
								<th><label class="">Start Slot(Ch B)</label></th>
								<td>
									<input type="text" name="chBSlot4" value="-1" id="chBSlot4" value="${entity.chBSlot4}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Increment(Ch A)</label></th>
								<td>
									<input type="text" name="chAIncrement4" id="chAIncrement4" value="${entity.chAIncrement4==''?750:entity.chAIncrement4}" class="input-normal input-wd200  fn-left" />
								</td>
								
								<th><label class="">Increment(Ch B)</label></th>
								<td>
									<input type="text" name="chBIncrement4" id="chBIncrement4" value="${entity.chBIncrement4==''?750:entity.chBIncrement4}" class="input-normal input-wd200  fn-left" />
								</td>
								
							</tr>
						</tbody>
						<tfoot>
							<tr>
							<td colspan="4">
							<button type="submit" class="btn btn-submit" >保存</button>
							<button type="submit" class="btn btn-submit" style="background-color: #FF7F50">设置</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</form>
			<form name="form2" id="form-validate2" action="${root}/siteinfo/msg/saveSetting" method="post">
				<input type="hidden" name="msgType" value="17" id="msgType17" />
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity.id}" id="id" />
				<!-- 报文17 -->
				<div class="ui-list fn-clear"  id="formtabs2_cont1" style="display: none;">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="180"></col>
							<col width="360"></col>
							<col width="180"></col>
                 			<col width="350"></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">Msg 17(DGNSS)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><label class="">UTC Minute(Ch A)</label>
								</th>
								<td><input type="text" name="chAutcMinute17" id="chAutcMinute17" value="${entity.chAutcMinute17}" class="input-normal input-wd200  fn-left" />
								</td>
							
								<th><label class="">UTC Minute(Ch B)</label>
								</th>
								<td><input type="text" name="chButcMinute17" id="chButcMinute17" value="${entity.chButcMinute17}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Start Slot(Ch A)</label>
								</th>
								<td><input type="text" name="chASlot17" id="chASlot17" value="${entity.chASlot17}"  class="input-normal input-wd200  fn-left" />
								</td>
								
								<th><label class="">Start Slot(Ch B)</label>
								</th>
								<td><input type="text" name="chBSlot17" id="chBSlot17" value="${entity.chBSlot17}"  class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Increment(Ch A)</label>
								</th>
								<td>
									<select name="chAIncrement17" id="chAIncrement17" class="input-select input-wd200" >
						                <option value="0" <c:if test="${entity.chAIncrement17=='0' }">selected="selected"</c:if>>0</option>
						                <option value="45" <c:if test="${entity.chAIncrement17=='45' }">selected="selected"</c:if>>45</option>
						                <option value="50" <c:if test="${entity.chAIncrement17=='50' }">selected="selected"</c:if>>50</option>
						                <option value="75" <c:if test="${entity.chAIncrement17=='75' }">selected="selected"</c:if>>75</option>
						                <option value="90" <c:if test="${entity.chAIncrement17=='90' }">selected="selected"</c:if>>90</option>
						                <option value="125" <c:if test="${entity.chAIncrement17=='125' }">selected="selected"</c:if>>125</option>
						                <option value="150" <c:if test="${entity.chAIncrement17=='150' }">selected="selected"</c:if>>150</option>
						                <option value="225" <c:if test="${entity.chAIncrement17=='225' }">selected="selected"</c:if>>225</option>
						                <option value="250" <c:if test="${entity.chAIncrement17=='250' }">selected="selected"</c:if>>250</option>
						                <option value="375" <c:if test="${entity.chAIncrement17=='375' }">selected="selected"</c:if>>375</option>
						                <option value="450" <c:if test="${entity.chAIncrement17=='450' }">selected="selected"</c:if>>450</option>
						                <option value="750" <c:if test="${entity.chAIncrement17=='750' }">selected="selected"</c:if>>750</option>
						                <option value="1125" <c:if test="${entity.chAIncrement17=='1125' }">selected="selected"</c:if>>1125</option>
						                <option value="2250" <c:if test="${entity.chAIncrement17=='2250' }">selected="selected"</c:if>>2250</option>
						                <option value="4550" <c:if test="${entity.chAIncrement17=='4550' }">selected="selected"</c:if>>4550</option>
						                <option value="6750" <c:if test="${entity.chAIncrement17=='6750' }">selected="selected"</c:if>>6750</option>
						                <option value="13500" <c:if test="${entity.chAIncrement17=='13500' }">selected="selected"</c:if>>13500</option>
	            					</select>
								</td>
							
								<th><label class="">Increment(Ch B)</label>
								</th>
								<td>
									<select name="chBIncrement17" id="chBIncrement17" class="input-select input-wd200" >
						                <option value="0" <c:if test="${entity.chBIncrement17=='0' }">selected="selected"</c:if>>0</option>
						                <option value="45" <c:if test="${entity.chBIncrement17=='45' }">selected="selected"</c:if>>45</option>
						                <option value="50" <c:if test="${entity.chBIncrement17=='50' }">selected="selected"</c:if>>50</option>
						                <option value="75" <c:if test="${entity.chBIncrement17=='75' }">selected="selected"</c:if>>75</option>
						                <option value="90" <c:if test="${entity.chBIncrement17=='90' }">selected="selected"</c:if>>90</option>
						                <option value="125" <c:if test="${entity.chBIncrement17=='125' }">selected="selected"</c:if>>125</option>
						                <option value="150" <c:if test="${entity.chBIncrement17=='150' }">selected="selected"</c:if>>150</option>
						                <option value="225" <c:if test="${entity.chBIncrement17=='225' }">selected="selected"</c:if>>225</option>
						                <option value="250" <c:if test="${entity.chBIncrement17=='250' }">selected="selected"</c:if>>250</option>
						                <option value="375" <c:if test="${entity.chBIncrement17=='375' }">selected="selected"</c:if>>375</option>
						                <option value="450" <c:if test="${entity.chBIncrement17=='450' }">selected="selected"</c:if>>450</option>
						                <option value="750" <c:if test="${entity.chBIncrement17=='750' }">selected="selected"</c:if>>750</option>
						                <option value="1125" <c:if test="${entity.chBIncrement17=='1125' }">selected="selected"</c:if>>1125</option>
						                <option value="2250" <c:if test="${entity.chBIncrement17=='2250' }">selected="selected"</c:if>>2250</option>
						                <option value="4550" <c:if test="${entity.chBIncrement17=='4550' }">selected="selected"</c:if>>4550</option>
						                <option value="6750" <c:if test="${entity.chBIncrement17=='6750' }">selected="selected"</c:if>>6750</option>
						                <option value="13500" <c:if test="${entity.chBIncrement17=='13500' }">selected="selected"</c:if>>13500</option>
	            					</select>
								</td>
							</tr>
							<tr>
								<th><label class="">Num. of slots(Ch A)</label>
								</th>
								<td>
								<select name="chASlotsNum17" id="chASlotsNum17" class="input-select input-wd200" >
					                <option value="">请选择</option>
					                <option value="1" <c:if test="${entity.chASlotsNum17=='1' }">selected="selected"</c:if>>1</option>
					                <option value="2" <c:if test="${entity.chASlotsNum17=='2' }">selected="selected"</c:if>>2</option>
					                <option value="3" <c:if test="${entity.chASlotsNum17=='3' }">selected="selected"</c:if>>3</option>
					                <option value="4" <c:if test="${entity.chASlotsNum17=='4' }">selected="selected"</c:if>>4</option>
            					</select>
								</td>
							
								<th><label class="">Num. of slots(Ch B)</label>
								</th>
								<td>
								<select name="chBSlotsNum17" id="chBSlotsNum17" class="input-select input-wd200"
									datatype="*" sucmsg=" " nullmsg="请选择频道B时隙数目!" >
					                <option value="">请选择</option>
					                <option value="1" <c:if test="${entity.chBSlotsNum17=='1' }">selected="selected"</c:if>>1</option>
					                <option value="2" <c:if test="${entity.chBSlotsNum17=='2' }">selected="selected"</c:if>>2</option>
					                <option value="3" <c:if test="${entity.chBSlotsNum17=='3' }">selected="selected"</c:if>>3</option>
					                <option value="4" <c:if test="${entity.chBSlotsNum17=='4' }">selected="selected"</c:if>>4</option>
            					</select>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
							<td colspan="4">
							<button type="submit" class="btn btn-submit" >保存</button>
							<button type="submit" class="btn btn-submit" style="background-color: #FF7F50">设置</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</form>
			<form name="form3" id="form-validate3" action="${root}/siteinfo/msg/saveSetting" method="post">
				<input type="hidden" name="msgType" value="20" id="msgType20" />
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity.id}" id="id" />
				<!-- 报文20 -->
				<div class="ui-list fn-clear"  id="formtabs2_cont2" style="display: none;">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="180"></col>
							<col width="360"></col>
							<col width="180"></col>
                 			<col width="350"></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">Msg 20(Data Link Mgmt)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><label class="">UTC Minute(Ch A)</label>
								</th>
								<td><input type="text" name="chAutcMinute20" id="chAutcMinute20" value="${entity.chAutcMinute20}" class="input-normal input-wd200  fn-left" />
								</td>
							
								<th><label class="">UTC Minute(Ch B)</label>
								</th>
								<td><input type="text" name="chButcMinute20" id="chButcMinute20" value="${entity.chButcMinute20}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Start Slot(Ch A)</label>
								</th>
								<td><input type="text" name="chASlot20" id="chASlot20" value="${entity.chASlot20}" class="input-normal input-wd200  fn-left" />
								</td>
								
								<th><label class="">Start Slot(Ch B)</label>
								</th>
								<td><input type="text" name="chBSlot20" id="chBSlot20" value="${entity.chBSlot20}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Increment(Ch A)</label>
								</th>
								<td>
									<select name="chAIncrement20" id="chAIncrement20" class="input-select input-wd200" >
						                <option value="0" <c:if test="${entity.chAIncrement20=='0' }">selected="selected"</c:if>>0</option>
						                <option value="45" <c:if test="${entity.chAIncrement20=='45' }">selected="selected"</c:if>>45</option>
						                <option value="50" <c:if test="${entity.chAIncrement20=='50' }">selected="selected"</c:if>>50</option>
						                <option value="75" <c:if test="${entity.chAIncrement20=='75' }">selected="selected"</c:if>>75</option>
						                <option value="90" <c:if test="${entity.chAIncrement20=='90' }">selected="selected"</c:if>>90</option>
						                <option value="125" <c:if test="${entity.chAIncrement20=='125' }">selected="selected"</c:if>>125</option>
						                <option value="150" <c:if test="${entity.chAIncrement20=='150' }">selected="selected"</c:if>>150</option>
						                <option value="225" <c:if test="${entity.chAIncrement20=='225' }">selected="selected"</c:if>>225</option>
						                <option value="250" <c:if test="${entity.chAIncrement20=='250' }">selected="selected"</c:if>>250</option>
						                <option value="375" <c:if test="${entity.chAIncrement20=='375' }">selected="selected"</c:if>>375</option>
						                <option value="450" <c:if test="${entity.chAIncrement20=='450' }">selected="selected"</c:if>>450</option>
						                <option value="750" <c:if test="${entity.chAIncrement20=='750' }">selected="selected"</c:if>>750</option>
						                <option value="1125" <c:if test="${entity.chAIncrement20=='1125' }">selected="selected"</c:if>>1125</option>
						                <option value="2250" <c:if test="${entity.chAIncrement20=='2250' }">selected="selected"</c:if>>2250</option>
						                <option value="4550" <c:if test="${entity.chAIncrement20=='4550' }">selected="selected"</c:if>>4550</option>
						                <option value="6750" <c:if test="${entity.chAIncrement20=='6750' }">selected="selected"</c:if>>6750</option>
						                <option value="13500" <c:if test="${entity.chAIncrement20=='13500' }">selected="selected"</c:if>>13500</option>
	            					</select>
								</td>
								
								<th><label class="">Increment(Ch B)</label>
								</th>
								<td>
									<select name="chBIncrement20" id="chBIncrement20" class="input-select input-wd200" >
						                <option value="0" <c:if test="${entity.chBIncrement20=='0' }">selected="selected"</c:if>>0</option>
						                <option value="45" <c:if test="${entity.chBIncrement20=='45' }">selected="selected"</c:if>>45</option>
						                <option value="50" <c:if test="${entity.chBIncrement20=='50' }">selected="selected"</c:if>>50</option>
						                <option value="75" <c:if test="${entity.chBIncrement20=='75' }">selected="selected"</c:if>>75</option>
						                <option value="90" <c:if test="${entity.chBIncrement20=='90' }">selected="selected"</c:if>>90</option>
						                <option value="125" <c:if test="${entity.chBIncrement20=='125' }">selected="selected"</c:if>>125</option>
						                <option value="150" <c:if test="${entity.chBIncrement20=='150' }">selected="selected"</c:if>>150</option>
						                <option value="225" <c:if test="${entity.chBIncrement20=='225' }">selected="selected"</c:if>>225</option>
						                <option value="250" <c:if test="${entity.chBIncrement20=='250' }">selected="selected"</c:if>>250</option>
						                <option value="375" <c:if test="${entity.chBIncrement20=='375' }">selected="selected"</c:if>>375</option>
						                <option value="450" <c:if test="${entity.chBIncrement20=='450' }">selected="selected"</c:if>>450</option>
						                <option value="750" <c:if test="${entity.chBIncrement20=='750' }">selected="selected"</c:if>>750</option>
						                <option value="1125" <c:if test="${entity.chBIncrement20=='1125' }">selected="selected"</c:if>>1125</option>
						                <option value="2250" <c:if test="${entity.chBIncrement20=='2250' }">selected="selected"</c:if>>2250</option>
						                <option value="4550" <c:if test="${entity.chBIncrement20=='4550' }">selected="selected"</c:if>>4550</option>
						                <option value="6750" <c:if test="${entity.chBIncrement20=='6750' }">selected="selected"</c:if>>6750</option>
						                <option value="13500" <c:if test="${entity.chBIncrement20=='13500' }">selected="selected"</c:if>>13500</option>
	            					</select>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
							<td colspan="4">
							<button type="submit" class="btn btn-submit" >保存</button>
							<button type="submit" class="btn btn-submit" style="background-color: #FF7F50">设置</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</form>
			<%-- 
			<form name="form4" id="form-validate4" action="${root}/siteinfo/msg/saveSetting" method="post">
				<input type="hidden" name="msgType" value="22" id="msgType22" />
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity.id}" id="id" />
				<!-- 报文22 -->
				<div class="ui-list fn-clear"  id="formtabs2_cont3" style="display: none;">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="180"></col>
							<col width="360"></col>
							<col width="180"></col>
                 			<col width="350"></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">Msg 22(Channel Mgmt)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><label class="">UTC Minute(Ch A)</label>
								</th>
								<td><input type="text" name="chAutcMinute22" id="chAutcMinute22" value="${entity.chAutcMinute22}" class="input-normal input-wd200  fn-left" />
								</td>
							
								<th><label class="">UTC Minute(Ch B)</label>
								</th>
								<td><input type="text" name="chButcMinute22" id="chButcMinute22" value="${entity.chButcMinute22}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Start Slot(Ch A)</label>
								</th>
								<td><input type="text" name="chASlot22" id="chASlot22" value="${entity.chASlot22}" class="input-normal input-wd200  fn-left" />
								</td>
								
								<th><label class="">Start Slot(Ch B)</label>
								</th>
								<td><input type="text" name="chBSlot22" id="chBSlot22" value="${entity.chBSlot22}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Increment(Ch A)</label>
								</th>
								<td>
									<select name="chAIncrement22" id="chAIncrement22" class="input-select input-wd200" >
						                <option value="0" <c:if test="${entity.chAIncrement22=='0' }">selected="selected"</c:if>>0</option>
						                <option value="45" <c:if test="${entity.chAIncrement22=='45' }">selected="selected"</c:if>>45</option>
						                <option value="50" <c:if test="${entity.chAIncrement22=='50' }">selected="selected"</c:if>>50</option>
						                <option value="75" <c:if test="${entity.chAIncrement22=='75' }">selected="selected"</c:if>>75</option>
						                <option value="90" <c:if test="${entity.chAIncrement22=='90' }">selected="selected"</c:if>>90</option>
						                <option value="125" <c:if test="${entity.chAIncrement22=='125' }">selected="selected"</c:if>>125</option>
						                <option value="150" <c:if test="${entity.chAIncrement22=='150' }">selected="selected"</c:if>>150</option>
						                <option value="225" <c:if test="${entity.chAIncrement22=='225' }">selected="selected"</c:if>>225</option>
						                <option value="250" <c:if test="${entity.chAIncrement22=='250' }">selected="selected"</c:if>>250</option>
						                <option value="375" <c:if test="${entity.chAIncrement22=='375' }">selected="selected"</c:if>>375</option>
						                <option value="450" <c:if test="${entity.chAIncrement22=='450' }">selected="selected"</c:if>>450</option>
						                <option value="750" <c:if test="${entity.chAIncrement22=='750' }">selected="selected"</c:if>>750</option>
						                <option value="1125" <c:if test="${entity.chAIncrement22=='1125' }">selected="selected"</c:if>>1125</option>
						                <option value="2250" <c:if test="${entity.chAIncrement22=='2250' }">selected="selected"</c:if>>2250</option>
						                <option value="4550" <c:if test="${entity.chAIncrement22=='4550' }">selected="selected"</c:if>>4550</option>
						                <option value="6750" <c:if test="${entity.chAIncrement22=='6750' }">selected="selected"</c:if>>6750</option>
						                <option value="13500" <c:if test="${entity.chAIncrement22=='13500' }">selected="selected"</c:if>>13500</option>
	            					</select>
								</td>
								
								<th><label class="">Increment(Ch B)</label>
								</th>
								<td>
									<select name="chBIncrement22" id="chBIncrement22" class="input-select input-wd200" >
						                <option value="0" <c:if test="${entity.chBIncrement22=='0' }">selected="selected"</c:if>>0</option>
						                <option value="45" <c:if test="${entity.chBIncrement22=='45' }">selected="selected"</c:if>>45</option>
						                <option value="50" <c:if test="${entity.chBIncrement22=='50' }">selected="selected"</c:if>>50</option>
						                <option value="75" <c:if test="${entity.chBIncrement22=='75' }">selected="selected"</c:if>>75</option>
						                <option value="90" <c:if test="${entity.chBIncrement22=='90' }">selected="selected"</c:if>>90</option>
						                <option value="125" <c:if test="${entity.chBIncrement22=='125' }">selected="selected"</c:if>>125</option>
						                <option value="150" <c:if test="${entity.chBIncrement22=='150' }">selected="selected"</c:if>>150</option>
						                <option value="225" <c:if test="${entity.chBIncrement22=='225' }">selected="selected"</c:if>>225</option>
						                <option value="250" <c:if test="${entity.chBIncrement22=='250' }">selected="selected"</c:if>>250</option>
						                <option value="375" <c:if test="${entity.chBIncrement22=='375' }">selected="selected"</c:if>>375</option>
						                <option value="450" <c:if test="${entity.chBIncrement22=='450' }">selected="selected"</c:if>>450</option>
						                <option value="750" <c:if test="${entity.chBIncrement22=='750' }">selected="selected"</c:if>>750</option>
						                <option value="1125" <c:if test="${entity.chBIncrement22=='1125' }">selected="selected"</c:if>>1125</option>
						                <option value="2250" <c:if test="${entity.chBIncrement22=='2250' }">selected="selected"</c:if>>2250</option>
						                <option value="4550" <c:if test="${entity.chBIncrement22=='4550' }">selected="selected"</c:if>>4550</option>
						                <option value="6750" <c:if test="${entity.chBIncrement22=='6750' }">selected="selected"</c:if>>6750</option>
						                <option value="13500" <c:if test="${entity.chBIncrement22=='13500' }">selected="selected"</c:if>>13500</option>
	            					</select>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
							<td colspan="4">
							<button type="submit" class="btn btn-submit" >保存</button>
							<button type="submit" class="btn btn-submit" style="background-color: #FF7F50">设置</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</form>
			<form name="form5" id="form-validate5" action="${root}/siteinfo/msg/saveSetting" method="post">
				<input type="hidden" name="msgType" value="23" id="msgType23" />
				<input type="hidden" name="siteInfoId" value="${siteInfoId}" id="siteInfoId" />
				<input type="hidden" name="id" value="${entity.id}" id="id" />
				<!-- 报文23 -->
				<div class="ui-list fn-clear"  id="formtabs2_cont4" style="display: none;">
					<table id="" class="ui-table-form  table-fix" summary="这是一个1行1列的表格样式模板">
						<colgroup>
							<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
							<col width="180"></col>
							<col width="360"></col>
							<col width="180"></col>
                 			<col width="350"></col>
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">Msg 23(Group Assignment)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><label class="">UTC Minute(Ch A)</label>
								</th>
								<td><input type="text" name="chAutcMinute23" id="chAutcMinute23" value="${entity.chAutcMinute23}" class="input-normal input-wd200  fn-left" />
								</td>
							
								<th><label class="">UTC Minute(Ch B)</label>
								</th>
								<td><input type="text" name="chButcMinute23" id="chButcMinute23" value="${entity.chButcMinute23}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Start Slot(Ch A)</label>
								</th>
								<td><input type="text" name="chASlot23" id="chASlot23" value="${entity.chASlot23}" class="input-normal input-wd200  fn-left" />
								</td>
								
								<th><label class="">Start Slot(Ch B)</label>
								</th>
								<td><input type="text" name="chBSlot23" id="chBSlot23" value="${entity.chBSlot23}" class="input-normal input-wd200  fn-left" />
								</td>
							</tr>
							<tr>
								<th><label class="">Increment(Ch A)</label>
								</th>
								<td>
									<select name="chAIncrement23" id="chAIncrement23" class="input-select input-wd200" >
						                <option value="0" <c:if test="${entity.chAIncrement23=='0' }">selected="selected"</c:if>>0</option>
						                <option value="45" <c:if test="${entity.chAIncrement23=='45' }">selected="selected"</c:if>>45</option>
						                <option value="50" <c:if test="${entity.chAIncrement23=='50' }">selected="selected"</c:if>>50</option>
						                <option value="75" <c:if test="${entity.chAIncrement23=='75' }">selected="selected"</c:if>>75</option>
						                <option value="90" <c:if test="${entity.chAIncrement23=='90' }">selected="selected"</c:if>>90</option>
						                <option value="125" <c:if test="${entity.chAIncrement23=='125' }">selected="selected"</c:if>>125</option>
						                <option value="150" <c:if test="${entity.chAIncrement23=='150' }">selected="selected"</c:if>>150</option>
						                <option value="225" <c:if test="${entity.chAIncrement23=='225' }">selected="selected"</c:if>>225</option>
						                <option value="250" <c:if test="${entity.chAIncrement23=='250' }">selected="selected"</c:if>>250</option>
						                <option value="375" <c:if test="${entity.chAIncrement23=='375' }">selected="selected"</c:if>>375</option>
						                <option value="450" <c:if test="${entity.chAIncrement23=='450' }">selected="selected"</c:if>>450</option>
						                <option value="750" <c:if test="${entity.chAIncrement23=='750' }">selected="selected"</c:if>>750</option>
						                <option value="1125" <c:if test="${entity.chAIncrement23=='1125' }">selected="selected"</c:if>>1125</option>
						                <option value="2250" <c:if test="${entity.chAIncrement23=='2250' }">selected="selected"</c:if>>2250</option>
						                <option value="4550" <c:if test="${entity.chAIncrement23=='4550' }">selected="selected"</c:if>>4550</option>
						                <option value="6750" <c:if test="${entity.chAIncrement23=='6750' }">selected="selected"</c:if>>6750</option>
						                <option value="13500" <c:if test="${entity.chAIncrement23=='13500' }">selected="selected"</c:if>>13500</option>
	            					</select>
								</td>
								
								<th><label class="">Increment(Ch B)</label>
								</th>
								<td>
									<select name="chBIncrement23" id="chBIncrement23" class="input-select input-wd200" >
						                <option value="0" <c:if test="${entity.chBIncrement23=='0' }">selected="selected"</c:if>>0</option>
						                <option value="45" <c:if test="${entity.chBIncrement23=='45' }">selected="selected"</c:if>>45</option>
						                <option value="50" <c:if test="${entity.chBIncrement23=='50' }">selected="selected"</c:if>>50</option>
						                <option value="75" <c:if test="${entity.chBIncrement23=='75' }">selected="selected"</c:if>>75</option>
						                <option value="90" <c:if test="${entity.chBIncrement23=='90' }">selected="selected"</c:if>>90</option>
						                <option value="125" <c:if test="${entity.chBIncrement23=='125' }">selected="selected"</c:if>>125</option>
						                <option value="150" <c:if test="${entity.chBIncrement23=='150' }">selected="selected"</c:if>>150</option>
						                <option value="225" <c:if test="${entity.chBIncrement23=='225' }">selected="selected"</c:if>>225</option>
						                <option value="250" <c:if test="${entity.chBIncrement23=='250' }">selected="selected"</c:if>>250</option>
						                <option value="375" <c:if test="${entity.chBIncrement23=='375' }">selected="selected"</c:if>>375</option>
						                <option value="450" <c:if test="${entity.chBIncrement23=='450' }">selected="selected"</c:if>>450</option>
						                <option value="750" <c:if test="${entity.chBIncrement23=='750' }">selected="selected"</c:if>>750</option>
						                <option value="1125" <c:if test="${entity.chBIncrement23=='1125' }">selected="selected"</c:if>>1125</option>
						                <option value="2250" <c:if test="${entity.chBIncrement23=='2250' }">selected="selected"</c:if>>2250</option>
						                <option value="4550" <c:if test="${entity.chBIncrement23=='4550' }">selected="selected"</c:if>>4550</option>
						                <option value="6750" <c:if test="${entity.chBIncrement23=='6750' }">selected="selected"</c:if>>6750</option>
						                <option value="13500" <c:if test="${entity.chBIncrement23=='13500' }">selected="selected"</c:if>>13500</option>
	            					</select>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
							<td colspan="4">
							<button type="submit" class="btn btn-submit" >保存</button>
							<button type="submit" class="btn btn-submit" style="background-color: #FF7F50">设置</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</form>
			--%>
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
							<a href="${root}/siteinfo/msg/form/${siteInfoId}/2" class="current"> 
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
	<!--Javascripts 注意不要改变顺序 -->
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
		});
		function resetForm() {
			$("#form-validate1").Validform().resetForm();
		}
		function setStatus(status, id){
			$("#status" + id).val(status);
		}
	</script>
</body>
</html>