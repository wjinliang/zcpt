<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 </head>
 <body> 
   <form>
				<!--   基站Id:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="baseIds"/>
				  <br />
				  <br /> -->
				  选择基站:<select id="baseIds" name="baseId">
				   <option value="">请选择……</option>
				  	 <c:forEach var = "siteInfoDto" items = "${siteInfoDtos}">
					    <c:if test = '${siteInfoDto.agreementId!=""}'><option value="${siteInfoDto.agreementId}">
					      ${siteInfoDto.sitename}
					      </option>
					    </c:if>
					 </c:forEach>
					</select>
					<br />
				  <br /> 
				 开始时间:<input type="text" id="siteInfoStartTimes" onFocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>&nbsp;&nbsp;
				  <br />
				  <br />  
				  结束时间:<input type="text" id="siteInfoStopTimes" onFocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>&nbsp;&nbsp;
				 <br />
				  <br />
				  <div style="text-align: center;">
				 <input type="hidden" id="commands" value="${cmd}" />
				  <input id="baseSubmit" type="button" class="btn blue" value="基站服务查询" onclick="baseSiteSigals()"/>&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="reset" class="btn blue" value="重置"/>
				  </div>
	</form>
	<script>
/***************基站信息查询****************/
	function baseSiteSigals()
	{
	  if($("#baseIds").val().replace(/[ ]/g,"")=="")
		{
		   $("#baseIds").addClass("validate");
		   return false;
		}
	   var command=$("#commands").val(); 
	   var baseId=$("#baseIds").val();
	   var cmd = "";
	   var startDateStr = $("#siteInfoStartTimes").val().replace('-','/').replace('-','/');
	   var historystart = Date.parse(startDateStr);
	   var stopDateStr =  $("#siteInfoStopTimes").val().replace('-','/').replace('-','/');
	   var historyend = Date.parse(stopDateStr);
	   var url = ipAddress+"/fcgi-bin/AIS_Monitor?cmd="+command+"&baseid="+baseId+"&begtime="+historystart+"&endtime="+historyend;
	 /*****测试数据*******/
	  var str="";var data;
		    	 switch(command)
		    	 {
				  	 case "0x0605":
                     data=[{baseid:1,receivetime:1418018400000,msgtype:"ALR",alarmtime:30303.22,alarmcode:"003",range:"A",confirm:"V", describe:"aaaaasssss"}] ;
				  	 str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>接收时间:</th><th>消息类型:</th><th>报警时间:</th><th>报警码:</th><th>报警条件:</th><th>报警确认状态</th><th>报警描述文本:</th></tr><thead>";
			    	 for(var i=0;i<data.length;i++)
			    	 {
			    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].receivetime)+"</td><td>"+data[i].msgtype+"</td><td>"+data[i].alarmtime+"</td><td>"+data[i].alarmcode+"</td><td>"+((data[i].range=='A') ? '超过阙值':'未超过阙值')+"</td><td>"+((data[i].confirm=='A') ? '确认':'未确认')+"</td><td>"+data[i].describe+"</td></tr>";
			    	 }
			    	 str = str+"</table>";
			    	 break; 
				     case "0x0606":
				     data = [{baseid:1,receivetime:1418018400000,msgtype:"VSI",identifier:"Dongtudi",sequence:2,measurementutctime:1418018400000,firstslotnumber:867, signalstrength:84,noiseratio:21,checkcode:"4D" }];
				     str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>接收时间:</th><th>消息类型:</th><th>唯一识别码:</th><th>报文顺序识别码</th><th>测量UTC时间:</th><th>报文的第一时隙数:</th><th> 接收器输入接受报文的信号强度:</th><th> 噪音比率信号</th><th>效验码</th></tr><thead>";
			    	 for(var i=0;i<data.length;i++)
			    	 {
			    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].receivetime)+"</td><td>"+data[i].msgtype+"</td><td>"+data[i].identifier+"</td><td>"+data[i].sequence+"</td><td>"+data[i].measurementutctime+"</td><td>"+data[i].firstslotnumber+"</td><td>"+data[i].signalstrength+"</td><td>"+data[i].noiseratio+"</td><td>"+data[i].checkcode+"</td></tr>";
			    	 }
			    	 str = str+"</table>";
			    	 break; 
				     case "0x0607":cmd="0x0607";url="sitesigal";
				     str="基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />消息总数:"+data.msgnum+"过滤消息总数"+data.filterednum;
						   break;
					 case "0x0608":cmd="0x0608";url="sitesigal";
						    str="基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />消息总数:"+data.msgnum+"过滤消息总数"+data.ratio;
						   break;
					 case "0x0609":cmd="0x0609";url="sitesigal";
						    str=str = "基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />过滤总数:"+data.filterednum;;
						   break;
					 case "0x0610":
					 data = [{"baseid":"1","messagetype":"ADS","receivetime":1417600583345,"addressdomain":"$ABADS","uniqueidentifier":"Dongtudi","statusreporttime":"022525.00","warningstate":"V","synchronousstate":"0","locationofSource":"S","utctimingsource":"I","checkcode":"2B"}];
					str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>消息类型:</th><th>接收时间:</th><th>地址域</th><th>唯一识别码</th><th>状态报告时间</th><th>警告状态</th><th>同步状态</th><th>位置源</th><th>UTC定时源</th><th>效验码</th></tr><thead>";
			    	 for(var i=0;i<data.length;i++)
			    	 {
			    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+data[i].messagetype+"</td><td>"+utcToDate(data[i].receivetime)+"</td><td>"+data[i].addressdomain+"</td><td>"+data[i].uniqueidentifier +"</td><td>"+data[i].statusreporttime+"</td><td>"+data[i].warningstate+"</td><td>"+data[i].synchronousstate+"</td><td>"+data[i].locationofSource +"</td><td>"+data[i].utctimingsource+"</td><td>"+data[i].checkcode+"</td></tr>";
			    	 }
			    	 str = str+"</table>";
			    	 break; 
						 //str="基站Id:"+data[i].baseid+"<br />开始时间："+data[i].messagetype+"<br />结束时间："+data.receivetime+"<br />地址域:"+data.addressdomain;
			   	}
		    	 console.log(str);
		    	 $("#siteSelectcontent" ).html(str);
		    	siteSelectWindow.show();
		    	 var flag=0;
		    	 sitegroup.eachLayer(function (layer) {
					    if(layer.agreementId&&layer.agreementId==baseId)
					      {
					     map.setView(layer.getLatLng());
					     layer.openPopup();
					     flag=1;
					     return;
					      }
					});
					if(flag==0)
					{
					alert("获取的基站信息与地图上的基站信息不匹配！");
					}
			/*****测试数据*******/
	   $.ajax({
			 url:url, 
			 dataType:"jsonp",
	         success:function(result)
		     {
		     console.log(result);
		     var data = result;
		     if(!result || result.length<1)
		      {
		         //alert("未找到数据！");
		         return;
		      }
		     var str="";
		    	 switch(command)
		    	 {
				  	 case "0x0605":
				  	 str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>接收时间:</th><th>消息类型:</th><th>报警时间:</th><th>报警码:</th><th>报警条件:</th><th>报警确认状态</th><th>报警描述文本:</th></tr><thead>";
			    	 for(var i=0;i<data.length;i++)
			    	 {
			    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].receivetime)+"</td><td>"+data[i].msgtype+"</td><td>"+data[i].alarmtime+"</td><td>"+data[i].alarmcode+"</td><td>"+((data[i].range=='A') ? '超过阙值':'未超过阙值')+"</td><td>"+((data[i].confirm=='A') ? '确认':'未确认')+"</td><td>"+data[i].describe+"</td></tr>";
			    	 }
			    	 str = str+"</table>";
			    	 break; 
				     case "0x0606":
				     str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>接收时间:</th><th>消息类型:</th><th>唯一识别码:</th><th>报文顺序识别码</th><th>测量UTC时间:</th><th>报文的第一时隙数:</th><th> 接收器输入接受报文的信号强度:</th><th> 噪音比率信号</th><th>效验码</th></tr><thead>";
			    	 for(var i=0;i<data.length;i++)
			    	 {
			    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].receivetime)+"</td><td>"+data[i].msgtype+"</td><td>"+data[i].identifier+"</td><td>"+data[i].sequence+"</td><td>"+data[i].measurementutctime+"</td><td>"+data[i].firstslotnumber+"</td><td>"+data[i].signalstrength+"</td><td>"+data[i].noiseratio+"</td><td>"+data[i].checkcode+"</td></tr>";
			    	 }
			    	 str = str+"</table>";
			    	 break; 
				     case "0x0607":cmd="0x0607";url="sitesigal";
				     str="基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />消息总数:"+data.msgnum+"过滤消息总数"+data.filterednum;
						   break;
					 case "0x0608":cmd="0x0608";url="sitesigal";
						    str="基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />消息总数:"+data.msgnum+"过滤消息总数"+data.ratio;
						   break;
					 case "0x0609":cmd="0x0609";url="sitesigal";
						    str=str = "基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />过滤总数:"+data.filterednum;;
						   break;
					 case "0x0610":
					str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>消息类型:</th><th>接收时间:</th><th>地址域</th><th>唯一识别码</th><th>状态报告时间</th><th>警告状态</th><th>同步状态</th><th>位置源</th><th>UTC定时源</th><th>效验码</th></tr><thead>";
			    	 for(var i=0;i<data.length;i++)
			    	 {
			    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+data[i].messagetype+"</td><td>"+utcToDate(data[i].receivetime)+"</td><td>"+data[i].addressdomain+"</td><td>"+data[i].uniqueidentifier +"</td><td>"+data[i].statusreporttime+"</td><td>"+data[i].warningstate+"</td><td>"+data[i].synchronousstate+"</td><td>"+data[i].locationofSource +"</td><td>"+data[i].utctimingsource+"</td><td>"+data[i].checkcode+"</td></tr>";
			    	 }
			    	 str = str+"</table>";
			    	 break; 
						 //str="基站Id:"+data[i].baseid+"<br />开始时间："+data[i].messagetype+"<br />结束时间："+data.receivetime+"<br />地址域:"+data.addressdomain;
			   	}
		    	 
		    	 $( "#baseDialog" ).html(str);
		    	 $( "#baseDialog" ).dialog("open");
		    	 var flag=0;
		    	 sitegroup.eachLayer(function (layer) {
					    if(layer.agreementId&&layer.agreementId==baseId)
					      {
					     map.setView(layer.getLatLng());
					     layer.openPopup();
					     flag=1;
					     return;
					      }
					});
					if(flag==0)
					{
					alert("获取的基站信息与地图上的基站信息不匹配！");
					}
		     },
		     error:function(XMLHttpRequest, textStatus, errorThrown)
		     {
		     alert("请求数据失败，请查看数据服务器！");
		     }
			});
	}
	</script>
	</body>
</html>
