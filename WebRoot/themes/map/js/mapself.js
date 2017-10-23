
/**************清除轨迹********/
 function clearTrace()
 {
	 trace.clearLayers();
 }
 
 
 /**根据基站协议id读取基站的名字**/
 function siteAgreeToNam(agreementId)
 {
	 var sitename = "未知";
	 sitegroup.eachLayer(function (layer) {
		 console.log(layer.agreementId);
		   if(layer.agreementId && layer.agreementId==agreementId)
		   {
			   sitename = layer.sitename;
		   }
	 });
	 return sitename;
 }
 
/**********网格化数据**********/
function mapgridInit(num)
{
	
	$.ajax({
       url:"./gridLoad",
       success:function(data)
       {
       	gridgroupsmall.clearLayers();
		gridgroupmiddle.clearLayers();
		gridgroupbig.clearLayers();
    	   var numIcon;
          var smallLen = data.small.length;
          for(var i=0;i<smallLen;i++)
        	  {
        	  var bounds = [[data.small[i].swlat,data.small[i].swlng],[data.small[i].nelat,data.small[i].nelng]];
        	    numIcon = L.divIcon({iconSize: L.point(30, 15),html:""+data.small[i].shipnum});
        	    var rectgrid = new L.rectangle(bounds,{color: "blue", weight: 2,opacity:0.1});
        	    var marker = new L.marker(rectgrid.getBounds().getCenter(),{icon:numIcon});
        	    gridgroupsmall.addLayer(marker);
        	    gridgroupsmall.addLayer(rectgrid);
        	  }
           var middleLen = data.middle.length;
		     for(var i=0;i<middleLen;i++)
		   	{
		   	 var bounds = [[data.middle[i].swlat,data.middle[i].swlng],[data.middle[i].nelat,data.middle[i].nelng]]
		   	 numIcon = L.divIcon({iconSize: L.point(30, 15),html:""+data.middle[i].shipnum});
		   	  var rectgrid = new L.rectangle(bounds,{color: "blue", weight: 2,opacity:0.1});
		     var marker = new L.marker(rectgrid.getBounds().getCenter(),{icon:numIcon});
		      gridgroupmiddle.addLayer(marker);
		     gridgroupmiddle.addLayer(rectgrid);
		   	}
            var bigLen = data.big.length;
		   	for(var i=0;i<bigLen;i++)
		   	{
		   	 var bounds = [[data.big[i].swlat,data.big[i].swlng],[data.big[i].nelat,data.big[i].nelng]];
		   	 numIcon = L.divIcon({iconSize: L.point(30, 15),html:""+data.big[i].shipnum});
		     var rectgrid = new L.rectangle(bounds,{color: "blue", weight: 2,opacity:0.1});
		     var marker = new L.marker(rectgrid.getBounds().getCenter(),{icon:numIcon});
		     gridgroupbig.addLayer(marker);
		     gridgroupbig.addLayer(rectgrid);
		   	}
       }
	});
}
/*********删除图层**********/
function deleteLayer(){
   drawCircle.disable();
   drawMarker.disable();
   drawRectangle.disable();
	$(".deleteSave").show();
	 drawDelete.enable();
}
/*********保存删除图层****/
function saveLayer(){
	drawDelete.save();
	drawDelete.disable();
	$(".deleteSave").hide();
}
/********取消图层*******/
function cancelLayer(){
	drawDelete.revertLayers();
	drawDelete.disable();
	$(".deleteSave").hide();
}
/*******判断是否可以删除图层********/
function checkdisable(){
	var hasLayers = drawnItems.getLayers().length !== 0;

	if(hasLayers){
		
		$(".deleteSave").first().prev().children('a').get(0).disabled=false;
	}
	else{
		
		$(".deleteSave").first().prev().children('a').get(0).disabled="disabled";
	}
}

/*********测距******/
function measureDistanceClick()
{
	 drawCircle.disable();
   drawMarker.disable();
   drawRectangle.disable();
	measureDistance.enable();
}

