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
<title>区划管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">表单</div>
							<div class="portlet-body">
								<form action="${root}/division/save" method="post"
									id="format_form" class="form-horizontal">
									<div class="alert alert-error hide">

										<button class="close" data-dismiss="alert"></button>

										表单填写不正确，请仔细核查。

									</div>

									<div class="alert alert-success hide">

										<button class="close" data-dismiss="alert"></button>

										提交成功，等待跳转！

									</div>
									<input type="hidden" name="id" value="${org.id}" /> <input
										type="hidden" name="parentid" value="${parentid}" /> <input
										type="hidden" id="appCheckList" name="appCheckList" value="" />
									<div class="control-group">

										<label class="control-label">区划全称<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" name="fullName" data-required="1"
												value="${org.fullName}" class="span10 m-wrap" />

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">区划名称<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" name="name" data-required="1"
												value="${org.name}" class="span10 m-wrap" />

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">区划代码<span
											class="required">*</span>
										</label>

										<div class="controls">

											<input type="text" name="code" data-required="1"
												value="${org.code}" class="span10 m-wrap" />

										</div>

									</div>
									<div class="control-group">

										<label class="control-label">级别<span class="required">*</span>
										</label>
										<div class="controls">
											<select name="type" id="type">
												<option value="0"
													<c:if test="${org.type=='0'}">selected="selected" </c:if>>中央</option>
												<option value="1"
													<c:if test="${org.type=='1'}">selected="selected" </c:if>>省级</option>
												<option value="2"
													<c:if test="${org.type=='2'}">selected="selected" </c:if>>直辖市</option>
												<option value="3"
													<c:if test="${org.type=='3'}">selected="selected" </c:if>>计划单列市</option>
												<option value="4"
													<c:if test="${org.type=='4'}">selected="selected" </c:if>>市级</option>
												<option value="5"
													<c:if test="${org.type=='5'}">selected="selected" </c:if>>区县</option>
												<option value="6"
													<c:if test="${org.type=='6'}">selected="selected" </c:if>>乡镇</option>
												<option value="7"
													<c:if test="${org.type=='7'}">selected="selected" </c:if>>村</option>
											</select>
										</div>
									</div>
									<div class="control-group">

										<label class="control-label">所属大区<span
											class="required">*</span>
										</label>
										<div class="controls">
											<select name="bigDivision" id="bigDivision">
												<option value="1"
													<c:if test="${org.bigDivision=='1'}">selected="selected" </c:if>>华北</option>
												<option value="2"
													<c:if test="${org.bigDivision=='2'}">selected="selected" </c:if>>东北</option>
												<option value="3"
													<c:if test="${org.bigDivision=='3'}">selected="selected" </c:if>>华东</option>
												<option value="4"
													<c:if test="${org.bigDivision=='4'}">selected="selected" </c:if>>华中</option>
												<option value="5"
													<c:if test="${org.bigDivision=='5'}">selected="selected" </c:if>>西南</option>
												<option value="6"
													<c:if test="${org.bigDivision=='6'}">selected="selected" </c:if>>西北</option>
												<option value="7"
													<c:if test="${org.bigDivision=='7'}">selected="selected" </c:if>>华南</option>
												<option value="8"
													<c:if test="${org.bigDivision=='8'}">selected="selected" </c:if>>港澳台地区</option>
												<option value="9"
													<c:if test="${org.bigDivision=='9'}">selected="selected" </c:if>>兵团</option>
											</select>
										</div>
									</div>
									<div class="control-group">

										<label class="control-label">等级<span class="required">*</span>
										</label>
										<div class="controls">
											<select name="level" id="level">
												<option value="0"
													<c:if test="${org.level=='0'}">selected="selected" </c:if>>0</option>
												<option value="1"
													<c:if test="${org.level=='1'}">selected="selected" </c:if>>1</option>
												<option value="2"
													<c:if test="${org.level=='2'}">selected="selected" </c:if>>2</option>
												<option value="3"
													<c:if test="${org.level=='3'}">selected="selected" </c:if>>3</option>
												<option value="4"
													<c:if test="${org.level=='4'}">selected="selected" </c:if>>4</option>
												<option value="5"
													<c:if test="${org.level=='5'}">selected="selected" </c:if>>5</option>
											</select>
										</div>

									</div>
									<div class="control-group">

										<label class="control-label">排序号<span class="required">*</span>
										</label>
										<div class="controls">

											<input type="text" name="seq" value="${org.seq}"
												data-required="1" value="${org.seq}" class="span10 m-wrap" />

										</div>

									</div>
									<c:if test="${not empty org.id}">
										<div class="form-actions" id="listApp"></div>
									</c:if>
									<div class="form-actions">
										<c:if test="${empty org.id}">
											<button type="submit" class="btn green">提交</button>
										</c:if>
										<c:if test="${not empty org.id}">
											<button type="button" onclick="checkTongBu();"
												class="btn green">同步</button>
										</c:if>
										<button type="button" onclick="closewin()" class="btn">关闭</button>

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
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../include/js.jsp"%>
<script type="text/javascript"
	src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
