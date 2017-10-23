<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	<head>
		<style>
       .tdLabel{
        text-align:left;
        width: 75px;
        padding-left: 8px!important;
     }
	   .smallForm input{
         height: 15px!important;
         width:100px!important;  
	  }
	  .smallForm select{
	  	width: 120px;
	  }
	  .contextMenu{
	  	position: absolute;
	  	background-color: white;
	  	width:120px;
	  	display: none;
	  	z-index: 1000;
	  }
	  .leaflet-draw-draw-trace{
	  	background-image: url("${root}/themes/map/images/trace.png")!important;
	  }
	  .leaflet-draw-draw-marker{
			 background-image: url("${root}/themes/map/images/virtualbackground.png")!important;
			 background-position:center!important;
			}
   .leaflet-draw-draw-channel{
	  	background-image: url("${root}/themes/map/images/channel.png")!important;
	  }
	</style>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">   
	</head>
	<body>
	<script type="text/javascript">
/*<![CDATA[*/
/******判断画图是进行什么操作******/
var drawType={};
var map;
/*************船只层***************/
var group;
/*************轨迹层***************/
var trace;
/*************船只查询层**************/
var searchBoatGroup;
/*************区域图标**************/
var areaIcon = new L.Icon({iconUrl:'${root}/themes/map/images/area.png',iconAnchor: [15, 12]});
/*************基站图标**************/
var siteIcon = new L.Icon({iconUrl:'${root}/themes/map/images/site.png',iconAnchor: [15, 12]});
var boatIcon1 = new L.Icon({iconUrl:'${root}/themes/map/images/boat2.png',iconAnchor: [10, 5]});
var boatIcon2 = new L.Icon({iconUrl:'${root}/themes/map/images/boat1.png',iconAnchor: [10, 5]});
var boatIcon0 = new L.Icon({iconUrl:'${root}/themes/map/images/boat.png',iconAnchor: [10, 5]});
/**************连线层*************/
//var siteAllGroup;
var boatControl;


var tracecontent = 
 '<div style="margin:0px;">'+
  '<form class="form-horizontal">'+
     '<div>'+
             '<div class="control-group">'+
                'mmsi:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
                    
                        '<input type="text" id="boatmmsi" />'+
                    
              '</div>'+
               '<div class="control-group">'+
                 '开始时间:'+
                   
                  '<input type="text" id="datepickerStart" onFocus="WdatePicker({startDate:\'%y-%M-01 00:00:00\',dateFmt:\'yyyy-MM-dd HH:mm:ss\',alwaysUseStartDate:true})"/>'+
                  
              '</div>'+
              '<div class="control-group">'+
                 '结束时间:'+
                    
                    '<input type="text" id="datepickerStop"  onFocus="WdatePicker({startDate:\'%y-%M-01 00:00:00\',dateFmt:\'yyyy-MM-dd HH:mm:ss\',alwaysUseStartDate:true})"/>'+
              
              '</div>'+
              '<div class="control-group">'+
                 '压缩:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
                   
                    '<input type="text" id="compress" style="width:25px;"/>(填写整数)'+
                
              '</div>'+
              '<div class="control-group"  style="text-align:center;">'+
                   
                     '<input id="traceButton" class="btn blue" type="button" value="轨迹查询" onclick="traceBoat()"/>&nbsp;&nbsp;&nbsp;&nbsp;'+
                     '<input id="traceClear"  class="btn blue" type="reset" value="重置" />'+        
                     
                   '</div>'+
                  '</div></form>'+
              '</div>';
var traceWindow= $.dialog({content:tracecontent,max:false,top:"22%",left:"93%",title: '轨迹查询',close: function () {
        this.hide();
        return false;
    }
});
traceWindow.hide();
var areaWindow= $.dialog({content:'<div id="aisBoatcontent"></div>',
resize:true,max:false,title: '船只',close: function () {
        this.hide();
        return false;
    }
});
areaWindow.hide();
var contextMenuBoatWindow = $.dialog({content:"",max:false,title: '发消息',close: function () {
        this.hide();
        return false;
    }
});
contextMenuBoatWindow.hide();

