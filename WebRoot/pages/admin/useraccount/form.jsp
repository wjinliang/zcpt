<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
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
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,chrome=1">
<meta content="" name="description" />
<meta content="" name="author" />
<title>用户管理-表单</title>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="<%=basePath%>themes/media/css/bootstrap-fileupload.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/select2_metro.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/chosen.css" />
<script type="text/javascript"
	src="<%=basePath%>themes/My97DatePicker/WdatePicker.js"></script>
<!-- END PAGE LEVEL STYLES -->

</head>
<!-- END HEAD -->
<!-- BEGIN HEADER -->
<%@include file="../include/head.jsp"%>
<!-- END HEADER -->
<!-- BEGIN SIDEBAR -->
<%@include file="../include/sidebar.jsp"%>
<!-- END SIDEBAR -->
<!-- BEGIN PAGE -->
<div class="page-content">
	<!-- BEGIN PAGE CONTAINER-->
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<h3 class="page-title">
					表单 <small>新增/修改用户</small>
				</h3>
			</div>
		</div>
		<div class="row-fluid">
			<!-- 
				<div class="span4">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>头像
								</div>
							</div>

							<div class="portlet-body form">
								<div class="controls" style="">
									<div class="thumbnail" style="width: 255px; height: 260px;">
										<img id="headpic" src="${useraccount.headpic}" alt="当前头像"
											style="width: 250px; height: 250px;margin-top: 5px;" />
									</div>
									<div class="space10"></div>
									<div class="fileupload fileupload-new"
										data-provides="fileupload">

										<div class="input-append">

											<div class="uneditable-input">

												<i class="icon-file fileupload-exists"></i> <span
													class="fileupload-preview"></span>

											</div>

											<span class="btn btn-file"> <span
												class="fileupload-new">选择文件</span> <span
												class="fileupload-exists">更改</span> 
												<input type="file" id="headFile" class="default" name="file"/> </span> 
												<a href="javascript:void(0);" class="btn fileupload-exists" data-dismiss="fileupload">删除</a>

										</div>
										<div class="controls" style="text-align: left;">
											<span class="label label-important">注意!</span>
											<span>提交信息前，点击保存并预览头像，头像保存信息才能生效！</span>
										</div>
										<div class="submit-btn">

											<a href="javascript:ajaxFileUpload('headFile');" class="btn green">保存并预览</a>

										</div>

										
									</div>
								</div>
							</div>
						</div>
					</div>
					 -->
			<div class="span12">
				<div class="portlet box green">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-reorder"></i>表单内容
						</div>
					</div>

					<div class="portlet-body form">

						<!-- BEGIN FORM-->

						<form action="${root}/synuseraccount/save" method="post"
							id="format_form" class="form-horizontal">
							<input type="hidden" name="code" value="${useraccount.code}" />
							<input type="hidden" name="FORM_TOKEN" value="${FORM_TOKEN}" />
							<input type="hidden" name="orgid" id="orgid"
								value="${useraccount.org.id}" /> <input type="hidden"
								id="imgid" name="imgid" value="${useraccount.headphoto.id}" />
							<input type="hidden" id="systemId" name="systemId"
								value="${currentUser.systemId}" /> <input type="hidden"
								id="appCheckList" name="appCheckList" value="" />
							<div id="alert-error" class="alert alert-error hide">

								<button class="close" data-dismiss="alert"></button>

								表单填写不正确，请仔细核查。

							</div>

							<div id="alert-success" class="alert alert-success hide">

								<button class="close" data-dismiss="alert"></button>

								提交成功，等待跳转！

							</div>

							<div class="control-group">
								<label class="control-label">用户名<span class="required">*</span>
								</label>
								<div class="controls">
									<input type="text" name="name" value="${useraccount.name}"
										data-required="1" class="span8 m-wrap" />
								</div>
							</div>
							<div class="control-group">

								<label class="control-label">登录名 <c:if
										test="${mode=='new'}">
										<span class="required">*</span>
									</c:if>
								</label>

								<div class="controls">
									<c:if test="${mode=='new'}">
										<input type="text" name="loginname" id="loginname"
											readonly='true' value="${useraccount.loginname}"
											data-required="1" class="span8 m-wrap" />
									</c:if>
									<c:if test="${mode!='new'}">
										<span class="text">${useraccount.loginname}</span>
									</c:if>
								</div>

							</div>

							<div class="control-group">
								<label class="control-label">是否启用<span class="required">*</span>
								</label>
								<div class="controls">
									<label class="radio line"> <input type="radio"
										name="enabled" value="true"
										<c:if test="${useraccount.enabled}">  checked="checked" </c:if> />
										是
									</label> <label class="radio line"> <input type="radio"
										name="enabled" value="false"
										<c:if test="${!useraccount.enabled}">  checked="checked" </c:if> />
										否
									</label>
									<div id="enabled_error"></div>
								</div>
							</div>
							<c:if test="${mode=='new'}">
								<div class="control-group">

									<label class="control-label">密码<span class="required">*</span>
									</label>

									<div class="controls">

										<input type="password" name="password" data-required="1"
											class="span8 m-wrap" />

									</div>

								</div>

								<div class="control-group">

									<label class="control-label">确认密码<span class="required">*</span>
									</label>

									<div class="controls">

										<input type="password" name="cpassword" data-required="1"
											class="span8 m-wrap" />

									</div>

								</div>
							</c:if>
							<c:if test="${mode=='edit'}">
								<div class="control-group">
									<label class="control-label">创建人 </label>
									<div class="controls">
										<input type="text" name="createUser" data-required="1"
											value="${useraccount.createUser}" class="span8 m-wrap"
											readonly="readonly" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">创建日期 </label>
									<div class="controls">

										<input type="text" name="createDate" data-required="1"
											value="${useraccount.createDate}" class="span8 m-wrap"
											readonly="readonly" />
									</div>
								</div>
							</c:if>
							<!--<div class="control-group">
								<label class="control-label">用户类型<span class="required">*</span>
								</label>
								<div class="controls">
									<label class="radio line"> <input type="radio"
										name="userType" value="个人用户"
										<c:if test="${useraccount.userType=='个人用户'}">  checked="checked" </c:if> />
										个人用户
									</label> <label class="radio line"> <input type="radio"
										name="userType" value="单位用户"
										<c:if test="${useraccount.userType=='单位用户'}">  checked="checked" </c:if> />
										单位用户
									</label>
									<div id="enabled_error"></div>
								</div>
							</div>-->
							<div class="control-group">
								<label class="control-label">性别<span class="required">*</span>
								</label>
								<div class="controls">
									<label class="radio line"> <input type="radio"
										name="gender" value="男"
										<c:if test="${useraccount.gender=='男'}">  checked="checked" </c:if> />
										男
									</label> <label class="radio line"> <input type="radio"
										name="gender" value="女"
										<c:if test="${useraccount.gender=='女'}">  checked="checked" </c:if> />
										女
									</label>
									<div id="enabled_error"></div>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">生日</label>
								<div class="controls">
									<input type="text" name="birthday"
										value="${useraccount.birthday}" data-required="1"
										class="span8 m-wrap" onClick="WdatePicker();"
										readonly="readonly" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">联系电话</label>
								<div class="controls">
									<input type="text" name="mobile" value="${useraccount.mobile}"
										data-required="1" class="span8 m-wrap" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">电子邮箱<span class="required">*</span>
								</label>
								<div class="controls">
									<input type="text" name="email" value="${useraccount.email}"
										data-required="1" class="span8 m-wrap" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">办公电话</label>
								<div class="controls">
									<input type="text" name="bizPhoneNo"
										value="${useraccount.bizPhoneNo}" class="span8 m-wrap" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">传真</label>
								<div class="controls">
									<input type="text" name="faxno" value="${useraccount.faxno}"
										data-required="1" class="span8 m-wrap" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">职务</label>
								<div class="controls">
									<input type="text" name="duty" value="${useraccount.duty}"
										data-required="1" class="span8 m-wrap" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">学历</label>
								<div class="controls">
									<select name="schoolAge" id="schoolAge">
										<option value="高中及以下"
											<c:if test="${useraccount.schoolAge=='高中及以下'}">selected="selected" </c:if>>高中及以下
										</option>
										<option value="中专"
											<c:if test="${useraccount.schoolAge=='中专'}">selected="selected" </c:if>>中专
										</option>
										<option value="专科"
											<c:if test="${useraccount.schoolAge=='专科'}">selected="selected" </c:if>>
											专科</option>
										<option value="本科"
											<c:if test="${useraccount.schoolAge=='本科'}">selected="selected" </c:if>>
											本科</option>
										<option value="硕士"
											<c:if test="${useraccount.schoolAge=='硕士'}">selected="selected" </c:if>>硕士
										</option>
										<option value="博士"
											<c:if test="${useraccount.schoolAge=='博士'}">selected="selected" </c:if>>博士
										</option>
										<option value="博士后"
											<c:if test="${useraccount.schoolAge=='博士后'}">selected="selected" </c:if>>博士后</option>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">职称</label>
								<div class="controls">

									<select name="title" id="title">
										<option value="高级"
											<c:if test="${useraccount.title=='高级'}">selected="selected" </c:if>>高级</option>
										<option value="中级"
											<c:if test="${useraccount.title=='中级'}">selected="selected" </c:if>>中级
										</option>
										<option value="初级"
											<c:if test="${useraccount.title=='初级'}">selected="selected" </c:if>>
											初级</option>
										<option value="技术员"
											<c:if test="${useraccount.title=='技术员'}">selected="selected" </c:if>>
											技术员</option>
										<option value="推广研究员"
											<c:if test="${useraccount.title=='推广研究员'}">selected="selected" </c:if>>推广研究员</option>
										<option value="无技术职称"
											<c:if test="${useraccount.title=='无技术职称'}">selected="selected" </c:if>>无技术职称</option>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">专业</label>
								<div class="controls">
									<input type="text" name="speciality"
										value="${useraccount.speciality}" data-required="1"
										class="span8 m-wrap" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">地址</label>
								<div class="controls">
									<input type="text" name="address"
										value="${useraccount.address}" data-required="1"
										class="span8 m-wrap" />
								</div>
							</div>
							<%-- <div class="control-group">
										<label class="control-label">排序号<span class="required">*</span>
										</label>
										<div class="controls">
											<input type="text" name="seq" value="${useraccount.seq}"
												data-required="1" class="span8 m-wrap" />
										</div>
									</div> --%>
							<%-- <div class="control-group">
										<label class="control-label">系统标识
										</label>
										<div class="controls">
											<select name="systemId" id="systemId">
											<c:forEach items="${appList}" var="app" varStatus="status">
												<option value="${app.appName}"  <c:if test="${useraccount.systemId==app.appName}">selected="selected" </c:if>>${app.appName}</option>
											</c:forEach>
											</select>
										</div>
									</div> --%>
							<div class="control-group">
								<label class="control-label">权限<span class="required"></span>
								</label>
								<div class="controls">
									<label class="radio line red"> <input type="checkbox"
										name="isadmin" value="true"
										<c:if test="${isadmin}">  checked="checked" </c:if> /> 机构管理员<span
										style="font-size: 12px;color: red;">
											(机构管理员可增删改本级用户和下级用户)</span></label>
									<div id="enabled_error"></div>
								</div>
							</div>
							<c:if test="${mode=='edit'}">
								<div class="form-actions" id="listApp"></div>
							</c:if>
							<div class="form-actions">
								<c:if test="${mode=='edit'}">
									<button type="button" onclick="doTongBu();" class="btn green">同步更新</button>
									<!-- <button type="button" onclick="chooseRoles();"
											class="btn green">用户授权</button>-->
								</c:if>
								<c:if test="${mode=='new'}">
									<button type="submit" class="btn green">提交</button>
								</c:if>
								<button type="button" onclick="beBack();" class="btn">返回</button>
								<c:if test="${mode=='new'}">
									<div style="color: red;">提示:
										提交后需完成同步更新及用户授权，此新建用户方可通过单点登录访问业务系统</div>
								</c:if>
								<c:if test="${mode=='edit'}">
									<div style="color: red;">提示: 完成同步更新及用户授权后，此新建用户方可通过单点登录访问业务系统</div>

								</c:if>
							</div>
						</form>
						<!-- END FORM-->
					</div>

				</div>

			</div>

		</div>
	</div>
