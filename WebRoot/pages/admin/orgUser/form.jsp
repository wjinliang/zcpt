<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<title>组织管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,chrome=1">
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<%@include file="../include/head.jsp"%>
	<!-- END HEADER -->
		<!-- BEGIN SIDEBAR -->
		<%@include file="../include/sidebar.jsp"%>
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
					<div class="row-fluid">
					<div class="span12">
						<h3 class="page-title">
							表单 <small>新增/修改组织</small>
						</h3>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green" >
							<div class="portlet-title">
							表单
							</div>
							<div class="portlet-body">
							<form action="${root}/orgAndUser/save" method="post" id="format_form" class="form-horizontal">
								<div class="alert alert-error hide">

										<button class="close" data-dismiss="alert"></button>

										表单填写不正确，请仔细核查。

								</div>

								<div class="alert alert-success hide">

										<button class="close" data-dismiss="alert"></button>

										提交成功，等待跳转！

								</div>
									<input type="hidden" name="id" value="${org.id}"/>
									<input type="hidden" name="parentid" id="parentid" value="${parentid}"/>
									<input type="hidden" name="divisionParentid" id="divisionParentid" value="${divisionid}"/>
									<input type="hidden" name="flag" value="${flag}"/>
									<input type="hidden" name="FORM_TOKEN" value="${FORM_TOKEN}"/>
									<input type="hidden" id="appCheckList" name="appCheckList" value="" />
									<input type="hidden" name="divisionid" id="divisionid" value="${org.division.id}"/>
									<div class="control-group">

										<label class="control-label">组织名<span
											class="required">*</span>
										</label>
										<div class="controls">
											<input type="text" name="name"  data-required="1"
												value="${org.name}" class="span8 m-wrap" />
										</div>

									</div>
									<div class="control-group">
										<label class="control-label">所属区划<span
											class="required">*</span>
										</label>
										<div class="controls">
										<input type="text" name="divisionName" id="divisionName" value="${org.division.name}" data-required="1"
												class="span6 m-wrap" readonly="readonly" />
			
										<!-- <button type="button" onclick="chooseDivision();" class="btn green">
											选择
										</button> -->
										</div>
									</div>
									<div class="control-group">

										<label class="control-label">组织编码<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" readonly='true' name="code" id="code" data-required="1"
												value="${org.code}" class="span8 m-wrap" />

										</div>

									</div>
									<div class="control-group">
										<label class="control-label">组织类型
										</label>
										<div class="controls">
											<select name="type" id="type">
												<option value="0"  <c:if test="${org.type=='0'}">selected="selected" </c:if>>部</option>
												<option value="1"  <c:if test="${org.type=='1'}">selected="selected" </c:if>>省</option>
												<option value="2"  <c:if test="${org.type=='2'}">selected="selected" </c:if>>市</option>
												<option value="3"  <c:if test="${org.type=='3'}">selected="selected" </c:if>>县</option>
												<option value="4"  <c:if test="${org.type=='4'}">selected="selected" </c:if>>镇（乡）</option>
												<option value="5"  <c:if test="${org.type=='5'}">selected="selected" </c:if>>村</option>
											</select>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">主管人
										</label>
										<div class="controls">

											<input type="text" name="leadName"  data-required="1"
												value="${org.leadName}" class="span8 m-wrap" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">联系人
										</label>
										<div class="controls">

											<input type="text" name="linkman"  data-required="1"
												value="${org.linkman}" class="span8 m-wrap" />
										</div>
									</div>
									<c:if test="${mode=='edit'}">
									<div class="control-group">
										<label class="control-label">创建人
										</label>
										<div class="controls">
											<input type="text" name="createUser"  data-required="1"
												value="${org.createUser}" class="span8 m-wrap"  readonly="readonly"/>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">创建日期
										</label>
										<div class="controls">

											<input type="text" name="createDate"  data-required="1"
												value="${org.createDate}" class="span8 m-wrap" readonly="readonly"/>
										</div>
									</div>
									</c:if>
									<div class="control-group">
										<label class="control-label">邮编
										</label>
										<div class="controls">

											<input type="text" name="postalCode"  data-required="1"
												value="${org.postalCode}" class="span8 m-wrap"/>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">邮编地址
										</label>
										<div class="controls">

											<input type="text" name="postalAddress"  data-required="1"
												value="${org.postalAddress}" class="span8 m-wrap"/>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">传真号
										</label>
										<div class="controls">

											<input type="text" name="faxno"  data-required="1"
												value="${org.faxno}" class="span8 m-wrap"/>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">电话号码
										</label>
										<div class="controls">

											<input type="text" name="phoneno"  data-required="1"
												value="${org.phoneno}" class="span8 m-wrap"/>
										</div>
									</div>
									<div class="control-group">

										<label class="control-label">排序号<span
											class="required">*</span>
										</label>
										<div class="controls">

											<input type="text" name="seq" value="${org.seq}" data-required="1"
												value="${org.seq}" class="span8 m-wrap" />

										</div>

									</div>
									
									<c:if test="${not empty org.id}"> 
										<div class="form-actions" id="listApp">
										</div>
									</c:if>
									<div class="form-actions">
										<c:if test="${empty org.id}"> 
										<button type="submit" class="btn green">提交</button>
 									 </c:if>
 									 <c:if test="${not empty org.id}"> 
 										<button type="button" onclick="checkTongBu();"
											class="btn green">提交</button>
										<button type="button" onclick="chooseRoles();"	class="btn green">组织授权</button>
									</c:if>
										<button type="button" onclick="beBack();"
											class="btn">返回</button>

									</div>

								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	</div>
	</body>
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER -->
	<%@include file="../include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../include/js.jsp"%>
	<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=basePath%>themes/lhgdialog/lhgdialog.min.js${dialog_css}"></script>
	<script type="text/javascript"
		src="${root}/themes/platform/js/metro.layout.js"></script>
	
	<script>
	jQuery.validator.addMethod("isPassword", function(value, element) {    
	    var tel = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*()_+`\-={} :";'<>?,.\/]).{8,30}$/;
	    return this.optional(element) || (tel.test(value));
	}, "必须字母数字符号汇合且大于8位");
		jQuery(document).ready(function() {
			App.handleNavInit("3");
			var form = $('#format_form');
            var error = $('.alert-error', form);
            var success = $('.alert-success', form);
            
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    name: {
                        required: true
                    },
					code:{
						 required: true
					},
					seq:{
						 required: true
					}
                },

                messages: { // custom messages for radio buttons and checkboxes
                    name: {
                        required: "请输入组织名称"
                    },
					code:{
						 required: "请输入组织代码"
					},
					seq:{
						 required: "请输入排序号"
					}
                },

                errorPlacement: function (error, element) { // render error placement for each input type                   
                        error.insertAfter(element); // for other inputs, just perform default behavoir
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                    App.scrollTo(error, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                        .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });
		});
		function closewin(){
		var api = frameElement.api, W = api.opener; // api.opener 为载加lhgdialog.min.js文件的页面的window对象
		api.close();
		}
	</script>
	<script>
	function beBack(){
		var divisionid = $("#divisionParentid").val();
		var orgid = $("#parentid").val();
		if(orgid!=null && orgid !=""){
			window.location.href="${root}/orgAndUser/listSon?orgid="+orgid;
		}else{
			window.location.href="${root}/orgAndUser/listOrgs?divisionid="+divisionid;
		}
	}
	
	
	</script>
	<script>
	var browser=navigator.appName 
	var b_version=navigator.appVersion 
	var version=b_version.split(";");
	var trim_Version;
	if(version){
		try{
		trim_Version=version[1].replace(/[ ]/g,""); 
		}catch(e){
			
		}
	}
	var ieMS;
	function getIEMS(){
		if(ieMS){
			return ieMS;
		}
		if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
		{ 
			ieMS= "6.0"
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
		{ 
			ieMS= "7.0";
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
		{ 
			ieMS=  "8.0"; 
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
		{ 
			ieMS=  "9.0";
		}
		return ieMS;
	}
	$(document).ready(function(){
		if('${mode}'=='edit'){
		$.ajax({
			type:'post',
			url:'${root}/synorg/loadAppInfo',
			data:{
				orgId:'${org.id}'
			},
			dataType:'html',
			success:function(data) { 
				var app_array = $.parseJSON(data);  // 把字串轉換成 JSON array 
				var html="<table><tr>";
					$.each(app_array, function(index, app) { 
						var checked = "";
						var hidden = "";
						if(app.hidden){
							hidden = " hidden=\"true\" ";
						}
						if(app.status=="1"){
							checked = " checked =\"checked\"";
						}
						//var sta = getIEMS();
						//if(sta =="7.0"){
						//	html+="<input type=\"checkbox\" "
						//	+checked
						//	+"name=\"checkboxes\" value=\""+app.appId+"\" "+hidden+"/>"+app.appName+"";
						//}else{
							html+="<td style=\"vertical-align: middle;\" "+hidden+"><input type=\"checkbox\" "
							+checked
							+"class=\"checkboxes\" name=\"checkboxes\" value=\""+app.appId+"\"/>"+app.appName+"</td>";
						//}
					});
					$("#listApp").html(html+"</tr></table>");
			}
		});
		}
		});
	function chooseDivision(){
// 		var height=500;
// 		var width=600;
// 		var aa=window.showModalDialog('${root}/orgAndUser/chooseDivision?orgid=${org.id}',window,'dialogHeight='+height+',dialogWidth='+width);
		 modalDivision = $.MetroLayout({
				contentId : "edip",
				title : "选择区划",
				width : 700,
				height : 500
			});
		 modalDivision.$content.load('${root}/orgAndUser/chooseDivision?orgid=${org.id}');
		 //modalDivision.show();
	}
	var modalDivision;
	function getcheckedids(){
		var ids=[];
		var cbs = document.getElementsByName("checkboxes");
		for(var i = 0 ; i < cbs.length; i++){
			if(cbs[i].checked == true){
				//ids.push(cbs[i].value);
				ids.push("'"+cbs[i].value+"'");
			}
		}
		return ids;
		}
	var modalCheck;
	function checkTongBu(){
		var appCheckList=getcheckedids();
		$("#appCheckList").val(appCheckList);
// 		var height=500;
// 		var width=600;
// 		var aa=window.showModalDialog('${root}/synorg/checkTongBu?appCheckList='+appCheckList+'&orgId=${org.id}',window,'dialogHeight='+height+',dialogWidth='+width);
		 modalCheck = $.MetroLayout({
				contentId : "editPop",
				title : "同步提示",
				width : 900,
				height : 500
			});
		 modalCheck.$content.load('${root}/synorg/checkTongBu?appCheckList='+appCheckList+'&orgId=${org.id}');
		//window.location.reload();
	}
	
	function doTongBu(){
		 $.ajax({
            cache: true,
            type: "POST",
            url:'${root}/synorg/ajaxsave',
            data:$('#format_form').serialize(),// 你的formid
            dataType:'html',
            async: false,
            error: function(request) {
                alert("Connection error");
            },
            success: function(data) {
//            		var height=500;
//         		var width=600;
//         		window.showModalDialog('${root}/synorg/synUserResult?result='+encodeURI(data),window,'dialogHeight='+height+',dialogWidth='+width);
            	modalResult = $.MetroLayout({
    				contentId : "res",
    				title : "同步结果",
    				width : 900,
    				height : 500
    			});
            	modalResult.$content.load('${root}/synorg/synUserResult?result='+encodeURI(data));
            }
        });
	}
	var modalResult;
	function getallids(){
		var ids=[];
		var cbs = document.getElementsByName("checkboxes");
		for(var i = 0 ; i < cbs.length; i++){
				ids.push("'"+cbs[i].value+"'");
		}
		return ids;
		}
	
	var modal;
	function chooseRoles(){
		var ids = getcheckedids();
// 		var height=500;
// 		var width=600;
// 		var aa=window.showModalDialog('${root}/synuser/showAppList?ids='+ids+'&orgid=${org.id}',window,'dialogHeight='+height+',dialogWidth='+width);
		 modal = $.MetroLayout({
				contentId : "editPop",
				title : "授权",
				width : 900,
				height : 500
			});
			modal.$content.load('${root}/synuser/showAppList?ids='+ids+'&orgid=${org.id}');

	}
	
	</script>
</html>
