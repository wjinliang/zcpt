<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	<style type="text/css">
	  #virtualSaleContent input[type="text"] select{
         height: 15px!important;
         width:150px!important;
	  }
	</style>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	</head>
	<body>
	<script type="text/javascript">
/*<![CDATA[*/
var map;

var siteRangeCircle=[];
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
var lineGroup;
var boatControl;

/**************数据ip地址***********/
var lineWindowContent="<table id='lineConnState' class='ais-table'>"+
															        	     "<tr><td>使用率：</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>连接状态：</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>总流量:</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>设备1：</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>设备2：</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>端口1:</td><td></td></tr>"+
															       	         "<tr><td>端口2：</td><td></td></tr>"+
					 "</table>";
var lineWindow = $.dialog({content:lineWindowContent,max:false,title: '连接',close: function () {
        this.hide();
        return false;
    }
});
lineWindow.hide();

var sitecontent =      '<div>'+
			'查询内容:<select id="selectSiteInfo">'+
			      '<option value=0>请选择……</option>'+
				  '<option value=1>时隙占用率查询</option>'+
				  '<option value=2>相对信噪比查询</option>'+
				  '<option value=3>AIS目标数查询</option>'+
				  '<option value=4>AIS作用距离查询</option>'+
				  '<option value=5>AIS报警查询</option>'+
				  '<option value=6>AIS VSI息信查询</option>'+
				  '<option value=7>基站过滤情况</option>'+
				  '<option value=8>查询基站覆盖率</option>'+
				  '<option value=9>基站过滤报文类型数</option>'+
				  '<option value=10>ADS-AIS设备查询</option>'+
			 '</select>'+
			 '<div  id= "siteInfoSelect" style="margin-top: 15px;"></div>'+
		'</div>';
var siteWindow= $.dialog({content:sitecontent,top:"8%",left:"93.5%",max:false,title: '基站查询',close: function () {
        this.hide();
        return false;
    }
});
siteWindow.hide();

$("#aisBoatcontent").load("${root}/siteinfo/aistable");
var siteSelectWindow= $.dialog({content:'<div class="ais-panel"><div id="ais-table"><div id="siteSelectcontent" class="ais-tp"></div></div></div>',max:false,resize:true,title: '基站',close: function () {
        this.hide();
        return false;
    }
});
siteSelectWindow.hide();
 var content = "<table id='siteBasicInfo' class='ais-table'><tr><td>基站名称:</td><td></td></tr>"+
															        	    "<tr><td>基站经/纬度：</td><td></td></tr><tr><td>A信道时隙占用率:</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>B信道时隙占用率</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>A信道信噪比:</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>B信道信噪比</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>虚拟航标数:</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>AIS航标:</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>A类船数:</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>B类船数:</td>"+
															       	         "<td></td></tr>"+
															       	         "<tr><td>作用距离:</td>"+
															       	         "<td><span></span><input type='checkbox' id='siterangecircle' />(显示)</td></tr>"+
															       	         "<tr id='sitebasicratio'><td>重复基站:</td><td>重复率:</td></tr>"+
															       	         "</table>";
var siteBasicInfoWindow= $.dialog({content:content,max:false,resize:true,top:"75%",left:"85%",title: '基站',close: function () {
        this.hide();
        return false;
    }
});
siteBasicInfoWindow.hide();
var contextMenuBoatWindow = $.dialog({content:"",max:false,title: '发消息',close: function () {
    this.hide();
    return false;
}
});
contextMenuBoatWindow.hide();