/*********区域广播********/
function areaBroadCast(msgtype){
	if(map.getZoom()<10)
	{
		alert("请放大后选择船只!");
		return;
	}
  drawType.type = "areaBroadCast";
  drawType.num=msgtype;
   drawCircle.disable();
   drawMarker.disable();
   drawRectangle.enable();
}
 /*********虚拟标*********/
function virtualClick()
{
	drawType.type = "virtual";
	drawCircle.disable();
	drawRectangle.disable();
	drawMarker.enable();
}

/**********信道管理*******/
function channelManagementClick()
{
	drawCircle.disable();
	drawMarker.disable();
    drawRectangle.enable();
    drawType.type = "channelManagement";
}
/********查看拓扑图**********/
function showtopologyUrl(element){
   window.open(element.id); 
}
 /*******显示隐藏基站作用距离******/
 /*function showsiterange(agreementId){
 	
 	map.eachLayer(function(layer){
           if(layer.agreementId==agreementId)
            {
           	if(map.hasLayer(layer.circle))
           	   map.removeLayer(layer.circle);
           	else{
           		 map.addLayer(layer.circle);
           	 }
           }
 	});
 }*/
/*********船发报文********/
function showBoatWindow(msgtype){
	
	var type= contextMenuBoatWindow.type;
	var lat,lng;
	 if(type==0)
    {
	   var latlng = contextMenuBoatWindow.latlng;
	lat = latlng.lat;
	lng = latlng.lng;
    }
	
	var mmsi= contextMenuBoatWindow.mmsi;
	console.log(mmsi);
	var agreementId = contextMenuBoatWindow.agreementId+"";
	delete contextMenuBoatWindow.type;
    delete contextMenuBoatWindow.id;
    delete contextMenuBoatWindow.agreementId;
    delete contextMenuBoatWindow.latlng;
    var content="";
    var url;
   
   var rectangle = new L.Draw.Rectangle(map);
		switch(msgtype)
	{
		case "twelveSite":url=content = '<form id="sendMsgForm">'+
    	'<input type="hidden" name="idCode" value="'+agreementId+'"/>'+
    	'<input type="hidden" name="mmsi" value="'+mmsi+'"/>'+
    	'<input type="hidden" name="sourceID" value="'+mmsi+'"/>目的基站mmsi<br/>'+
    	'<input type="text" name="destinationMMSI"/><br/>文本消息<br/>'+
		'<textarea id="longText"></textarea>'+
       '<div class="middle"><input type="button" onclick="sendMsg(\''+msgtype+'\')" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div></form>';break;
		case "tenBoat" :content="";alert("已经发送等待回复");break;
        case "tenSite" :content="";alert("已经发送等待回复");break;
        case "fifteenBoat" :content="";alert("已经发送等待回复");break;
        case "fifteenSite" :content="";alert("已经发送等待回复");break;
        case "twentyTwoBoat" :content="";rectangle.enable();drawType.type="channelManagement"; break;
        case "forteenSite" :content = '<form id="sendMsgForm">'+
    	'<input type="hidden" name="idCode" value="'+agreementId+'"/>'+
    	'<input type="hidden" name="mmsi" value="'+mmsi+'"/>'+
    	'<input type="hidden" name="sourceID" value="'+mmsi+'"/>目的基站mmsi<br/>'+
    	'<input type="text" name="destinationMMSI"/><br/>文本消息<br/>'+
		'<textarea id="longText"></textarea>'+
       '<div class="middle"><input type="button" onclick="sendMsg(\''+msgtype+'\')" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div></form>';break;
		case "twelveBoat" : content = '<form>'+
		'<textarea id="longText"></textarea>'+
       '<div class="middle"><input type="button" onclick="sendBoatMsg(\''+mmsi+'\',\''+msgtype+'\','+lat+','+lng+')" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div></form>';break;
        default : content = '<form>'+
		'<textarea id="longText"></textarea>'+
       '<div class="middle"><input type="button" onclick="sendBoatMsg(\''+mmsi+'\',\''+msgtype+'\','+lat+','+lng+')" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div></form>';break;
		/*case "sevenBoat" : content='<form>'+
		 '<textarea></textarea>'+
	       '<div class="middle"><input type="button" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div></form>';break;
        case "eightMsg": content='<form>'+
		 '<textarea></textarea>'+
	       '<div class="middle"><input type="button" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div></form>';break;
	   case "tenMsg" :content='<form>'+
		 '<textarea></textarea>'+
	       '<div class="middle"><input type="button" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div></form>';break;*/
	}
  if(content!=="")
  {
  	contextMenuBoatWindow.content(content);
  	contextMenuBoatWindow.show();
  }
}