<script type="text/javascript"
	src="<%=basePath%>themes/media/js/additional-methods.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>themes/lhgdialog/lhgdialog.min.js${dialog_css}"></script>
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
<script>
	jQuery(document).ready(
			function() {
				App.handleNavInit("3");
				var form = $('#format_form');
				var error = $('.alert-error', form);
				var success = $('.alert-success', form);

				form.validate({
					errorElement : 'span', //default input error message container
					errorClass : 'help-inline', // default input error message class
					focusInvalid : false, // do not focus the last invalid input
					ignore : "",
					rules : {
						name : {
							required : true
						},
						code : {
							required : true
						},
						seq : {
							required : true
						}
					},

					messages : { // custom messages for radio buttons and checkboxes
						name : {
							required : "请输入区划名称"
						},
						code : {
							required : "请输入区划代码"
						},
						seq : {
							required : "请输入排序号"
						}
					},

					errorPlacement : function(error, element) { // render error placement for each input type                   
						error.insertAfter(element); // for other inputs, just perform default behavoir
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
			});
	function closewin() {
		var api = frameElement.api, W = api.opener; // api.opener 为载加lhgdialog.min.js文件的页面的window对象
		api.close();
	}
</script>
<script>
	$(document)
			.ready(
					function() {
						$
								.ajax({
									type : 'post',
									url : '${root}/syndivision/loadAppInfo',
									data : {
										divisionId : '${org.id}'
									},
									dataType : 'html',
									success : function(data) {
										var app_array = $.parseJSON(data); // 把字串轉換成 JSON array 
										var html = "<table><tbody>";
										$
												.each(
														app_array,
														function(index, app) {
															if (app.status == "1") {
																html += "<td style=\"vertical-align: middle;\"><input type=\"checkbox\" checked=\"checked\" class=\"checkboxes\" name=\"checkboxes\" value=\""+app.appId+"\"/>"
																		+ app.appName
																		+ "</td>";
															} else {
																html += "<td style=\"vertical-align: middle;\"><input type=\"checkbox\" class=\"checkboxes\" name=\"checkboxes\" value=\""+app.appId+"\"/>"
																		+ app.appName
																		+ "</td>";
															}
														});
										$("#listApp").html(
												html + "</tbody></table>");
									}
								});
					});
	function getcheckedids() {
		var ids = [];
		var cbs = document.getElementsByName("checkboxes");
		for (var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked == true) {
				ids.push(cbs[i].value);
			}
		}
		return ids;
	}
	var checkModal;
	function checkTongBu() {
		var appCheckList = getcheckedids();
		$("#appCheckList").val(appCheckList);
		var height = 550;
		var width = 700;
		/*myShowModalDialog('${root}/syndivision/checkTongBu?appCheckList=' + appCheckList
				+ '&divisionId=${org.id}','',width,height);*/
		 window.showModalDialog(
				'${root}/syndivision/checkTongBu?appCheckList=' + appCheckList
						+ '&divisionId=${org.id}', window, 'dialogHeight='
						+ height + ',dialogWidth=' + width); 
		//var api = frameElement.api, W = api.opener; // api.opener 为载加lhgdialog.min.js文件的页面的window对象
		//W.refreshorgtree();
		//api.close(); 
		//checkModal = opendg('${root}/syndivision/checkTongBu?appCheckList=' + appCheckList
		//		+ '&divisionId=${org.id}',width,height);
	}
	var tongbuModal;
	function doTongBu() {
		var height = 550;
		var width = 700;
		//var modalr = window.showModalDialog('', window, 'dialogHeight=' + height + ',dialogWidth=' + width);
		$
				.ajax({
					cache : true,
					type : "POST",
					url : '${root}/syndivision/ajaxsave',
					data : $('#format_form').serialize(),// 你的formid
					dataType : 'html',
					async : false,
					error : function(request) {
						console.log(request);
						alert("Connection error"+request);
						//modalr.close();

					},
					success : function(data) {
						//modalr.location = '${root}/syndivision/synDivisionResult?result='+ encodeURI(data);
						/* var height=500;
						var width=600; */
						window.showModalDialog('${root}/syndivision/synDivisionResult?result='+encodeURI(data),window,'dialogHeight='+height+',dialogWidth='+width);
						//tongbuModal = opendg('${root}/syndivision/synDivisionResult?result='+encodeURI(data),width,heiht);
					}
				});
	}
	//弹出框google Chrome执行的是open        
	function myShowModalDialog(url, args, width, height) {
		var tempReturnValue;
		if (navigator.userAgent.indexOf("Chrome") > 0) {
			var paramsChrome = 'height='
					+ height
					+ ', width='
					+ width
					+ ', top='
					+ (((window.screen.height - height) / 2) - 50)
					+ ',left='
					+ ((window.screen.width - width) / 2)
					+ ',toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no';
			window.open(url, "newwindow", paramsChrome);
		} else {
			var params = 'dialogWidth:' + width + 'px;dialogHeight:' + height
					+ 'px;status:no;dialogLeft:'
					+ ((window.screen.width - width) / 2) + 'px;dialogTop:'
					+ (((window.screen.height - height) / 2) - 50) + 'px;';
			tempReturnValue = window.showModalDialog(url, args, params);
		}
		return tempReturnValue;
	}
	function opendg(dgurl, dgw, dgh,zIndex) {
		return $.dialog({
			title : '',
			width : dgw,
			height : dgh,
			lock : true,
			max : false,
			min : false,
			left: '60%',				// X轴坐标
			top: '38.2%',	
			zIndex: zIndex==undefined?'1999':zIndex,
			id : 'menupop',
			content : 'url:' + dgurl
		});
	}
	//var modalResult;
</script>
</html>
