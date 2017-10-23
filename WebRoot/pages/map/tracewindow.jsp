<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form >
				  <input type="text" id="boatmmsi" />&nbsp;&nbsp;mmsi
				  <br />
				  <br />
				  <input type="text" id="datepickerStart" onFocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>&nbsp;&nbsp;开始时间
				  <br />
				  <br />
				  <input type="text" id="datepickerStop"  onFocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>&nbsp;&nbsp;结束时间
				   <br />
				   <br />
				   <input type="checkbox" id="compress"/>&nbsp;&nbsp;压缩
				   <br />
				   <br />
				  <input id="traceButton" type="button" value="轨迹查询" onclick="traceBoat()"/>
				  <input id="traceClear" type="button" value="清除轨迹" onclick="clearTrace()"/><br />
</form>