/***********信道管理*************/
function saveChanelManager()
{       
	    var tzoneSizelng=0;
        if($("#tzoneSize").val()!="") 
        {
        	tzoneSizelng = parseFloat($("#tzoneSize").val())/59.39;
        } 
	    var east =  toLngLat($("#channelManagementNElng").val())+tzoneSizelng;
		var North = toLngLat($("#channelManagementNElat").val())+tzoneSizelng;
		var west =  toLngLat($("#channelManagementSWlng").val())-tzoneSizelng;
		var south = toLngLat($("#channelManagementSWlat").val())-tzoneSizelng; 
	    channelMangerWindow.layer.setBounds([[south,west],[North,east]]);
}
 /********经纬度转换度分秒**********/
 function lngLatTo(lng)

 {
     var lngMini = (lng-parseInt(lng))*60;
     var lngSecon = (lngMini - parseInt(lngMini))*60;
     return  parseInt(lng)+"°"+parseInt(lngMini)+"."+parseInt(lngSecon)+"'";
 }
  /********度分秒转换经纬度**********/
 function toLngLat(lng)
 {
    var lnglatNum = parseFloat(lng.substring(lng.indexOf("°")+1,lng.indexOf(".")))+parseFloat(lng.substring(lng.indexOf(".")+1,lng.indexOf("'")))/60;
   
    lnglatNum = parseFloat(lng.substring(0,lng.indexOf("°")))+lnglatNum/60;
   
     return  lnglatNum;
 }
/***********虚拟航标*********/
 function saveVirtualSalw()
 { 
    virtualSaleWindow.layer.setLatLng([toLngLat($("#virtuallat").val()),toLngLat($("#virtuallng").val())]);
    virtualSaleWindow.layer.name = $("#virtualSaleName").val();
    alert("保存成功！");
 }
 /*******轨迹窗口打开*******/
 function traceFormWindow()
 {
  $("#traceForm").click();
  traceWindow.content(tracecontent);
  traceWindow.show();
 }
 
 /*******基站打开*******/
 function siteFormWindow()
 {
  $("#selectSiteInfo").val(0);
  $("#selectSiteInfo").change();
  siteWindow.show();
 }
 /*********utctoDate***********/
 
 function utcToDate(dateutc)
 {
   var str = "";
   var date = new Date(dateutc);
   str = str+date.getUTCFullYear()+"-"+date.getUTCMonth()+"-"+date.getUTCDate()+" "+date.getHours()+":"+date.getUTCMinutes()+":"+date.getUTCSeconds();
   return str;
 }
 
 /**********单船轨迹查询*************/