</div>
<!-- END PAGE -->
<!-- BEGIN FOOTER -->
<%@include file="../include/foot.jsp"%>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../include/js.jsp"%>

<!-- BEGIN PAGE LEVEL PLUGINS -->

<script type="text/javascript"
	src="<%=basePath%>themes/media/js/jquery.validate.js"></script>

<script type="text/javascript"
	src="<%=basePath%>themes/media/js/additional-methods.min.js"></script>

<script type="text/javascript"
	src="<%=basePath%>themes/media/js/select2.min.js"></script>

<script type="text/javascript"
	src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>themes/media/js/bootstrap-fileupload.js"></script>
<script type="text/javascript"
	src="${root}/themes/platform/js/ajaxfileupload.js"></script>
<script type="text/javascript"
	src="<%=basePath%>themes/lhgdialog/lhgdialog.min.js${dialog_css}"></script>
<script type="text/javascript"
	src="${root}/themes/platform/js/metro.layout.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<script type="text/javascript">
	function ajaxFileUpload(id) {
		$.ajaxFileUpload({
			url : '${root}/useraccount/upload',
			secureuri : false,
			fileElementId : id,
			dataType : 'text',
			success : function(data, status) {
				if (data != "error") {
					$("#headpic").attr("src", data.split(",")[0]);
					$("#imgid").val(data.split(",")[1]);
				}
			},
			error : function(data, status, e) {
				alert(e);
			}
		});
	}