var channelManagementContent = '<table>'+
'<tr><td class="tdLabel">NE经度:</td><td class="smallForm"><input type="text" id="channelManagementNElng" /></td>'+
'<td class="tdLabel">NE纬度:</td><td class="smallForm"><input type="text" name="channelManagementNElat" id="channelManagementNElat" /></td></tr>'+
'<tr>'+
'<td class="tdLabel">SW经度:</td><td class="smallForm"><input type="text" id="channelManagementSWlng" /></td>'+
'<td class="tdLabel">SW纬度:</td><td class="smallForm"><input type="text" id="channelManagementSWlat" /></td></tr></table>'+
'<form id="channelManagementContent"><table><tr><td class="tdLabel">信道A:</td><td class="smallForm"><input type="text" id=",,," /></td>'+
'<td class="tdLabel">信道B:</td><td class="smallForm"><input type="text" id="channelB" /></td></tr>'+
'<td class="tdLabel">过滤区尺寸:</td><td class="smallForm"><input type="number" id="tzoneSize" /></td>'+
'<td class="tdLabel">Tx/Rx 模式</td><td class="smallForm"><select id="virtualType">'+
'<option value="TxA/TxB,RxA/RxB">TxA/TxB,Rx/RxB</option>'+'<option value=TxA,RxA/RxB>TxA,RxA/RxB</option>'+
'<option value=TxB,RxA/RxB>TxB,RxA/RxB</option>'+	    
'</select></td></tr>'+
'<tr>'+
'<td class="tdLabel">高功率</td><td class="smallForm"><input type="checkbox" id="highPower" /></td></tr>'+
'<tr><td></td><td><input class="btn blue" type="button" id="virtualsub" value="发送" onclick="saveChanelManager();" /></td><td></td><td><input class="btn blue" type="reset" value="重置" /></td></tr>'+
'</table></form>';
var channelMangerWindow = $.dialog({content:channelManagementContent,max:false,title: '信道管理',close: function () {
        this.hide();
        return false;
    }
});
channelMangerWindow.hide();

var virtualSaleContent='<div id="virtualSaleContent">'+
'<div >mmsi：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="virtualMmsi" /></div>'+
'<div >虚拟标名称：<input type="text" id="virtualSaleName" /></div>'+
'<div >类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：<select id="virtualType">'+
 '<option value=0>0-(not defined)</option>'+'<option value=1>1-(reference point)</option>'+
 '<option value=2>2-(RACON)</option>'+'<option value=3>3-(structure of shore)</option>'+
 '<option value=4>4-(spare)</option>'+'<option value=5>5-(light with out sector)</option>'+			    
 '</select></div>'+
'<div >经&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度：<input type="text" id="virtuallng" /></div>'+
'<div >经&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度：<input type="text" id="virtuallat" /></div>'+
'<div style="text-align:center"><input class="btn blue" type="button" id="virtualsub" value="保存" onclick="saveVirtualSalw();" /></div>'+
'</div>';