function traceBoat()
{
	var ipAddress = $("#dftIpAddress").val();
	if($("#boatmmsi").val().replace(/[ ]/g,"")==="")
	{
	   $("#boatmmsi").css({"border-color":"red"});
	   return false;
	}
	else if($("#datepickerStart").val().replace(/[ ]/g,"")==""){
	  $("#datepickerStart").css({"border-color":"red"});
	  return false;
	}
	else if($("#datepickerStop").val().replace(/[ ]/g,"")=="")
	{
	  $("#datepickerStop").css({"border-color":"red"});
	   return false;
	}
	$.ajax({
		 //url:ipAddress+"/fcgi-bin/AIS_Monitor", 
		 url:"trackfilter",
		 dataType:"json",
		 type:"post",
		 data:{
				       	mmsi:$("#boatmmsi").val(),
				       	startdt:Date.parse($("#datepickerStart").val().replace('-','/').replace('-','/')),
				       	enddt:Date.parse($("#datepickerStop").val().replace('-','/').replace('-','/')),
				       	compress:$("#compress").val()==""?10:$("#compress").val(),
				       	scale:map.getZoom()
			  },
	     success:function(data)
	     {
	    	 /*if(data)
	    	{
	    	 if(data.length>0)
		    	{
		    	 var latlngs=[];
		    	 for(var i in data)
		    		 {
		    		   var tt = data[i].split("|");
		    		   var latlng = L.latLng(tt[2], tt[1]);
		    		   var popup = L.popup().setContent('<p>时间:'+tt[3]+'<br />经度：'+tt[1]+'；纬度：'+tt[2]+'</p>')
		    		   var circle =  L.circleMarker(latlng,{color:"#FFFF44",weight:6,fill:"#FFFF44",opacity:1}).bindPopup(popup);
		    		   circle.setRadius(3).addTo(map);
		    		   trace.addLayer(circle);
		    		   latlngs.push(latlng);
		    		 }
		    	      var polyline = L.polyline(latlngs, {color: 'red',weight:3,clickable:false,dashArray: '10, 10',lineCap:'round'}).addTo(map);
		    		  trace.addLayer(polyline);
		    		  map.setView(latlngs[latlngs.length-1]);
		    	}*/
	    	 var len = data.length;
	    	 console.log(len);
	    	 if(data)
	    	 {
	            if(len>0)
	            	{
	            	 var latlngs=[];
	            	var trace = L.featureGroup().addTo(map);
		            	for(var i=0;i<len;i++)
			    		 {
			    		   var latlng = L.latLng(data[i].y, data[i].x);
			    		   var popup = L.popup().setContent('<p>时间:'+data[i].datetime+'<br />经度：'+data[i].x+'；纬度：'+data[i].y+'</p>')
			    		   var circle =  L.circleMarker(latlng,{color:"#FFFF44",weight:6,fill:"#FFFF44",opacity:1}).bindPopup(popup);
			    		   circle.setRadius(3).addTo(map);
			    		   trace.addLayer(circle);
			    		   latlngs.push(latlng);
			    		 }
			    	      var polyline = L.polyline(latlngs, {color: 'red',weight:3,clickable:false,dashArray: '10, 10',lineCap:'round'}).addTo(map);
			    		  trace.addLayer(polyline);
 			       	 	 var strFile = '<a href="../siteinfo/tracedownload/'+data[0].mmsi+'"><img src="../themes/map/images/exporttrace.png" /></a>';
 			       	 	 var importIcon = L.divIcon({html:strFile,className:"markerIcon",iconAnchor: [-5, -1]});
 			       	 	 var closeIcon = L.icon({iconUrl:"../themes/map/images/traceclose.png",iconAnchor: [-24, -3]});
 			       	 	 var importMarker = L.marker([latlngs[latlngs.length-1].lat,latlngs[latlngs.length-1].lng],{icon:importIcon}).addTo(map);    			       	 	 
                          var closeMarker = L.marker([latlngs[latlngs.length-1].lat,latlngs[latlngs.length-1].lng],{icon:closeIcon}).addTo(map);
 			       	     var polyline = L.polyline(latlngs, {color: 'red',weight:3,clickable:false,dashArray: '10, 10',lineCap:'round'});
 			       	 	  map.addLayer(polyline);
 			       	 	  map.addLayer(trace);
 			       	 	  closeMarker.on("click",function(e){
                             map.removeLayer(polyline);
                             map.removeLayer(trace);
                             map.removeLayer(importMarker);
                             map.removeLayer(this);
 			       	 	 }); 
			    		  map.setView(latlngs[latlngs.length-1]);
	            	}
		    	 else{
		    		 alert("未找到记录！显示模拟记录！");
		    		 /******模拟轨迹********/
		    			var data = [
		    			       	 "1|121.37|35.57|1420781805189|3410|6|0|TIANJIN@@@@@@@@@@@@@|10072200|||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
		    			       	 "1|125.51|34.39|1420781802770|0|0|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
		    			       	 "1|123.90|32.65|1420781803253|0|1|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
		    			       	 "1|126.23|31.95|1420781803818|1630|7|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
		    			       	 "1|126.93|31.89|1420781803818|1630|7|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
		    			       	 "1|127.04|30.65|1420781803818|1630|7|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null"
		    			       	 ];
		    			       	 	var latlngs=[];
		    			       	 	var trace = L.featureGroup().addTo(map);
		    			       	 	for(var i in data)
		    			       	 	 {
		    			       	 	 	var tt = data[i].split("|");
		    			       	 	   var latlng = L.latLng(tt[2], tt[1]);
		    			       	 	   var popup = L.popup().setContent('<p>时间:'+tt[3]+'<br />经度：'+tt[1]+'；纬度：'+tt[2]+'</p>')
		    			       	 	   var circle =  L.circleMarker(latlng,{color:"#FFFF44",weight:6,fill:"#FFFF44",opacity:1}).bindPopup(popup);
		    			       	 	   circle.setRadius(3);
		    			       	 	   trace.addLayer(circle);
		    			       	 	   latlngs.push(latlng);
		    			       	 	 }
		    			       	 	 var tracedata = data[0].split("|");
		    			       	 	 var mmsi = tracedata[0];
		    			       	 	 var strFile = '<a href="../siteinfo/tracedownload/'+mmsi+'"><img src="../themes/map/images/exporttrace.png" /></a>';
		    			       	 	 var importIcon = L.divIcon({html:strFile,className:"markerIcon",iconAnchor: [-5, -1]});
		    			       	 	 var closeIcon = L.icon({iconUrl:"../themes/map/images/traceclose.png",iconAnchor: [-24, -3]});
		    			       	 	 var importMarker = L.marker([latlngs[latlngs.length-1].lat,latlngs[latlngs.length-1].lng],{icon:importIcon}).addTo(map);    			       	 	 
                                     var closeMarker = L.marker([latlngs[latlngs.length-1].lat,latlngs[latlngs.length-1].lng],{icon:closeIcon}).addTo(map);
		    			       	     var polyline = L.polyline(latlngs, {color: 'red',weight:3,clickable:false,dashArray: '10, 10',lineCap:'round'});
		    			       	 	  trace.addLayer(polyline);
		    			       	 	  map.addLayer(trace);
		    			       	 	  closeMarker.on("click",function(e){
                                        map.removeLayer(trace);
                                        map.removeLayer(importMarker);
                                        map.removeLayer(this);
		    			       	 	 }); 
		    			       	 	  map.setView(latlngs[latlngs.length-1]);

		    			       	 /******模拟轨迹********/
		    	 }
	    	}
	    	 else{
	    		 alert("连接失败！");
	    	 }
	     },
	     error:function(e){
	    	 console.log(e);
	     alert("查询失败，请查询数据服务器是否正常！");
	     
	     }
		});
}
/******模拟放大地图轨迹点增多的效果**********/
function traceMoreAndLess()
{ 
	addgroup = L.featureGroup().addTo(map);
	if(map.getZoom()>6)
	{
	var data = [
	 "1|117.79|38.39|1420781805178|3410|6|0|TIANJIN@@@@@@@@@@@@@|10072200|||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
	 "1|118.32|38.19|1420781802760|0|0|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
	 "1|118.78|38.29|1420781803243|0|1|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
	 "1|118.94|38.99|1420781803808|1630|7|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
	 "1|119.94|37.99|1420781803812|1630|7|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null",
	 "1|121.94|38.99|1420781803819|1630|7|0|TIANJIN@@@@@@@@@@@@@|10072200|-1||null|In Service/Commission|412687000|null|RONGTONG68@@@@@@@@@@|0|null"
	 ];
	 for(var i in data)
	 	 {
	 	   var tt = data[i].split("|");
	 	   var latlng = L.latLng(tt[2], tt[1]);
	 	   var popup = L.popup().setContent('<p>时间:'+tt[3]+'<br />经度：'+tt[1]+'；纬度：'+tt[2]+'</p>')
	 	   var circle =  L.circleMarker(latlng,{color:"#FFFF44",weight:6,fill:"#FFFF44",opacity:1}).bindPopup(popup);
	 	   circle.setRadius(3).addTo(map);
	 	   addgroup.addLayer(circle);
	 	   trace.polyline.addLatLng(latlng);
	 	 }
	 }
	 else{
	 	map.removeLayer(addgroup);
	 }
}
/*******************单船和多船信息查询，多船用逗号隔开*************************/
function searchAisBoat()
{
		
		var value = $("#search").val();
		/*包含逗号则为多船*/
		if(value.replace(/[ ]/g,"")==="")
		{
			$("#search").css({"border-color":"red"});
			return;
		}

		if(value.indexOf(',')>0)
			{
			$("#dialog" ).dialog("open");
			var mmsi  = value.split(",");
			var i=0;
			 for(;i<mmsi.length;i++)
				  {
				    var value = ""+mmsi[i]; 
				    var a = $('<a href="#" onclick="searchSingle(\''+value+'\');">mmsi: '+mmsi[i]+'</a><br/>');
				     $("#dialog").append(a);
				  }
			}
		/*单船信息*/	
		else
			{
			searchSingle(value);
			}
}
/********************单船多船都是调用此方法********************/
function searchSingle(value)
{
	var ipAddress = $("#dftIpAddress").val();
		searchBoatGroup.clearLayers();
		/***********测试数据************
		var result = [{"mmsi":"205420000","imo":"xxxx","callSign":"huhao","country":"chuanji","type":0,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":120.76,"latitude":33.62,"rot":0,
	   			 "sog":46,"truehead":511,"dest":"mudigang","length":0.0,"width":0.0,"posType":"0","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""}];
		 *
		 var ships = result;
		if(result.length>0)
			 {
			for(var i=0;i<ships.length;i++)
			  {
			     var l = L.latLng(ships[i].latitude, ships[i].longitude);
			     var popup = L.popup().setContent('<table>'+
			     '<tr>'+
              '<td>mmsi:</td>'+
              '<td>'+ships[i].mmsi+'</td>'+
              '<td>船舶IMO:</td>'+
              '<td>'+ships[i].imo+'</td></tr><tr>'+
              '<td>经度：</td>'+
              '<td>'+ships[i].latitude+'</td>'+
              '<td>经度：</td>'+
              '<td>'+ships[i].longitude+'</td></tr>'+
              '</table>'
               ); 
			     var icon;
                         if(i%3==0)
                         {
                         	icon = boatIcon0;
                         }
                         if(i%3==1)
                         {
                         	icon=boatIcon1;
                         }
                         if(i%3==2)
                         {
                         	icon=boatIcon2;
                         }
                         var opacity =0;
                         if($("#boatmonitor").attr("checked")==="checked")
                         { 
                           opacity=1;
                         }
			           var m = L.marker(l,{icon:icon,opacity:opacity,angle:data[i].truehead%360}).bindPopup(popup).addTo(map);
					     //L.setOptions(m,{});
					      m.mmsi=data[i].mmsi;
					     group.addLayer(m);
			  } 
			 }*/
	    /***********测试数据**************/
		$.ajax({
			 url:ipAddress+"/fcgi-bin/AIS_Monitor", 
			 dataType:"jsonp",
			 data:{
					       	cmd:"0x0106",
					       	mmsi:parseInt(value) 
				  },
		     success:function(data)
		     {
		     	    	 
		    	 if(data.length>0)
		    		 {
		    		 for(var i=0;i<data.length;i++)
					  {
		    			 var l = L.latLng(data[i].latitude, data[i].longitude);
		    			 /****演示去掉@****/
		    			 var re = new RegExp("@","g"); 
					     var dest = data[i].dest?data[i].dest.replace(re,''):"undefined";
					     var popup = L.popup().setContent('<table  class="ais-table">'+
					     '<tr>'+
                        '<td>mmsi:</td>'+
                        '<td>'+data[i].mmsi+'</td>'+
                        '<td>船舶IMO:</td>'+
                        '<td>'+data[i].imo+'</td></tr><tr>'+
                        '<td>经度：</td>'+
                        '<td>'+data[i].latitude+'</td>'+
                        '<td>船旗：</td>'+
                        '<td>'+data[i].country+'</td></tr>'+
                        '<td>吃水：</td>'+
                        '<td>'+data[i].draught+'</td>'+
                        '<td>船速：</td>'+
                        '<td>'+data[i].sog+'</td></tr><tr>'+
                        '<td>建造时间：</td>'+
                        '<td>'+data[i].built+'</td>'+
                        '<td>航行状态：</td>'+
                        '<td>'+data[i].state+'</td></tr><tr>'+
                        '<td>航首向/航迹向：</td>'+
                        '<td>'+data[i].truehead+'/'+data[i].course+'</td>'+
                        '<td>目的港：</td>'+
                        '<td>'+dest+'</td></tr>'+
                        '</table>'
                         ); 
                         var icon;
                         if(i%3==0)
                         {
                         	icon = boatIcon0;
                         }
                         if(i%3==1)
                         {
                         	icon=boatIcon1;
                         }
                         if(i%3==2)
                         {
                         	icon=boatIcon2;
                         }
                         /*var opacity =0;
                         if($("#boatmonitor").attr("checked")==="checked")
                         { 
                           opacity=1;
                         }*/
					     var m = L.marker(l,{icon:icon,opacity:1,angle:data[i].truehead%360}).addTo(map).bindPopup(popup);
					     //L.setOptions(m,{});
					      m.mmsi=data[i].mmsi;
					      map.setView(l);
					      m.openPopup();
					      group.addLayer(m);
					      m.on("contextmenu",function(e){  
                              var point =  map.latLngToContainerPoint(e.latlng);
							  L.DomUtil.setPosition($("#mapContextMenu").get(0),point);
							  $("#mapContextMenu").show();  
							 });				  
					  } 
		    	}
		    	 else{
		    		 alert("未找到船只！");
		    	 }
		     },
		     error:function()
		     {
		    	 alert("请求失败！");
		    	 var result = {"mmsi":"205420000","imo":"xxxx","callSign":"huhao","country":"chuanji","type":0,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":120.76,"latitude":33.62,"rot":0,
		    			 "sog":46,"truehead":511,"dest":"mudigang","length":0.0,"width":0.0,"posType":"0","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""};
		       if(result.length>0)
	    		 {
	    	 var l = L.latLng(result[0].latitude, result[0].longitude);
	    	 map.setView(l);
	    	 var popup = L.popup().setContent('<p>mmsi:'+result[0].mmsi+'<br />经度：'+result[0].latitude+'；纬度：'+result[0].longitude+'</p>'); 
		     var m = L.marker().setLatLng(l).bindPopup(popup).addTo(map);
		     m.openPopup();
		     m.mmsi=result[0].mmsi;
		     group.addLayer(m);
	    		 }
	    	 else{
	    		 alert("未找到船只！");
	    	 	}
		     }			  
			});
}


/***区域轨迹查询**/
function moreBoatSelect()
{
   if(map.getZoom()<10)
   {
   	alert("不支持当前缩放比例，请放大重试！");
   	return;
   }
	drawType.type = "areatrace";
	drawCircle.disable();
	drawRectangle.enable();
	drawMarker.disable();
}

/**区域轨迹查询**/
function areatraceBoat()
{
   if($("#areadatepickerStart").val().replace(/[ ]/g,"")==""){
	  $("#areadatepickerStart").css({"border-color":"red"});
	  return false;
	}
	else if($("#areadatepickerStop").val().replace(/[ ]/g,"")=="")
	{
	  $("#areadatepickerStop").css({"border-color":"red"});
	   return false;
	}

	$.ajax({
		 //url:ipAddress+"/fcgi-bin/AIS_Monitor", 
		 url:"areatrackfilter",
		 dataType:"json",
		 type:"post",
		 data:{
				        area:traceWindow.areaStr,
				       	startdt:Date.parse($("#areadatepickerStart").val().replace('-','/').replace('-','/')),
				       	enddt:Date.parse($("#areadatepickerStop").val().replace('-','/').replace('-','/')),
				       	compress:$("#areacompress").val()==""?10:$("#areacompress").val(),
				       	scale:map.getZoom()
			  },
		     success:function(data)
		     {
		     	delete traceWindow.areaStr;
		     	if(data)
		     	{
			     	if(data.status)
			     	{
			     		alert("未找到记录！");
			     	}
			     	else
			     	{
			     		 var trace = L.featureGroup().addTo(map);
			     		//处理数据
			     		for(var k in data)
                           {
                           	 

                           	  var latlngs=[];
           	            	  var len = data[k].length;
           	            	  var single = data[k];
					            	for(var i=0;i<len;i++)
						    		 {
						    		   var latlng = L.latLng(single[i].y, single[i].x);
						    		   var popup = L.popup().setContent('<p>时间:'+single[i].datetime+'<br />经度：'+single[i].x+'；纬度：'+single[i].y+'</p>')
						    		   var circle =  L.circleMarker(latlng,{color:"#FFFF44",weight:6,fill:"#FFFF44",opacity:1}).bindPopup(popup);
						    		   circle.setRadius(3).addTo(map);
						    		   trace.addLayer(circle);
						    		   latlngs.push(latlng);
						    		 }
						        	var polyline = L.polyline(latlngs, {color: 'red',weight:3,clickable:false,dashArray: '10, 10',lineCap:'round'}).addTo(map);
			    		            trace.addLayer(polyline);
                           }
                           traceWindow.layer.on("remove",function(){
                                  	map.removeLayer(trace); 
                           })
                            traceWindow.layer.on("add",function(){
                                  	map.addLayer(trace);      
                           })
    			     }
			    }
			    else
			    {
			    	alert("未找到记录！");
			    }
		    }
		    
		});
}
function sendMsg(msgtype)
{
	
	var url;
   switch(msgtype)
   {
     case "sixBoat" :url=ipAddressAndPort+"";break;
    
     case "sixteenBoat" :url="";break;
     case "tenBoat" :url="";break;
     case "fifteenBoat" :url="";break;
     case "sixSite" :url="";break;
     case "twelveSite" :url="../dataMsg/twelveSite";break;
     case "eightSite" :url="";break;
     case "forteenSite" :url="../dataMsg/forteenSite";break;
     case "tenSite" :url="";break;
     case "fifteenSite" :url="";break;
   }

  $.ajax({
     url:url,
     type:"post",
     dataType:"json",
     data:$("#sendMsgForm").serialize()+"&text="+$("#longText").val()+"&destinationID=11111&channel=3&messageIDIndex=1&broadcastBehaviour=0&binaryDataFlag=0&sentenceStatusFlag=R&repeatIndicator=0&sequenceNumber=0&retransmitFlag=0",
     success:function(result)
     {
     	if(result.code=-1)
     	{
     		alert(result.data);
     	}
     	alert(result.message);
     },
     error:function(result)
     {
     	
     }
   });
}

function sendBoatMsg(mmsi,msgtype,lat,lng)
{
	var minDistance = 1000000000000;
	var siteLayer;
        sitegroup.eachLayer(function (layer) {
		   var current = layer.getLatLng().distanceTo([lat,lng]);
		   if(current<minDistance)
		   {
               minDistance=current;
               siteLayer = layer;
		   }
		});
	console.log(siteLayer.mmsi,siteLayer.agreementId,mmsi);
	switch(msgtype)
    {	
     case "twelveBoat":url="../dataMsg/twelveBoat";break;
    }

	$.ajax({
     url:url,
     type:"post",
     dataType:"json",
     data:"idCode="+siteLayer.agreementId+"&destinationMMSI="+siteLayer.mmsi+"&sourceID="+mmsi+"&mmsi="+mmsi+"&text="+$("#longText").val()+"&destinationID=11111&channel=3&messageIDIndex=1&broadcastBehaviour=0&binaryDataFlag=0&sentenceStatusFlag=R&repeatIndicator=0&sequenceNumber=0&retransmitFlag=0",
     success:function(result)
     {
     	if(result.code=-1)
     	{
     		alert(result.data);
     	}
     	alert(result.message);
     },
     error:function(result)
     {
     	
     }
   });

}