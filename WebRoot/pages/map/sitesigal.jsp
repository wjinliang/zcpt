<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <style>
 .bg-blue{
		    background-color: #d3e6ed;
		}
		.ais-table{
		    text-align: center;
		}
		.ais-tp .ais-table{
		    width: 100%;
		}
		.ais-table thead tr th{
		    padding: 5px 3px;
		    text-align: center;
		    background-color: #d3e6ed;
		    font-weight: bold;
		    border-right: 1px solid #88a0aa;
		}
		.ais-table thead tr th:last-child{
		    border-right: none;
		}
		.ais-table tbody tr:hover{
		    background-color: #c7edfa;
		}
		.ais-table tbody tr.even:hover{
		    background-color: #c7edfa;
		}
		.ais-table tbody tr td{
		    padding: 4px 3px 3px 3px;
		    border-bottom: 1px solid #e6e6e6;
		    cursor: default;
		}
		.ais-table tbody tr.even{
		     background-color: #ecf5fc;
		 }
		.ais-tp{
		    padding-top: 1px;
		    height: 288px;
		    overflow: auto;
		}
 </style>
 </head>
 <body> 
   <form><!-- 
				 基站Id:&nbsp;&nbsp;&nbsp;&nbsp;</em><input type="text" id="baseId"/>
				  <br />
				  <br /> -->
				  选择基站:<select id="baseId" name="baseId">
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
				  <div id="toggleTimePoint">
				  时间点:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="timePoint" onFocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>&nbsp;&nbsp;
				  <br />
				  <br />
				  </div>
				 <div>
				 <div id="toggleTimeInternal" style="display: none;">
				 开始时间:<input type="text" id="siteInfoStartTime" onFocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>&nbsp;&nbsp;
				  <br />
				  <br />  
				  结束时间:<input type="text" id="siteInfoStopTime" onFocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>&nbsp;&nbsp;
				 <br />
				  <br />
				 </div>
				  时间段查询：<input type="checkbox" id="historyflag" />
				  </div>
				  <br />
				  <div style="text-align: center;">
				 <input type="hidden" id="command" value="${cmd}" />
				  <input id="baseSubmit" type="button" value="基站服务查询" class="btn blue" onclick="baseSiteSigal()"/>&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="reset" class="btn blue" value="重置"/>
				  <div>
	</form>
	<script>
/****************校验******************/
$("#baseId").blur(function(){
	if($("#baseId").val().replace(/[ ]/g,"")!=="")
	{
  		$("#baseId").css({"border-color":"#ccc"});
  	}  
});
$("#timePoint").blur(function(){
	if(!$("#historyflag").get(0).checked && $("#timePoint").val().replace(/[ ]/g,"")!=="")
	{
  		$("#timePoint").css({"border-color":"#ccc"});
  	}  
});
$("#siteInfoStopTime").blur(function(){
       if($("#historyflag").get(0).checked && $("#siteInfoStopTime").val().replace(/[ ]/g,"")!=="")
        {
         $("#siteInfoStopTime").css({"border-color":"#ccc"});
        }
     });
$("#siteInfoStartTime").blur(function(){
       if($("#historyflag").get(0).checked && $("#siteInfoStartTime").val().replace(/[ ]/g,"")!=="")
        {
         $("#siteInfoStartTime").css({"border-color":"#ccc"});
        }
     });