var virtualSaleWindow = $.dialog({content:virtualSaleContent,max:false,top:"32%",left:"40%",title: '虚拟航标',close: function () {
this.hide();
return false;
}
});
virtualSaleWindow.hide();
window.onload=function(){


/**********导入ais-table********/
$("#aisBoatcontent").load("${root}/siteinfo/aistable");
/********设置ajax无缓存*******/	
$.ajaxSetup({ cache: false }); 

$("#search").blur(function(){
  
   	  $("#search").css({"border-color":"#ccc"});
  
});

$("#boatmmsi").blur(function(){
	if($("#boatmmsi").val().replace(/[ ]/g,"")!=="")
	{
  		$("#boatmmsi").css({"border-color":"#ccc"});
  	}  
});
$("#datepickerStart").blur(function(){
	if($("#datepickerStart").val().replace(/[ ]/g,"")!=="")
	{
  		$("#datepickerStart").css({"border-color":"#ccc"});
  	}  
});
$("#datepickerStop").blur(function(){
	if($("#datepickerStop").val().replace(/[ ]/g,"")!=="")
	{
  		$("#datepickerStop").css({"border-color":"#ccc"});
  	}  
});    	 				 	
			
/***********************加载地图**************************/				
		var url = "http://114.251.210.32/MapService?format=image/png";
		var ogs = new L.tileLayer.OS(url ,
		                               {layer:"default",
		                                  style: "default",
		                                  tilematrixSet: "advsea"
			                              });
		var basicogs = new L.tileLayer.OS(url ,
		                               {layer:"default",
		                                  style: "default",
		                                  tilematrixSet: "basicsearoad"
			                              });
		var advogs = new L.tileLayer.OS(url ,
		                               {layer:"default",
		                                  style: "default",
		                                  tilematrixSet: "advsearoad"
			                              });
		var baseLayers = {
			        "标准海图": ogs,
				    "基础海陆混合": basicogs,
				    "高级海陆混合":advogs
				};
		
		var center = L.latLng(32.509761735919426, 126.7022265625);
		map = L.map('map',{zoomAnimation:true,fullscreenControl: true,minZoom:3,maxZoom:18,inertiaDeceleration:5000,fadeAnimation:true,markerZoomAnimation:true,inertiaThreshold:5000});
		L.control.layers(baseLayers).addTo(map);
		L.control.scale({'position':'bottomleft','metric':true,'imperial':false}).addTo(map);
		
		
		//map.setMaxBounds([[54.67383, 67.58789],[16.64625, 139.57031]]);
		//map.setView([32.89761785919426, 126.7822265625],5);
		
		/************画图工具初始化*****/
		measureDistance = new L.DrawPolyline(map,{closeButton:"<img src='../themes/map/images/delete.png'/>"});
		drawCircle = new L.Draw.Circle(map);
		drawRectangle = new L.Draw.Rectangle(map);
		drawMarker = new L.Draw.Marker(map,{icon:L.icon({
			    iconUrl: "${root}/themes/map/images/virtualreal.png",iconSize: [25, 25],
			    iconAnchor: [15, 30],
			    })});
		group = L.featureGroup().addTo(map);
		gridgroupsmall = L.featureGroup();
		gridgroupbig = L.featureGroup();
		gridgroupmiddle = L.featureGroup();
        map.addLayer(basicogs); 
		/*****网格化****/
		mapgridInit();
		setInterval("mapgridInit()",1800000);
		map.on("zoomend",function(e){
           if(map.getZoom()<5)
           {
           	gridgroupbig.addTo(map);
           	map.removeLayer(gridgroupmiddle);
            map.removeLayer(gridgroupsmall);
           }
           else if(map.getZoom()<7)
           {
             gridgroupmiddle.addTo(map);
             map.removeLayer(gridgroupsmall);
             map.removeLayer(gridgroupbig);
           }
           else if(map.getZoom()<9)
           {
           	gridgroupsmall.addTo(map);
           	console.log(gridgroupsmall);
           	map.removeLayer(gridgroupbig);
           	map.removeLayer(gridgroupmiddle);
           }
		});
		map.setView(center,5);
		sitegroup = L.featureGroup().addTo(map);
		//siteAllGroup =  L.featureGroup().setStyle({opacity:0}).addTo(map);
		boatControl = L.control.layers(group);
		searchBoatGroup = L.featureGroup().addTo(map);
		drawnItems = L.featureGroup().addTo(map);
		drawDelete = new L.EditToolbar.Delete(map,{featureGroup:drawnItems});
		checkdisable();
		/*map.addControl(new L.Control.Draw({
			edit: { featureGroup: drawnItems },
			draw:{rectangle:{},marker:{icon:L.icon({
			    iconUrl: "${root}/themes/map/images/virtualreal.png",iconSize: [25, 25],
			    iconAnchor: [15, 30],
			    })}}
		}));
		*/
		/***********************加载基站**************************/	
		$.ajax({
						 url:"${root}/siteinfo/webService/getSiteInfo",
						 dataType:"json",
					     success:function(result)
					     {
					    	 if(result.length<1)
					    		 {
					    		   //alert("加载基站信息失败，请检查连接！");
					    		   return;
					    		 }
					     $("#siteSend").load("sitesendinfo");
					    	for(var i=0;i<result.length;i++)
					     		{
							       var apopup =  L.popup().setContent(result[i].jurisdictionName); 
							       var areaLalng = L.latLng(result[i].jurisdictionLat,result[i].jurisdictionLon);
							       var area = L.marker(areaLalng,{icon: areaIcon}).bindPopup(apopup).addTo(map);
							       area.sites=[];
									       if(result[i].listSites.length>0)
									       {
									                  
												       for(var j=0;j<result[i].listSites.length;j++)
												       {
												                   
																   
															       var siteLalng = L.latLng(result[i].listSites[j].siteLat,result[i].listSites[j].siteLon);
															       var spopup =  L.popup(siteLalng).setContent("mmsi:"+result[i].listSites[j].mmsi+"<br>"+result[i].listSites[j].sitename);
															       var site = L.marker(siteLalng,{icon:siteIcon,title:result[i].listSites[j].sitename}).bindPopup(spopup);
															       site.sitename = result[i].listSites[j].sitename;
															       site.agreementId = result[i].listSites[j].agreementId;
                                                                   site.mmsi = result[i].listSites[j].mmsi;
															       site.addTo(map);
															                                                                             
															       site.on("contextmenu",function(e){
													                contextMenuBoatWindow.mmsi = this.mmsi;
													                 contextMenuBoatWindow.agreementId = this.agreementId;
															    	var point =  map.latLngToContainerPoint(e.latlng);
															        L.DomUtil.setPosition($("#siteContextMenu").get(0),point);
																		$("#siteContextMenu").show();  
																		contextMenuBoatWindow.type=1;
																		 														       	 
															       }); 
															       //area.sites.push(site);
															       sitegroup.addLayer(site);
												       } 
									      		 //sitegroup.addLayer(area);   
									      	}
					     		}
					     }
				});		
/***************单击地图隐藏右键菜单**********************/
map.on("click",function(e){
   //alert(e.latlng.lng+"-"+e.latlng.lat);
  $("#mapContextMenu").hide();
  $("#siteContextMenu").hide();
});
map.on("zoomstart",function(){
  $("#siteContextMenu").hide();
  $("#mapContextMenu").hide();
});
map.on("movestart",function(){
  $("#siteContextMenu").hide();
  $("#mapContextMenu").hide();
});
/***********************测试数据**************************/
/*group.clearLayers();
			    	var ships = [{"mmsi":"205420000","imo":"xxxx","callSign":"huhao","country":"chuanji","type":0,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":120.76,"latitude":33.62,"rot":0,
"sog":46,"truehead":51,"dest":"mudigang","length":0.0,"width":0.0,"posType":"0","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"205420001","imo":"xxxx","callSign":"huhao","country":"chuanji","type":1,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":121.76,"latitude":35.02,"rot":0,
"sog":46,"truehead":81,"dest":"mudigang","length":0.0,"width":0.0,"posType":"0","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"205420002","imo":"xxxx","callSign":"huhao","country":"chuanji","type":2,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":121.96,"latitude":32.92,"rot":0,
"sog":46,"truehead":121,"dest":"mudigang","length":0.0,"width":0.0,"posType":"0","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"205420003","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":122.26,"latitude":32.32,"rot":0,
"sog":46,"truehead":221,"dest":"mudigang","length":0.0,"width":0.0,"posType":"0","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"205420004","imo":"xxxx","callSign":"huhao","country":"chuanji","type":2,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":123.76,"latitude":28.02,"rot":0,
"sog":46,"truehead":33,"dest":"mudigang","length":0.0,"width":0.0,"posType":"0","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"205420006","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":130.8252,"latitude":36.66842,"rot":0,
"sog":46,"truehead":51,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"205420007","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":125.26,"latitude":29.82,"rot":0,
"sog":46,"truehead":211,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},{"mmsi":"205420005","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":131.83594,"latitude":40.71396,"rot":0,
"sog":46,"truehead":821,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"205420008","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":131.87988,"latitude":30.14513,"rot":0,
"sog":46,"truehead":211,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},{"mmsi":"205420005","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":131.83594,"latitude":40.71396,"rot":0,
"sog":46,"truehead":81,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"2054200012","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":115.09277,"latitude":18.89589,"rot":0,
"sog":46,"truehead":211,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},{"mmsi":"205420005","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":131.83594,"latitude":40.71396,"rot":0,
"sog":46,"truehead":81,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"2054200014","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":128.9794,"latitude":22.55315,"rot":0,
"sog":46,"truehead":211,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},{"mmsi":"205420005","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":131.83594,"latitude":40.71396,"rot":0,
"sog":46,"truehead":81,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},
{"mmsi":"2054200016","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":119.79492,"latitude":39.02772,"rot":0,
"sog":46,"truehead":211,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""},{"mmsi":"205420005","imo":"xxxx","callSign":"huhao","country":"chuanji","type":3,"shipName":"xxxx","state":"","dwt":0,"built":"2010-05-03","longitude":131.83594,"latitude":40.71396,"rot":0,
"sog":46,"truehead":81,"dest":"mudigang","length":0.0,"width":0.0,"posType":"5","eta":"","draught":0.0,"cog":1502,"receiveTime":"1325341649827","port":"chuanjigang","course":""}]
;
			        	for(var i=0;i<ships.length;i++)
					  {
					     var l = L.latLng(ships[i].latitude, ships[i].longitude);
					     var popup = L.popup().setContent('<table id="ais-table" class="ais-table">'+
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
					     var m = L.marker(l,{icon:icon,opacity:0,angle:ships[i].truehead%360}).bindPopup(popup).addTo(map);
					     //L.setOptions(m,{});
					      m.mmsi=ships[i].mmsi;
					     group.addLayer(m);
					  }*/
/********************测试数据************************/
/*$(".leaflet-draw-draw-marker").after('<a class="leaflet-draw-draw-trace" href="javascript:void(0)" onclick="traceFormWindow();" title="轨迹"></a>');*/

$(".leaflet-draw-draw-rectangle").click(function(){
	drawType.type = "sixMsgBroad";
});	
$(".leaflet-draw-draw-circle").click(function(){
	
	drawType.type = "sixMsgBroad";
});	
$(".leaflet-draw-draw-trace").after('<a class="leaflet-draw-draw-channel" href="javascript:void(0)" onclick="channelManagementClick();" title="信道管理"></a>');

       map.on('draw:created', function(event) {
			var layer = event.layer;
			drawnItems.addLayer(layer);
			checkdisable();
			var url;
			if(drawType.type=="channelManagement" && event.layerType=="rectangle")
			{
				$("#channelManagementNElng").val(lngLatTo(layer.getBounds().getEast()));
				$("#channelManagementNElat").val(lngLatTo(layer.getBounds().getNorth()));
				$("#channelManagementSWlng").val(lngLatTo(layer.getBounds().getWest()));
				$("#channelManagementSWlat").val(lngLatTo(layer.getBounds().getSouth()));
				$("#channelManagementContent").get(0).reset();
                 channelMangerWindow.layer = layer;
                 channelMangerWindow.show();
			}
			if(drawType.type=="areatrace" && event.layerType=="rectangle")
				{
					var bounds = event.layer.getBounds();
					var west = bounds.getWest();
					var south = bounds.getSouth();
					var east = bounds.getEast();
					var north = bounds.getNorth();
					
                    var areacontent = 
					 '<div style="margin:0px;">'+
					  '<form class="form-horizontal">'+
					     '<div>'+
					               '<div class="control-group">'+
					                 '开始时间:'+
					                   
					                  '<input type="text" id="areadatepickerStart" onFocus="WdatePicker({startDate:\'%y-%M-01 00:00:00\',dateFmt:\'yyyy-MM-dd HH:mm:ss\',alwaysUseStartDate:true})"/>'+
					                  
					              '</div>'+
					              '<div class="control-group">'+
					                 '结束时间:'+
					                    
					                    '<input type="text" id="areadatepickerStop"  onFocus="WdatePicker({startDate:\'%y-%M-01 00:00:00\',dateFmt:\'yyyy-MM-dd HH:mm:ss\',alwaysUseStartDate:true})"/>'+
					              
					              '</div>'+
					              '<div class="control-group">'+
					                 '压缩:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
					                   
					                    '<input type="text" id="areacompress" style="width:25px;"/>(填写整数)'+
					                
					              '</div>'+
					              '<div class="control-group"  style="text-align:center;">'+
					                   
					                     '<input id="areatraceButton" class="btn blue" type="button" value="轨迹查询" onclick="areatraceBoat()"/>&nbsp;&nbsp;&nbsp;&nbsp;'+
					                     '<input id="areatraceClear"  class="btn blue" type="reset" value="重置" />'+        
					                     
					                   '</div>'+
					                  '</div></form>'+
					            '</div>';
                     traceWindow.content(areacontent);
                     traceWindow.show();
                     traceWindow.layer = event.layer;
                     traceWindow.areaStr = west.toFixed(4)+","+south.toFixed(4)+"|"+west.toFixed(4)+","+north.toFixed(4)+"|"+east.toFixed(4)+","+north.toFixed(4)+"|"+east.toFixed(4)+","+south.toFixed(4)+"|"+ west.toFixed(4)+","+south.toFixed(4);
			   }
			if(drawType.type=="areaBroadCast")
			{
				if(event.layerType=="rectangle")
				{
					var bounds = event.layer.getBounds();
					var west = bounds.getWest();
					var south = bounds.getSouth();
					var east = bounds.getEast();
					var north = bounds.getNorth();
					url = "${dftIpAddress}/fcgi-bin/AIS_Monitor?cmd=0x5109&seq=1&lb="+west+","+south+"&rt="+east+","+north+"&circle="; 
				}
				else if(event.layerType=="circle")
				{
				   var f = event.layer.getRadius()/1000/1.852;
				   var l = event.layer.getLatLng(); 
				   url = "${dftIpAddress}/fcgi-bin/AIS_Monitor?cmd=0x5109&seq=1&lb=&rt=&circle="+l.lng+","+l.lat+","+f;   
				}	
	            $.ajax({
					 url:url,
					 dataType:"jsonp",
				     success:function(data)
					     {
					     	showBoatWindow(drawType.num);
					     	content='<form><textarea></textarea>'+
	       						'<div class="middle"><input type="button" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div></form>';
					    	 //areaWindow.show();
					    	 var table = $("#boat-table").get(0);
							$(table).empty();
							  /*for ( var i = 0; i < data.length; i++)
							       {
							           var tr = table.insertRow (table.rows.length);
							           var obj = data[i];
							           var k=0;
							           for ( var j in obj)
							           {
							               var td = tr.insertCell (tr.cells.length);
							               $(td).text(obj[j]);
							               k++;
							               if(k>7)
							               break;
							           }
							       }
	                          for ( var i = 0; i < data.length; i++)
							       {
							           var tr = table.insertRow (table.rows.length);
							           var obj = data[i];
							           var k=0;
							           for ( var j=0;j<9;j++)
							           {
							               var td = tr.insertCell (tr.cells.length);
							               switch (j)
							               {
							               	 case 0: $(td).text(obj.mmsi);break;
							               	 case 1: $(td).text(obj.imo);break;
							               	 case 2: $(td).text(obj.callSign);break;
							               	 case 3: $(td).text(obj.country);break;
							               	 case 4: $(td).text(obj.type);break;
							               	 case 5: $(td).text(obj.shipName);break;
							               	 case 6: $(td).text(obj.state);break;
							               	 case 7: $(td).text(obj.dwt);break;
							               }
							           }
							       } */
					     	  }
						 });	 
					}
			if(event.layerType=="marker")
			{
			  	
			  /*virtualSaleWindow.layer=event.layer;  */
			  
              $("#virtuallng").val(lngLatTo(event.layer.getLatLng().lng));
              $("#virtuallat").val(lngLatTo(event.layer.getLatLng().lat));
              $("#virtualSaleName").val(event.layer.name);
			  virtualSaleWindow.show();
			  //layer.dragging.enable();
			  layer.on("drag",function(event){
              $("#virtuallng").val(lngLatTo(this.getLatLng().lng));
              $("#virtuallat").val(lngLatTo(this.getLatLng().lat));
			  });
			  return;
			}
			else {
				return;
			}
            
              
			});
      map.on("draw:deleted",checkdisable);
		
/*****************移动图层加载图层内的船只信息******************/
      
		map.on('moveend',function(event){
		
		if(map.getZoom()<12)
			    { 	group.clearLayers();	
                    return;   
			    }

         map.removeLayer(gridgroupsmall);
         var bounds = this.getBounds();
		var west = bounds.getWest();
		var south = bounds.getSouth();
		var east = bounds.getEast();
		var north = bounds.getNorth();
		$.ajax({
				 url:"${dftIpAddress}/fcgi-bin/AIS_Monitor",
				 dataType:"jsonp",
				 data:{
						        //cmd:"0x010N",
						        cmd:"0x5109",
						        seq:5,
						        lb:west+","+south,
						        rt:east+","+north,
						        circle:"",
						        shore:0
					  },
			     success:function(data)
			     {
			     	group.clearLayers();
			          	for(var i=0;i<data.length;i=i+1)
					  {
					     var l = L.latLng(data[i].latitude, data[i].longitude);
					     var re = new RegExp("@","g"); 
					     var dest = data[i].dest?data[i].dest.replace(re,''):"";
					     var popup = L.popup().setContent('<table  class="ais-table">'+
					     '<tr>'+
                        '<td>mmsi:</td>'+
                        '<td>'+data[i].mmsi?data[i].mmsi:""+'</td>'+
                        '<td>船舶IMO:</td>'+
                        '<td>'+data[i].imo?data[i].imo:""+'</td></tr><tr>'+
                        '<td>经度：</td>'+
                        '<td>'+data[i].longitude?data[i].longitude:""+'</td>'+
                        '<td>纬度：</td>'+
                        '<td>'+data[i].latitude?data[i].latitude:""+'</td></tr><tr>'+
                        '<td>船旗：</td>'+
                        '<td>'+data[i].country?data[i].country:""+'</td>'+
                        '<td>吃水：</td>'+
                        '<td>'+data[i].draught?data[i].draught:""+'</td></tr><tr>'+
                        '<td>船名：</td>'+
                        '<td>'+data[i].shipName?data[i].shipName:""+'</td>'+
                        '<td>船速：</td>'+
                        '<td>'+data[i].sog?data[i].sog/10:""+'节</td></tr><tr>'+
                        '<td>建造时间：</td>'+
                        '<td>'+data[i].built?data[i].built:""+'</td>'+
                        '<td>航行状态：</td>'+
                        '<td>'+data[i].state?data[i].state:""+'</td></tr><tr>'+
                        '<td>航首向/航迹向：</td>'+
                        '<td>'+data[i].truehead?data[i].truehead:""+'/'+data[i].course?data[i].course:""+'</td>'+
                        '<td>目的港：</td>'+
                        '<td>'+dest+'</td></tr>'+
                        '</table>'
                         ); 
                         var icon;
                         if(data[i].type==0)
                         {
                         	icon = boatIcon0;
                         }
                         if(data[i].type<71 && data[i].type>0)
                         {
                         	icon=boatIcon1;
                         }
                         if(data[i].type>=71)
                         {
                         	icon=boatIcon2;
                         }
                        
					     var m = L.marker(l,{icon:icon,opacity:1,angle:data[i].truehead%360}).bindPopup(popup);
					     //L.setOptions(m,{});
					      m.mmsi=data[i].mmsi+"";
					     group.addLayer(m);	
					      m.on("contextmenu",function(e){ 
                              var point =  map.latLngToContainerPoint(e.latlng);
							  L.DomUtil.setPosition($("#mapContextMenu").get(0),point);
							  $("#mapContextMenu").show();  
							  contextMenuBoatWindow.mmsi = this.mmsi+"";
							  contextMenuBoatWindow.type=0;
							  contextMenuBoatWindow.latlng = l;
							 });				  
					  } 
			     },
			     error:function()
			     {
			     alert("请求数据失败，请检查数据库服务器！显示模拟数据！"); 
			     }
				});
		});
			//map.setView([32.89761785919426, 126.7822265625],5);
			
/********************移动图层加载图层内的船只信息****************/
        

		/*
		var bounds = map.getBounds();
		
		//var west = bounds.getWest(); 
		var west = 93.8671875;
		//var south = bounds.getSouth();
		var south = 0.7031073524364909;
		//var east = bounds.getEast();
		var east = 147.65625;
		//var north = bounds.getNorth()
		var north = 52.696361078274485;
		$.ajax({
				 url:"${dftIpAddress}/fcgi-bin/AIS_Monitor",
				 dataType:"jsonp",
				 data:{
						        //cmd:"0x010N",
						        cmd:"0x5109",
						        seq:5,
						        lb:west+","+south,
						        rt:east+","+north,
						        circle:"",
						        shore:0
					  },
			     success:function(data)
			     {
			          
			    	//var step = data.length>200? parseInt(data.length/200):1;
			    	   	for(var i=0;i<data.length;i=i+1)
					  {
					     var l = L.latLng(data[i].latitude, data[i].longitude);
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
                        
					     var m = L.marker(l,{icon:icon,opacity:1,angle:data[i].truehead%360}).bindPopup(popup);
					     //L.setOptions(m,{});
					      m.mmsi=data[i].mmsi;
					      markerList.push(m);
					      markers.addLayer(m);	
					      m.on("contextmenu",function(e){  
                              var point =  map.latLngToContainerPoint(e.latlng);
							  L.DomUtil.setPosition($("#mapContextMenu").get(0),point);
							  $("#mapContextMenu").show();  
							 });				  
					  } 
			     },
			     error:function()
			     {
			     alert("请求数据失败，请检查数据库服务器！显示模拟数据！"); 
			     }
				});
       
        markers.addTo(map);*/
}
/*]]>*/
</script> 
<input type="hidden" id="dftIpAddress" value="${dftIpAddress}">