/*基站定时监控*/
function siteLoad()
{
	console.log("siteinfo…………");
$.ajax({
						 url:"./htLoad",
						 dataType:"json",
					     success:function(result)
					     {
					     	//console.log(result);
					    //var result = data.siteInfos;
					     lineGroup.clearLayers();
					     sitegroup.clearLayers();
					     $("#siteSend").load("sitesendinfo");
					    	for(var i=0;i<result.length;i++)
					     		{
							       var apopup =  L.popup().setContent(result[i].jurisdictionName); 
							       var areaLalng = L.latLng(result[i].jurisdictionLat,result[i].jurisdictionLon);
							       var area = L.marker(areaLalng,{icon: areaIcon}).bindPopup(apopup).addTo(map);
							       area.jurl = result[i].jurl;
							       area.on("click",function(){
							       	  window.open(this.jurl);
							       });
							       area.sites=[];
									       if(result[i].listSites.length>0)
									       {
									                  
												       for(var j=0;j<result[i].listSites.length;j++)
												       {
															       var siteLalng = L.latLng(result[i].listSites[j].siteLat,result[i].listSites[j].siteLon);
															       var spopup =  L.popup(siteLalng).setContent(result[i].listSites[j].sitename);
															       var site = L.marker(siteLalng,{icon:siteIcon,title:result[i].listSites[j].sitename}).bindPopup(spopup);
                                                                   if(result[i].listSites[j].sitestate!="1")
                                                                   {
                                                                   
                                                                   	  var errorIcon =  new L.Icon({iconUrl:'${root}/themes/map/images/error.png',iconAnchor: [1, 3]});
                                                                   	  var siteError = L.marker(siteLalng,{icon:errorIcon});
                                                                   	   sitegroup.addLayer(siteError);
                                                                   }
															       
															       
															       site.sitename = result[i].listSites[j].sitename;
															       site.sitestate = result[i].listSites[j].sitestate;
															       site.agreementId = result[i].listSites[j].agreementId;
                                                                   site.url = result[i].listSites[j].url;
                                                                   sitegroup.addLayer(site);
															       site.on("click",function(event){															       	
															       	var latlng = this.getLatLng();
									                               var agreementId = this.agreementId;
															        var siteinfo = this;
                                                                    $("#siterangecircle").off("change");

															        if(map.hasLayer(siteinfo.circle))
															        {
															        	
                                                                       if(!$("#siterangecircle").is(":checked"))
                                                                       {
                                                                       	   
                                                                          $("#siterangecircle").click();
                                                                       }
															        } 
															        else
															        {
															        	
															         if($("#siterangecircle").is(":checked"))
                                                                       {
                                                                       
                                                                          $("#siterangecircle").click();
                                                                       }
															        }
															        
                                                                     $("#siterangecircle").change(function(e){
                                                                    	
                                                                        	if(this.checked)
                                                                        	{
                                                                        		
                                                                        		map.addLayer(siteinfo.circle);
                                                                        	}
                                                                        	else
                                                                        	{
                                                                        		map.removeLayer(siteinfo.circle);
                                                                        	}
                                                                        });
                                                                    
															       	
															    	   $.ajax({
																			 url:"${dftIpAddress}/fcgi-bin/AIS_Monitor",
																			 dataType:"jsonp",
																			 data:{
																					        //cmd:"0x010N",
																					        cmd:"0x0611",
																					        baseid:agreementId,
																					        //baseid:id,
																					        timepoint:new Date().getTime()
																				  },
																		     success:function(result){
																		    	 var data = result[0];
																		    	
                
																		     	//data = {"anavinum":5,"btypenum":246,"range":52.0,"vnavinum":43,"bsnr":11.6043830155943,"atypenum":614,"asnr":10.0270173916916,"aslot":0.288,"basenum":8,"bslot":0.265333333333333,ratio:{"曹妃甸":0.989451476793249,"京唐港":0.059451476793249}};
                                                                           if(!data)
                                                                        	   {
                                                                        	     alert("未查询到数据，请联系东方通公司！");
                                                                        	     return;
                                                                        	   }
                                                                         if(siteinfo.circle)
															       		 {
															       		   siteinfo.circle.setRadius(data.range*1852);
															       		 }
															       		else
															       		 {
														       			    siteinfo.circle = new L.circle(siteinfo.getLatLng(),data.range*1852,{color:"red",weight:0});		 
																		 }
																		  $("#siteBasicInfo tr td:nth-child(2)").each(function(index){           
                                                                                switch(index)
                                                                               {
																				
																				case 0:
																				  $(this).text(siteinfo.sitename?siteinfo.sitename:"空");
																				  break;
																				case 1:
																				  $(this).text(siteinfo.getLatLng().lng+"/"+siteinfo.getLatLng().lat);
																				  break;
																				case 2:
																				  $(this).text(data.aslot?(data.aslot*100).toFixed(3)+"%":"空");
																				  break;
																				case 3:
																				  $(this).text(data.bslot?(data.bslot*100).toFixed(3)+"%":"空");
																				  break;
																				case 4:
																				  $(this).text(data.asnr?data.asnr.toFixed(3)+"%":"空");
																				  break;
																			    case 5:
																				  $(this).text(data.bsnr?data.bsnr.toFixed(3)+"%":"空");
																				  break;
																				case 6:
																				  $(this).text(data.vnavinum?data.vnavinum+"(个)":"空");
                    															  break;
																				case 7:
																				  $(this).text(data.anavinum?data.anavinum+"(个)":"空");
                    															  break;
                    															 case 8:
																				  $(this).text(data.atypenum?data.atypenum+"(个)":"空");
                    															  break;
                    															  case 9:
																				  $(this).text(data.btypenum?data.btypenum+"(个)":"空");
                    															  break;
                    															  case 10:
																				  $(this).find("span").first().text(data.range?data.range.toFixed(3)+"(海里)":"");
                    															  break;
																				}
																		  });
																		  $("#sitebasicratio").nextAll().remove();
                                                                          for( var j in data.ratio)   
                                                                          {
                                                                        	  var name = siteAgreeToNam(''+j);
                                                                               $("#sitebasicratio").after("<tr><td>"+name+":</td><td>"+(data.ratio[j]*100).toFixed(3)+"%</td></tr>");
                                                                          }
																		}
															       	  });
                                                                          siteBasicInfoWindow.show();   	 
                                                                     });
                                                                      
															       site.on("contextmenu",function(e){
															        var url =  this.url;
                                                                    var circle = this.circle;
															        var point =  map.latLngToContainerPoint(e.latlng);
															        L.DomUtil.setPosition($("#siteContextMenu").get(0),point);
															        $("#siteContextMenu a").attr({href:url});
																	$("#siteContextMenu").show();										       	 
															       }); 
															       site.agreementId=result[i].listSites[j].agreementId;
															       var linecolor="black";
                                                                   if (result[i].listSites[j].connstate=="0") 
                                                                   	{
                                                                   		 linecolor = "green";
                                                                   	}
                                                                   	if(result[i].listSites[j].connstate=="1")
                                                                   	{
                                                                   		linecolor = "red";
                                                                   	}
                                                                   		if(result[i].listSites[j].connstate=="2")
                                                                   	{
                                                                   		linecolor = "yellow";
                                                                   	}

															       var polyLine = L.polyline([areaLalng,siteLalng], {weight:8,color: linecolor,opacity:1,weight:3}).addTo(map);
															       polyLine.line = result[i].listSites[j].line[0];
															       polyLine.on("click",function(e){
															       	if(line)
															       	{
															       		return;
															       	}
															       	var line = this.line;
															       	 $("#lineConnState tr td:nth-child(2)").each(function(index){
                                                                               switch(index)
                                                                               {
																				
																				case 0:
																				  $(this).text(line.usageRate?line.usageRate+"%":"空");
																				  break;
																				case 1:
																				  $(this).text(line.connState?(line.connState==0?"正常":(line.connState==1?"断开":(line.connState==2?"延迟高":"空"))):"空");
																				  break;
																				case 2:
																				  $(this).text(line.totalFlux?line.totalFlux+"Kbit/s":"空");
																				  break;
																				case 3:
																				  $(this).text(line.devName1?line.devName1:"空");
																				  break;
																				case 4:
																				  $(this).text(line.devName2?line.devName2:"空");
																				  break;
																			    case 5:
																				  $(this).text(line.portName1?line.portName1:"空");
																				  break;
																				case 6:
																				  $(this).text(line.portName2?line.portName2:"空");
																				  break;
																				}
															       	 });
															       	 lineWindow.show();
															       });
															       lineGroup.addLayer(polyLine);
															       area.sites.push(site);
												       } 
									      		 sitegroup.addLayer(area);   
									      	}
					     		}
					     },
							error:function()
							{
								alert("请求数据失败，请联系瑞峰公司！");
							}
				});

}