/***************基站信息查询****************/
	$("#historyflag").change(function(){
           $("#toggleTimeInternal").toggle();
           $("#toggleTimePoint").toggle();
	}); 
	function showRange(trElement)
       {
          var range = parseFloat($(trElement).children().last().text())*1000;
          sitegroup.circle.setRadius(range).addTo(map);
          map.setZoom(12);
       }   
	function baseSiteSigal()
	{
	  if($("#baseId").val().replace(/[ ]/g,"")=="")
	{
	   $("#baseId").css({"border-color":"red"});
	   return false;
	}
	else if(!$("#historyflag").get(0).checked && $("#timePoint").val().replace(/[ ]/g,"")==""){
	  $("#timePoint").css({"border-color":"red"});
	  return false;
	}
	else if($("#historyflag").get(0).checked && $("#siteInfoStartTime").val().replace(/[ ]/g,"")==="")
	{
        $("#siteInfoStartTime").css({"border-color":"red"});
        return;
	}
	else if($("#historyflag").get(0).checked && $("#siteInfoStopTime").val().replace(/[ ]/g,"")==="")
	{
       $("#siteInfoStopTime").css({"border-color":"red"});
       return;
	}
	   var command=$("#command").val(); 
	   var baseId=$("#baseId").val();
	   var historystart="";
	   var historyend="";
	   var timePoint=""
	   var 	dateStr = $("#timePoint").val().replace('-','/').replace('-','/');
       //var timePoint1 = Date.parse(dateStr);
	   
	   var startDateStr = $("#siteInfoStartTime").val().replace('-','/').replace('-','/');
	   if(startDateStr!="")
	   historystart = Date.parse(startDateStr);
	   stopDateStr =  $("#siteInfoStopTime").val().replace('-','/').replace('-','/');
	   if(stopDateStr!="")
	   historyend = Date.parse(stopDateStr);
	   if(dateStr!="")
	   {
	      var d = new Date(dateStr);  
	   
	   timePoint = Date.UTC(d.getUTCFullYear(),d.getUTCMonth(),d.getUTCDate(),d.getUTCHours(),d.getUTCMinutes(),d.getUTCSeconds());
	   }
	   var historyflag = $("#historyflag").get(0).checked?1:0;
	   var url = ipAddress+"/fcgi-bin/AIS_Monitor?cmd="+command+"&baseid="+baseId+"&timepoint="+timePoint+"&historyflag="+historyflag+"&historystart="+historystart+"&historyend="+historyend;
       
       
       /*******测试数据**********/
       siteSelectWindow.show();

       var str="";
		    	 switch(command)
		    	 {
			  	 case "0x0601":
			  	 data = [{"baseid":"1","begtime":1418018400000,"endtime":1418019599999,"aslot":10.0470485482078,"slot":11.6928266675016}];
		    	 str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>开始时间:</th><th>结束时间:</th><th>aslot:</th><th>bslot:</th></tr></thead>";
		    	 for(var i=0;i<data.length;i++)
		    	 {
		    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+data[i].begtime+"</td><td>"+utcToDate(data[i].endtime)+"</td><td>"+data[i].aslot+"</td><td>"+data[i].slot+"</td></tr>";
		    	 }
		    	 str = str+"</table>";
		    	 //str = "基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />aslot:"+data.aslot+"<br />bslot:"+data.bslot;
			  	 break;
				 case "0x0602":
				 str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>开始时间:</th><th>结束时间:</th><th>A信道信噪比:</th><th>B信道信噪比:</th></tr></thead>";
				  data = [{"baseid":"1","begtime":1418018400000,"endtime":1418019599999,"asnr":10.0470485482078,"bsnr":11.6928266675016}];
				 for(var i=0;i<data.length;i++)
				  {
				    str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].begtime)+"</td><td>"+utcToDate(data[i].endtime)+"</td><td>"+data[i].asnr+"</td><td>"+data[i].bsnr+"</td></tr>";
				  }
				break;
				case "0x0603":
				str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>开始时间:</th><th>结束时间:</th><th>基站数:</th><th>虚拟航标数:</th><th>AIS航标:</th><th>A类船数:</th><th>B类船数:</th></tr></thead>";
				data = [{"baseid":"1","begtime":1418018400000,"endtime":1418019599999,"basenum":10,"vnavinum":43,"anavinum":3,"atypenum":614,"btypenum":231}];
				  for(var i=0;i<data.length;i++)
				   {
				    	str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].begtime)+"</td><td>"+utcToDate(data[i].endtime)+"</td><td>"+data[i].basenum+"</td><td>"+data[i].vnavinum+"</td><td>"+data[i].anavinum+"</td><td>"+data[i].atypenum+"</td><td>"+data[i].btypenum+"</td></tr>";
				    }
				  str = str+"</table>";
				  break; 
				case "0x0604":
					data = [{"baseid":"1","begtime":1418018400000,"endtime":1418019599999,"range":811.521414484073}];
						str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>开始时间:</th><th>结束时间:</th><th>作用距离:</th></tr></thead>";
				    	 for(var i=0;i<data.length;i++)
				    	 {
				    	  str=str+"<tr onclick='showRange(this)'><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].begtime)+"</td><td>"+utcToDate(data[i].endtime)+"</td><td>"+data[i].range+"</td></tr>";
				    	 }
				    	 str = str+"</table>";	
						 break;
						 case "0x0607":
					     data =[{"endtime":1419751199999,"baseid":"1","msgnum":2370,"filterednum":2345,"begtime":1419750600000},{"endtime":1419751799999,"baseid":"1","msgnum":445875,"filterednum":445825,"begtime":1419751200000}];
					     
					    str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>开始时间:</th><th>结束时间:</th><th>消息总数</th><th>过滤消息总数</th></tr></thead>";
				    	 for(var i=0;i<data.length;i++)
				    	 {
				    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].begtime)+"</td><td>"+utcToDate(data[i].endtime)+"</td><td>"+data[i].msgnum+"</td><td>"+data[i].filterednum+"</td></tr>";
				    	 }
				    	 str = str+"</table>";	
						 break;
						 case "0x0608":cmd="0x0608";url="sitesigal";
						 data = [{"endtime":1419751199999,"baseid":"1","msgnum":2370,"ratio":{"1":0.989451476793249,"2":0.059451476793249},"begtime":1419750600000},{"endtime":1419751799999,"baseid":"2","msgnum":445875,"ratio":{"1":0.019451476793249,"2":0.98451476793249},"begtime":1419751200000}];
						 str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>开始时间:</th><th>结束时间:</th><th>消息总数</th><th>ratio</th></tr></thead>";
				    	 for(var i=0;i<data.length;i++)
				    	 {
				    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].begtime)+"</td><td>"+utcToDate(data[i].endtime)+"</td><td>"+data[i].msgnum+"</td><td>"+data[i].ratio.toString()+"</td></tr>";
				    	 }
				    	 str = str+"</table>";	
						 break;
						 case "0x0609":cmd="0x0609";url="sitesigal";
						data= [{"endtime":1419751199999,"baseid":"1","filterednum":2345,"navinum":2370,"atypenum":11234,"btypenum":2345,"othersnum":78,"begtime":1419750600000}];
						str="<table class='ais-table'><thead><tr><th>基站Id:</th><th>开始时间:</th><th>结束时间:</th><th>过滤总数</th><th>过滤航标报文数量</th><th>过滤A船台报文数量</th><th>过滤B船台报文数量</th><th>其他类型报文</th></tr></thead>";
				    	 for(var i=0;i<data.length;i++)
				    	 {
				    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+utcToDate(data[i].begtime)+"</td><td>"+utcToDate(data[i].endtime)+"</td><td>"+data[i].filterednum+"</td><td>"+data[i].navinum+"</td><td>"+data[i].atypenum+"</td><td>"+data[i].btypenum+"</td><td>"+data[i].othersnum+"</td></tr>";
				    	 }
				    	 str = str+"</table>";
				    	 break;
			   	}
		    	 
		    	 $("#siteSelectcontent" ).html(str);
		    	 $( "#baseDialog" ).dialog("open");
		    	 var flag=0;
		    	 sitegroup.eachLayer(function (layer) {
					    if(layer.agreementId&&layer.agreementId==baseId)
					      {
					     map.setView(layer.getLatLng());
					     layer.openPopup();
					     flag=1;
					     if(command=="0x0604")
							{
								if(!sitegroup.circle)
								{
								  sitegroup.circle  = L.circle(layer.getLatLng(),1);
								  sitegroup.circle.on("dblclick",function(){
                                       map.removeLayer(this);
                                       delete sitegroup.circle;
								  });
								}
							}
							return;
						}
					     				     
					});
					if(flag==0)
					{
					alert("获取的基站信息与地图上的基站信息不匹配！");
					}
            /*******测试数据**********/


	   $.ajax({
			 url:url, 
			 dataType:"jsonp",
			 success:function(result)
		     {
		     if(result.length<1)
		      {
		         //alert("未找到数据！");
		         return;
		      }
		     var data = result;
		     var str="";
		    	 switch(command)
		    	 {
			  	 case "0x0601":
			  	 //data = {"baseid":"1","begtime":1418018400000,"endtime":1418019599999,"aslot":10.0470485482078,"slot":11.6928266675016};
		    	 str="<table border='1'><tr><td>基站Id:</td><td>开始时间:</td><td>结束时间:</td><td>aslot:</td><td>bslot:</td></tr>";
		    	 for(var i=0;i<data.length;i++)
		    	 {
		    	  str=str+"<tr><td>"+data[i].baseid+"</td><td>"+data[i].begtime+"</td><td>"+utcToDate(data[i].endtime)+"</td><td>"+data[i].aslot+"</td><td>"+data[i].bslot+"</td></tr>";
		    	 }
		    	 str = str+"</table>";
		    	 //str = "基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />aslot:"+data.aslot+"<br />bslot:"+data.bslot;
			  		 break;
				 case "0x0602":
				 //data = {"baseid":"1","begtime":1418018400000,"endtime":1418019599999,"asnr":10.0470485482078,"bsnr":11.6928266675016};
		    	 str = "基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />asnr:"+data.asnr+"<br />bsnr:"+data.bsnr;
				   break;
				 case "0x0603":
				// data = {"baseid":"1","begtime":1418018400000,"endtime":1418019599999,"basenum":10,"vnavinum":43,"anavinum":3,"atypenum":614,"btypenum":231};
		    	 str = "基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />basenum:"+data.basenum+"<br />vnavinum:"+data.vnavinum
 	    		 +"<br />anavinum:"+data.anavinum+"<br />atypenum:"+data.atypenum+"<br />btypenum:"+data.btypenum;
					   break;
				 case "0x0604":
				 // data = {"baseid":"1","begtime":1418018400000,"endtime":1418019599999,"range":811.521414484073};
	    		 str = "基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />range:"+data.range;
					   break;
			     case "0x0605":
			     //data = {"baseid":1,"receivetime":1418018400000,"msgtype":"ALR","alarmtime":"030303.22","alarmcode":"003","range":"A","confirm":"V","describe":"aaaaasssss"};
				 str = "基站Id:"+data.baseid+"<br />"+"接受时间："+data.receivetimes+"<br />信息类型："+data.msgtype+"<br />ALR:"+data.ALR+"<br />报警时间："+data.alarmtime+"<br />报警码："+data.alarmcode+"<br />报警确认："+data.range+"(A:确认；V：未确认)"+"<br />报警描述文本"+data.describe;   
					   break;
			     case "0x0606":
			     str = "基站Id:"+data.baseid+"<br />"+"接受时间："+data.receivetimes+"<br />信息类型："+data.msgtype+"<br />识别码:"+data.identifier+"<br />报文顺序识别码："+data.sequence+"<br />测量UTC时间："+data.measurementutctime+"<br />报文的第一时隙数："+data.firstslotnumber+"<br />信号强度："+data.signalstrength+"<br />噪音比率信号"+data.noiseratio+"效验码:"+data.checkcode;   
					   break;
			     case "0x0607":cmd="0x0607";url="sitesigal";
			     str="基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />消息总数:"+data.msgnum+"过滤消息总数"+data.filterednum;
					   break;
				 case "0x0608":cmd="0x0608";url="sitesigal";
					    str="基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />消息总数:"+data.msgnum;
					   break;
				 case "0x0609":cmd="0x0609";url="sitesigal";
					    str=str = "基站Id:"+data.baseid+"<br />开始时间："+data.begtime+"<br />结束时间："+data.endtime+"<br />过滤总数:"+data.filterednum;;
					   break;
				 case "0x06010":cmd="0x06010";url="sitesigalsingle";
					 str="基站Id:"+data.baseid+"<br />开始时间："+data.messagetype+"<br />结束时间："+data.receivetime+"<br />地址域:"+data.addressdomain;
					   break;
			   	}
		    	 
		    	 $( "#baseDialog" ).html(str);
		    	
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