</script>
<script>
	function beBack() {
		var truthBeTold = window.confirm("${(mode=='edit')?'确认已完成用户授权，完成用户授权后才能通过单点登录进入业务系统':'返回将放弃本次操作'}");
		if(!truthBeTold) return false;
		var orgid = $("#orgid").val();
		window.location.href = "${root}/orgAndUser/listUsers?orgid=" + orgid;
	}
</script>
<script>
jQuery.validator.addMethod("isPassword", function(value, element) {    
    var tel = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*()_+`\-={} :";'<>?,.\/]).{8,30}$/;
    return this.optional(element) || (tel.test(value));
}, "必须字母数字符号汇合且大于8位");
jQuery.validator.addMethod("equelTo", function(value, element,param) {    
    var eqto = $(param).val();
    return this.optional(element) || (eqto==value);
}, "两次必须相同");

	jQuery(document).ready(
			function() {

				var form = $('#format_form');
				var error = $('#alert-error');
				var success = $('#alert-success');

				form.validate({
					errorElement : 'span', //default input error message container
					errorClass : 'help-inline', // default input error message class
					focusInvalid : false, // do not focus the last invalid input
					ignore : "",
					rules : {
						name : {
							required : true
						},
						loginname : {
							required : true,
							remote : {
								type : "post",
								url : "${root}/checkunique",
								data : {
									param : function() {
										return $("#loginname").val();
									},
									name : "loginname"
								},
								dataType : "html",
								dataFilter : function(data, type) {
									if (data == "y")
										return true;
									else
										return false;
								}
							}
						},
						enabled : {
							required : true
						},
						password : {
							required : true,
							isPassword:true
						},
						cpassword : {
							required : true,
							equelTo : "#password"
						},
						email : {
							email : true
						}
					},

					messages : { // custom messages for radio buttons and checkboxes
						name : {
							required : "请输入角色名称"
						},
						loginname : {
							required : "请输入登录名",
							remote : "用户名已被注册"
						},
						enabled : {
							required : "请选择"
						},
						password : {
							required : "请输入密码",
							isPassword:"密码必须字母数字符号汇合且大于8位"
						},
						cpassword : {
							required : "请再次输入密码",
							equelTo : "两次密码不一致"
						},
						email : {
							email : "邮箱格式不正确"
						}
					},

					errorPlacement : function(error, element) { // render error placement for each input type
						if (element.attr("name") == "enabled") { // for uniform checkboxes, insert the after the given container
							error.addClass("no-left-padding").insertAfter(
									"#enabled_error");
						} else {
							error.insertAfter(element); // for other inputs, just perform default behavoir
						}
					},

					invalidHandler : function(event, validator) { //display error alert on form submit   
						success.hide();
						error.show();
						App.scrollTo(error, -200);
					},

					highlight : function(element) { // hightlight error inputs
						$(element).closest('.help-inline').removeClass('ok'); // display OK icon
						$(element).closest('.control-group').removeClass(
								'success').addClass('error'); // set error class to the control group
					},

					unhighlight : function(element) { // revert the change dony by hightlight
						$(element).closest('.control-group').removeClass(
								'error'); // set error class to the control group
					},

					success : function(label) {
						label.addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
						.closest('.control-group').removeClass('error')
								.addClass('success'); // set success class to the control group
					},

					submitHandler : function(form) {
						success.show();
						error.hide();
						form.submit();
					}

				});

				App.handleNavInit("1403974160213");
			});
	function opendg(dgurl) {
		$.dialog({
			title : '',
			width : 800,
			height : 500,
			max : false,
			min : false,
			lock : true,
			content : 'url:' + dgurl
		});
	}

	$(document)
			.ready(
					function() {
						if ('${mode}' == 'edit') {
							$
									.ajax({
										type : 'post',
										url : '${root}/syn/loadAppInfo',
										data : {
											userAccountCode : '${useraccount.code}'
										},
										dataType : 'html',
										success : function(data) {
											var app_array = $.parseJSON(data); // 把字串轉換成 JSON array 
											var html = "<table><tr>";
											$
													.each(
															app_array,
															function(index, app) {
																var checked = "";
																var hidden = "";
																if (app.hidden) {
																	hidden = " hidden=\"true\" ";
																}
																if (app.status == "1") {
																	checked = " checked =\"checked\"";
																}
																html += "<td style=\"vertical-align: middle;\" "+hidden+"><input type=\"checkbox\" "
							+checked
							+"class=\"checkboxes\" name=\"checkboxes\" value=\""+app.appId+"\"/>"
																		+ app.appName
																		+ "</td>";
															});
											$("#listApp").html(
													html + "</tr></table>");
										}
									});
						}
					});
	function getcheckedids() {
		var ids = [];
		var cbs = document.getElementsByName("checkboxes");
		for (var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked == true) {
				//ids.push(cbs[i].value);
				ids.push("'" + cbs[i].value + "'");
			}
		}
		return ids;
	}
	var modalCheck;
	function checkTongBu() {
		var appCheckList = getcheckedids();
		$("#appCheckList").val(appCheckList);
		/* var height=500;
		var width=600;
		var aa=window.showModalDialog('${root}/synuser/checkTongBu?appCheckList='+appCheckList+'&usercode=${useraccount.code}',window,'dialogHeight='+height+',dialogWidth='+width);
		window.location.reload(); */
		modalCheck = $.MetroLayout({
			contentId : "editPop",
			title : "同步提示",
			width : 900,
			height : 500
		});
		modalCheck.$content.load('${root}/synuser/checkTongBu?appCheckList='
				+ appCheckList + '&usercode=${useraccount.code}');
	}
	function doTongBu() {
		//App.blockUI($('body'));
		var br = window
				.open(
						'',
						'',
						'height=500, width=900, top=50, left=200,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no');
		var appCheckList = getcheckedids();
		$("#appCheckList").val(appCheckList);
		$
				.ajax({
					cache : true,
					type : "POST",
					url : '${root}/synuser/ajaxsave',
					data : $('#format_form').serialize(),// 你的formid
					dataType : 'json',
					async : false,
					error : function(request) {
						alert("Connection error");
						br.close();
					},
					success : function(data) {
						//             	var height=500;
						//          		var width=600;
						//          		window.showModalDialog('${root}/synuser/synUserResult?result='+encodeURI(data),window,'dialogHeight='+height+',dialogWidth='+width);
						/*  modalResult = $.MetroLayout({
							contentId : "res",
							title : "同步结果",
							width : 900,
							height : 500
						});
						modalResult.$content.load('${root}/synuser/synUserResult?result='+encodeURI(data.resultlist)); */
						if (data[0].status == '1') {
							var result = "操作成功";
							var list = data[0].resultList;
							var closeopen = true;
							for (var i = 0; i < list.length; i++) {
								var app = list[i];
								//alert(app);
								if (app.result == '同步成功') {
									//result+="点击确认,对同步成功的系统进行授权\n\n";
									closeopen = false;
									break;
								}
							}
							if (closeopen) {
								br.close();
							}
							//alert(result);
							for (var i = 0; i < list.length; i++) {
								var app = list[i];
								//alert(app);
								if (app.result == '同步成功') {
									var height = 500;
									var width = 600;
									br.location = '${root}/synuseraccount/ssoServiceBySession?xtbs='
											+ app.appCode
											+ '&TYPE='
											+ data[0].type
											+ '&ID='
											+ data[0].id;
									//window.open('${root}/synuseraccount/ssoServiceBySession?xtbs='+app.appCode+'&TYPE='+data[0].type+'&ID='+data[0].id,'800','600');
								}
							}
							//alert(result);
							beBack();
						} else {
							var result = "";
							var list = data[0].resultList;
							//alert(list);
							for (var i = 0; i < list.length; i++) {
								var app = list[i];
								//alert(app);
								if (app.result != '无操作') {
									result += "" + app.appName + " - "
											+ app.opType + " -> " + app.result
											+ "\n\n";
								}
							}
							var closeopen = true;
							for (var i = 0; i < list.length; i++) {
								var app = list[i];
								//alert(app);
								if (app.result == '同步成功') {
									//result+="点击确认,对同步成功的系统进行授权\n\n";
									closeopen = false;
									break;
								}
							}
							if (closeopen) {
								br.close();
							}
							for (var i = 0; i < list.length; i++) {
								var app = list[i];
								//alert(app);
								if (app.result == '同步成功') {
									br.location = '${root}/synuseraccount/ssoServiceBySession?xtbs='
											+ app.appCode
											+ '&TYPE='
											+ data[0].type
											+ '&ID='
											+ data[0].id;
									//window.open('${root}/synuseraccount/ssoServiceBySession?xtbs='+app.appCode+'&TYPE='+data[0].type+'&ID='+data[0].id);
								}
							}
							alert(result);
						}

					}
				});
	}
	var modalResult;

	function getallids() {
		var ids = [];
		var cbs = document.getElementsByName("checkboxes");
		for (var i = 0; i < cbs.length; i++) {
			ids.push("'" + cbs[i].value + "'");
		}
		return ids;
	}
	var modal;
	function chooseRoles() {
		var ids = getcheckedids();
		//var height=500;
		//var width=600;
		//var aa=window.showModalDialog('${root}/synuser/showAppList?ids='+ids+'&userid=${useraccount.code}',window,'dialogHeight='+height+',dialogWidth='+width);
		modal = $.MetroLayout({
			contentId : "editPop",
			title : "编辑",
			width : 900,
			height : 500
		});
		modal.$content.load('${root}/synuser/showAppList?ids=' + ids
				+ '&userid=${useraccount.code}');

	}
</script>

<!-- END JAVASCRIPTS -->
</html>