<div id="mapContainer">
<div id='map'>	
	<div id="toolBar" style="position:absolute;left: 12%;top: 10px;z-index: 1000;">
	     <nav class="navbar navbar-default">
           <div class="container-fluid">   
            <ul class="nav navbar-nav">
              <li><form class="form-inline">
	      		<div class="form-group"><input type="text" id="search" placeholder='请输入mmsi'/>
	      			<button class="btn default" type="button" onclick="searchAisBoat()">查询</button>
	     		</div>
	 		  </form></li>
	 		  <li><a href="javascript:void(0)" onclick="measureDistanceClick();">测距</a></li>
	 		  <li class="dropdown">
	 		  	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">轨迹查询<span class="caret"></span></a>
	 		     <ul class="dropdown-menu" role="menu">
		 		    <li><a href="javascript:void(0)" onclick="traceFormWindow();">单船查询</a></li>
		 		    <li><a href="javascript:void(0)" onclick="moreBoatSelect();">区域查询</a></li>
	 		     </ul>
	 		  <li>
	 		  <li><a href="javascript:void(0)" onclick="virtualClick();">虚拟标</a></li>
              <li><a href="javascript:void(0)" onclick="channelManagementClick()">信道管理</a></li>
              <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">区域广播<span class="caret"></span></a>
                  <ul class="dropdown-menu" role="menu">
            		<li><a href="javascript:void(0);" onclick="areaBroadCast('sixBoat');" >寻址二进制</a></li>
            		<li><a href="javascript:void(0);" onclick="areaBroadCast('twelveBoat');">寻址安全</a></li>
            		<li><a href="javascript:void(0);" onclick="areaBroadCast('sixteenBoat');">指配模式</a></li>
            		<li><a href="javascript:void(0);" onclick="areaBroadCast('tenBoat');">UTC时间</a></li>
            		<li><a href="javascript:void(0);" onclick="areaBroadCast('fifteenBoat');">轮询</a></li>
          		  </ul>
        	  </li>
        	  <li><a href="javascript:void(0)" onclick="deleteLayer();">删除图层</a></li>
        	  <li class="deleteSave"><a href="javascript:void(0)"  onclick="saveLayer();">[保存</a></li>
        	  <li  class="deleteSave"><a href="javascript:void(0)" onclick="cancelLayer();">取消]</a></li>
      		</ul>
      	   </div>
      	</nav>
    </div>
	
	          <div id="mapContextMenu" class="contextMenu">
	     	         <div class="hiddenMenu"><div  onclick="showBoatWindow('sixBoat')">寻址二进制</div></div> 
			         <div class="hiddenMenu"><div  onclick="showBoatWindow('twelveBoat')">寻址安全消息</div></div>
			         <div class="hiddenMenu"><div  onclick="showBoatWindow('sixteenBoat')">指配模式命令</div></div> 
			         <div class="hiddenMenu"><div  onclick="showBoatWindow('tenBoat')">UTC/日期询问</div></div>  
			         <div class="hiddenMenu"><div  onclick="showBoatWindow('fifteenBoat')">询问</div></div>
	          </div>
			  <div id="siteContextMenu" class="contextMenu">
				           <div class="hiddenMenu"><div id="sixSite" onclick="showBoatWindow('sixSite')">寻址二进制</div></div>
				           <div class="hiddenMenu"><div id="twelveSite" onclick="showBoatWindow('twelveSite')">寻址安全消息</div></div>
					 	   <div class="hiddenMenu"><div id="eightSite" onclick="showBoatWindow('eightSite')">二进制广播</div></div>
						   <div class="hiddenMenu"><div id="forteenSite" onclick="showBoatWindow('forteenSite')">安全广播消息</div></div>
						   <div class="hiddenMenu"><div id="tenSite" onclick="showBoatWindow('tenSite')">UTC/日期询问</div></div>
						   <div class="hiddenMenu"><div id="fifteenSite" onclick="showBoatWindow('fifteenSite')">询问</div></div>
			  </div>
	</div>
	<div id="progress"><div id="progress-bar"></div></div>
</div>
		<style>
		  	#map {
				  	margin: 0;
					padding: 0;
					width: 100%;
					height: 766px;
				    }
			.validate
			{
			 border-style:solid;
			 border-width:1px;
			 border-color:red;
			}
			.leaflet-control{
				border-radius:5px!important;
			}
			.leaflet-control-layers-selector{
				margin-top: 2px!important;
				position: relative!important;
				top: 1px!important;
                margin:2px!important;
			}				
       </style>
    </html>