/*********船发报文********/
function showBoatWindow1(boat){
	var content;
		switch(boat.id)
	{
		case "sixBoat":content='<form><table class="msgtable">'+
       '<tr><td>消息ID:</td><td><input type="text" /></td><td>应用数据:</td><td><input type="text" /></td></tr>'+
       '<tr><td>转发指示符:</td><td><select><option>1</option><option>2</option><option>3</option></select></td><td>应用标识符:</td><td><input type="text" /></td></tr>'+
       '<tr><td>序列编号:</td><td><select><option>1</option><option>2</option><option>3</option></select></td><td>重发标志:</td><td><select><option>1</option><option>2</option></select></td></tr>'+
       '<table></form>'+
       '<div class="middle"><input type="button" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div>';break;
		case "sevenBoat" : content='<form><table class="msgtable">'+
	       '<tr><td>消息ID:</td><td><input type="text" /></td>'+
	       '<td>转发指示符:</td><td><select><option>1</option><option>2</option><option>3</option></select></td></tr>'+
	       '<table></form>'+
	       '<div class="middle"><input type="button" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div>';break;
        case "eightMsg": content='<form><table class="msgtable">'+
       '<tr><td>消息ID:</td><td><input type="text" /></td><td>应用数据:</td><td><input type="text" /></td></tr>'+
       '<tr><td>转发指示符:</td><td><select><option>1</option><option>2</option><option>3</option></select></td><td>应用标识符:</td><td><input type="text" /></td></tr>'+
       '<table></form>'+
       '<div class="middle"><input type="button" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div>';break;
	   case "tenMsg" :content='<form><table class="msgtable">'+
	       '<tr><td>消息ID:</td><td><input type="text" /></td>'+
	       '<td>转发指示符:</td><td><select><option>1</option><option>2</option><option>3</option></select></td></tr>'+
	       '<table></form>'+
	       '<div class="middle"><input type="button" value ="发送"/><input class="btndistance" type="reset" value ="清空"/></div>';break;
	}
 contextMenuBoatWindow.content(content);
 contextMenuBoatWindow.show();
}
window.onload=function(){
/********设置ajax请求无缓存********/	
$.ajaxSetup({ cache: false }); 
 											       	  									       	

/*****************选择查询的基站****************/
       $("#toggle").mouseenter(function(){
	        $("#mapmenu").show();
		 }); 
       $("#mapmenu").mouseleave(function(){
       	  $(this).hide();
       })
		$("#sitemonitor").change(function(){
		if($("#sitemonitor").attr("checked")==="checked")
		 {/******显示 基站连线*********/  
		    lineGroup.eachLayer(function (layer) {
    			layer.setStyle({opacity:1}) ;
		 });
		 }
		 else
		 {
		 	lineGroup.eachLayer(function (layer) {
    			layer.setStyle({opacity:0}) ;
		 });
		 }
		});   

		$("#selectSiteInfo").change(function(){
		   var value = $("#selectSiteInfo").val();
		   var cmd;
		   if(value=="0")
		   {
		     $("#siteInfoSelect").empty();
		   }
		   else{
		   switch(value)
			   {
			  	 case '1':cmd="0x0601";url="sitesigal";
			  		 break;
				 case '2':cmd="0x0602";url="sitesigal";
				   break;
				 case '3':cmd="0x0603";url="sitesigal";
					   break;
				 case '4':cmd="0x0604";url="sitesigal"
					   break;
			     case '5':cmd="0x0605";url="sitesigalsingle";
					   break;
			     case '6':cmd="0x0606";url="sitesigalsingle";
					   break;
			     case '7':cmd="0x0607";url="sitesigal";
					   break;
				 case '8':cmd="0x0608";url="sitesigal";
					   break;
				 case '9':cmd="0x0609";url="sitesigal";
					   break;
				 case '10':cmd="0x0610";url="sitesigalsingle";
					   break;
			   }
		   $("#siteInfoSelect").load(url,{cmd:cmd});
		   }
		});
		
/***********************发送基站信息**************************/		
		     $("#msgSendButton").click(function(){
		     if($("#boatmmsi").val().replace(/[ ]/g,"")=="")
			     {
			        return false;
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
		map = L.map('map',{zoomAnimation:true,minZoom:3,fullscreenControl: true,inertiaDeceleration:5000,fadeAnimation:true,markerZoomAnimation:true,inertiaThreshold:5000});
		L.control.layers(baseLayers).addTo(map);
		L.control.scale({'position':'bottomleft','metric':true,'imperial':false}).addTo(map);
		map.addLayer(basicogs); 
		//map.setMaxBounds([[54.67383, 67.58789],[16.64625, 139.57031]]);
		//map.setView([32.89761785919426, 126.7822265625],5);
		map.setView(center,5);
		group = L.featureGroup().addTo(map);
		sitegroup = L.featureGroup().addTo(map);
		lineGroup =  L.featureGroup().setStyle({opacity:0}).addTo(map);
		boatControl = L.control.layers(group);
		trace = L.featureGroup().addTo(map);
		searchBoatGroup = L.featureGroup().addTo(map);
		var drawnItems = L.featureGroup().addTo(map);/*画图层*/
		/*map.addControl(new L.Control.Draw({
			edit: { featureGroup: drawnItems },
			draw:{rectangle:{},circle:{}}
		}));*/
/***************单击地图隐藏右键菜单**********************/
map.on("click",function(){
  $("#siteContextMenu").hide();
});
map.on("zoomstart",function(){
	 $("#siteContextMenu").hide();
});
map.on("movestart",function(){
	 $("#siteContextMenu").hide();
});
/***********************加载基站**************************/	
		$.ajax({
						 url:"${root}/siteinfo/webService/getSiteInfo",
						 dataType:"json",
					     success:function(result)
					     {
					     
					     $("#siteSend").load("sitesendinfo");
					    	for(var i=0;i<result.length;i++)
					     		{
							       var apopup =  L.popup().setContent(result[i].jurisdictionName); 
							       var areaLalng = L.latLng(result[i].jurisdictionLat,result[i].jurisdictionLon);
							       var area = L.marker(areaLalng,{icon: areaIcon}).bindPopup(apopup).addTo(map);
							       area.jurl = result[i].jurl;
							       area.on("click",function(){
							       	  window.open(this.jurl);
							       });
							       area.sites=[];
									       if(result[i].listSites.length>0)
									       {
									                  
												       for(var j=0;j<result[i].listSites.length;j++)
												       {
															       var siteLalng = L.latLng(result[i].listSites[j].siteLat,result[i].listSites[j].siteLon);
															       var spopup =  L.popup(siteLalng).setContent(result[i].listSites[j].sitename);
															       var site = L.marker(siteLalng,{icon:siteIcon,title:result[i].listSites[j].sitename}).bindPopup(spopup);
                                                                   if(result[i].listSites[j].sitestate!="1")
                                                                   {
                                                                   
                                                                   	  var errorIcon =  new L.Icon({iconUrl:'${root}/themes/map/images/error.png',iconAnchor: [1, 3]});
                                                                   	  var siteError = L.marker(siteLalng,{icon:errorIcon});
                                                                   	   sitegroup.addLayer(siteError);
                                                                   }
															       
															       
															       site.sitename = result[i].listSites[j].sitename;
															       site.sitestate = result[i].listSites[j].sitestate;
															       site.agreementId = result[i].listSites[j].agreementId;
                                                                   site.url = result[i].listSites[j].url;
                                                                   sitegroup.addLayer(site);
															       site.on("click",function(event){															       	
															       	var latlng = this.getLatLng();
									                               var agreementId = this.agreementId;
															        var siteinfo = this;
                                                                    $("#siterangecircle").off("change");

															        if(map.hasLayer(siteinfo.circle))
															        {
															        	
                                                                       if(!$("#siterangecircle").is(":checked"))
                                                                       {
                                                                       	   
                                                                          $("#siterangecircle").click();
                                                                       }
															        } 
															        else
															        {
															        	
															         if($("#siterangecircle").is(":checked"))
                                                                       {
                                                                       
                                                                          $("#siterangecircle").click();
                                                                       }
															        }
															        
                                                                     $("#siterangecircle").change(function(e){
                                                                    	
                                                                        	if(this.checked)
                                                                        	{
                                                                        		
                                                                        		map.addLayer(siteinfo.circle);
                                                                        	}
                                                                        	else
                                                                        	{
                                                                        		map.removeLayer(siteinfo.circle);
                                                                        	}
                                                                        });
                                                                    
															       	
															    	   $.ajax({
																			 url:"${dftIpAddress}/fcgi-bin/AIS_Monitor",
																			 dataType:"jsonp",
																			 data:{
																					        //cmd:"0x010N",
																					        cmd:"0x0611",
																					        baseid:agreementId,
																					        //baseid:id,
																					        timepoint:new Date().getTime()
																				  },
																		     success:function(result){
																		    	 
																		    	 //console.log(data);
                                                                            
																		     	//data = {"anavinum":5,"btypenum":246,"range":52.0,"vnavinum":43,"bsnr":11.6043830155943,"atypenum":614,"asnr":10.0270173916916,"aslot":0.288,"basenum":8,"bslot":0.265333333333333,ratio:{"曹妃甸":0.989451476793249,"京唐港":0.059451476793249}};
                                                                           var data = result[0]; 
                                                                           if(!data)
                                                                        	   {
                                                                        	     alert("未查询到数据，请联系东方通公司！");
                                                                        	     return; 
                                                                        	   }
                                                                         if(siteinfo.circle)
															       		 {
															       		   siteinfo.circle.setRadius(data.range*1852);
															       		 }
															       		else
															       		 {
														       			    siteinfo.circle = new L.circle(siteinfo.getLatLng(),data.range*1852,{color:"red",weight:0});		 
																		 }
																		  $("#siteBasicInfo tr td:nth-child(2)").each(function(index){ 
                                                                                switch(index)
                                                                               {
																				
																				case 0:
																				  $(this).text(siteinfo.sitename?siteinfo.sitename:"空");
																				  break;
																				case 1:
																				  $(this).text(siteinfo.getLatLng().lng+"/"+siteinfo.getLatLng().lat);
																				  break;
																				case 2:
																				  $(this).text(data.aslot?(data.aslot*100).toFixed(3)+"%":"空");
																				  break;
																				case 3:
																				  $(this).text(data.bslot?(data.bslot*100).toFixed(3)+"%":"空");
																				  break;
																				case 4:
																				  $(this).text(data.asnr?data.asnr.toFixed(3)+"%":"空");
																				  break;
																			    case 5:
																				  $(this).text(data.bsnr?data.bsnr.toFixed(3)+"%":"空");
																				  break;
																				case 6:
																				  $(this).text(data.vnavinum?data.vnavinum+"(个)":"空");
                    															  break;
																				case 7:
																				  $(this).text(data.anavinum?data.anavinum+"(个)":"空");
                    															  break;
                    															 case 8:
																				  $(this).text(data.atypenum?data.atypenum+"(个)":"空");
                    															  break;
                    															  case 9:
																				  $(this).text(data.btypenum?data.btypenum+"(个)":"空");
                    															  break;
                    															  case 10:
																				  $(this).find("span").first().text(data.range?data.range.toFixed(3)+"(海里)":"");
                    															  break;
																				}
																		  });
																		  $("#sitebasicratio").nextAll().remove();
                                                                          for( var j in data.ratio)   
                                                                          {
                                                                        	   var name = siteAgreeToNam(''+j);
                                                                        	  // console.log(name);
                                                                               $("#sitebasicratio").after("<tr><td>"+name+":</td><td>"+(data.ratio[j]*100).toFixed(3)+"%</td></tr>");
                                                                          }
																		}
															       	  });
                                                                          siteBasicInfoWindow.show();   	 
                                                                     });
                                                                      
															       site.on("contextmenu",function(e){
															        var url =  this.url;
                                                                    var circle = this.circle;
															        var point =  map.latLngToContainerPoint(e.latlng);
															        L.DomUtil.setPosition($("#siteContextMenu").get(0),point);
															        $("#siteContextMenu a").attr({href:url});
																	$("#siteContextMenu").show();										       	 
															       }); 
															       site.agreementId=result[i].listSites[j].agreementId;
															       var linecolor="black";
                                                                   if (result[i].listSites[j].connstate=="0") 
                                                                   	{
                                                                   		 linecolor = "green";
                                                                   	}
                                                                   	if(result[i].listSites[j].connstate=="1")
                                                                   	{
                                                                   		linecolor = "red";
                                                                   	}
                                                                   		if(result[i].listSites[j].connstate=="2")
                                                                   	{
                                                                   		linecolor = "yellow";
                                                                   	}

															       var polyLine = L.polyline([areaLalng,siteLalng], {weight:8,color: linecolor,opacity:1,weight:3}).addTo(map);
															       polyLine.line = result[i].listSites[j].line[0];
															       polyLine.on("click",function(e){
															       	if(line)
															       	{
															       		return;
															       	}
															       	var line = this.line;
															       	 $("#lineConnState tr td:nth-child(2)").each(function(index){
                                                                               switch(index)
                                                                               {
																				
																				case 0:
																				  $(this).text(line.usageRate?line.usageRate+"%":"空");
																				  break;
																				case 1:
																				  $(this).text(line.connState?(line.connState==0?"正常":(line.connState==1?"断开":(line.connState==2?"延迟高":"空"))):"空");
																				  break;
																				case 2:
																				  $(this).text(line.totalFlux?line.totalFlux+"Kbit/s":"空");
																				  break;
																				case 3:
																				  $(this).text(line.devName1?line.devName1:"空");
																				  break;
																				case 4:
																				  $(this).text(line.devName2?line.devName2:"空");
																				  break;
																			    case 5:
																				  $(this).text(line.portName1?line.portName1:"空");
																				  break;
																				case 6:
																				  $(this).text(line.portName2?line.portName2:"空");
																				  break;
																				}
															       	 });
															       	 lineWindow.show();
															       });
															       lineGroup.addLayer(polyLine);
															       area.sites.push(site);
												       } 
									      		 sitegroup.addLayer(area);   
									      	}
					     		}
					     },
					     error:function()
					     {
					     	alert("请求数据失败，请联系瑞峰公司！");
					     }
				});
setInterval("siteLoad()",1200000);
/*/***********************测试数据**************************/
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
map.on("click",function(event){
 //alert(event.latlng.lng+"-"+event.latlng.lat);
});
       map.on('draw:created', function(event) {
			var layer = event.layer;
			drawnItems.addLayer(layer);
			var url;
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
			    layer.on("draw:deletestop",function(event){
			  	
			     
			  	});
			}	
			else if(event.layerType=="marker")
			{
			  layer.on("click",function(event){		
			  virtualSaleWindow.layer=layer;  
              $("#virtuallng").val(lngLatTo(this.getLatLng().lng));
              $("#virtuallat").val(lngLatTo(this.getLatLng().lat));
              $("#virtualSaleName").val(layer.name);
			  virtualSaleWindow.show();
			  });
			  layer.fire("click");
			  layer.dragging.enable();
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
/*****************移动图层加载图层内的船只信息******************/
      
		/*map.on('moveend',function(event){
		var bounds = this.getBounds();
		
		var west = bounds.getWest();
		var south = bounds.getSouth();
		var east = bounds.getEast();
		var north = bounds.getNorth();
		if(map.getZoom()<8)
			    { 		
                    return;   
			    }
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
			          		        
			    	var step = data.length>200? parseInt(data.length/200):1;
			    	if(data.length>100)
			    	{
					     	group.clearLayers();     
			    	}	
			        	for(var i=0;i<data.length;i=i+step)
					  {
					     var l = L.latLng(data[i].latitude, data[i].longitude);
					     var popup = L.popup().setContent('<table id="ais-table" class="ais-table">'+
					     '<tr>'+
                        '<td>mmsi:</td>'+
                        '<td>'+data[i].mmsi+'</td>'+
                        '<td>船舶IMO:</td>'+
                        '<td>'+data[i].imo+'</td></tr><tr>'+
                        '<td>经度：</td>'+
                        '<td>'+data[i].latitude+'</td>'+
                        '<td>经度：</td>'+
                        '<td>'+data[i].longitude+'</td></tr>'+
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
			     },
			     error:function()
			     {
			     alert("请求数据失败，请检查数据库服务器！显示模拟数据！"); 
			     }
				});
			});*/
			//map.setView([32.89761785919426, 126.7822265625],5);
}
/*]]>*/
</script> 
<input type="hidden" id="dftIpAddress" value="${dftIpAddress}">
<div id="mapContainer">	
<div id='map'>
	      <div id="siteContextMenu" class="contextMenu">
                     <div class="hiddenMenu" ><div><a target="_blank">查看拓扑图</a></div></div>
		  </div>
 </div>
</div>	
		<style type="text/css">
		  	#map {
				  	margin: 0;
					padding: 0;
					width: 100%;
					height: 766px;
				    }
				 .contextMenu{
				 	position: absolute;
				  	background-color: white;
				  	z-index: 1000;
				  	width:120px;
				  	display:none;
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
       </style>
   </html>