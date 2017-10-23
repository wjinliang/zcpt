<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
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
<title>个人中心</title>
<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,chrome=1">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="./include/style.jsp"%>
<link href="<%=basePath%>themes/media/css/profile.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>themes/media/css/bootstrap-fileupload.css"
	rel="stylesheet" type="text/css" />
<link href="<%=basePath%>themes/media/css/chosen.css" rel="stylesheet"
	type="text/css" />
</head>
<!-- END HEAD -->

	<!-- BEGIN HEADER -->
	<%@include file="include/head.jsp"%>
	<!-- END HEADER -->
		<!-- BEGIN SIDEBAR -->
		<%@include file="include/sidebar.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<h3 class="page-title">
					${currentUser.name}&nbsp;<small>的个人中心</small>
				</h3>

				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${root}/syn/listSynApp">主页</a>

						<i class="icon-angle-right"></i></li>

					<li><a href="${root}/infoCenter">个人中心</a>
					</li>
				</ul>
				<div class="row-fluid profile">
					<div class="span12">

						<!--BEGIN TABS-->

						<div class="tabbable tabbable-custom tabbable-full-width">

							<ul class="nav nav-tabs">
								<!-- 
								<li class="active"><a href="#tab_1_1" data-toggle="tab">总体情况</a>
								</li>
 								-->
								<li class="active"><a href="#tab_1_2" data-toggle="tab">个人信息</a>
								</li>

								<li><a href="#tab_1_3" data-toggle="tab">信息设置</a>
								</li>
								<!-- 
								<li><a href="#tab_1_4" data-toggle="tab">平台帮助</a>
								</li>
 								-->
							</ul>

							<div class="tab-content">
								<!--end tab-pane-->

								<div class="tab-pane profile-classic row-fluid active" id="tab_1_2">
									<ul class="unstyled span12">

										<li><span>用户名:</span> ${currentUser.name}</li>

										<li><span>登录名:</span> ${currentUser.loginname}</li>

										<li><span>性别:</span> ${userAttr.gender}</li>

										<li><span>生日:</span> ${userAttr.birthDate}</li>

										<li><span>所在地:</span>${currentUser.address}</li>

										<li><span>电子邮箱:</span> <a href="#">${currentUser.email}</a>
										</li>

										<li><span>我的电话:</span> ${currentUser.mobile}</li>

										<li><span>个人简介:</span> ${userAttr.introduce}</li>

									</ul>

								</div>

								<!--tab_1_2-->

								<div class="tab-pane row-fluid profile-account" id="tab_1_3">

									<div class="row-fluid">

										<div class="span12">

											<div class="span3">

												<ul class="ver-inline-menu tabbable margin-bottom-10">

													<li class="active"><a data-toggle="tab"
														href="#tab_1-1"> <i class="icon-cog"></i> 个人信息 </a> <span
														class="after"></span></li>
													<li class=""><a data-toggle="tab" href="#tab_3-3"><i
															class="icon-lock"></i> 修改密码</a>
													</li>

												</ul>

											</div>

											<div class="span9">

												<div class="tab-content">

													<div id="tab_1-1" class="tab-pane active">

														<div style="height: auto;" id="accordion1-1"
															class="accordion collapse">

															<form action="${root}/useraccount/infoCenterUpdate"
																method="post">
																<input type="hidden" name="code"
																	value="${currentUser.code}" /> 
																	<label
																	class="control-label">用户名</label> 
																	<input type="text"
																	placeholder="用户名" name="name"
																	value="${currentUser.name}" class="m-wrap span8" /> 
																	<label
																	class="control-label">性别</label> 
																	<select id="gender"
																	  name="gender"
																	data-placeholder="请选择性别" >
																		<option
																			<c:if test="${userAttr.gender=='男'}">selected="selected"</c:if>
																			value="男">男</option>
																			<option
																			<c:if test="${userAttr.gender=='女'}">selected="selected"</c:if>
																			value="女">女</option>
																	</select> 
																	<label
																	class="control-label">出生日期</label> 
																	<input type="text"
																	id="birthDate" readonly="readonly"
																	placeholder="出生日期" name="birthDate"
																	value="${userAttr.birthDate}" class="m-wrap span3" />
																	<label
																	class="control-label">所在地</label> 
																	<input type="text"  placeholder="所在地" name="address"
																	value="${currentUser.address}" class="m-wrap span8" />
																	<label
																	class="control-label">联系电话</label> 
																	<input type="text"
																	placeholder="联系电话" name="mobile"
																	value="${currentUser.mobile}" class="m-wrap span8" />

																<label class="control-label">电子邮箱</label> 
																<input
																	type="text" placeholder="电子邮箱" name="email"
																	value="${currentUser.email}" class="m-wrap span8" /> 
																<label
																	class="control-label">关于我</label>

																<textarea name="introduce" class="span8 m-wrap" rows="3">${userAttr.introduce}</textarea>

																<div class="submit-btn">

																	<button type="submit" class="btn green">
																		更新</button>
																</div>

															</form>

														</div>

													</div>

													<div id="tab_2-2" class="tab-pane">

														<div style="height: auto;" id="accordion2-2"
															class="accordion collapse">

																<p><a href="javascript:opendg('${root}/useraccount/uploadHeadPic?userId=${currentUser.code}')" >
																	flash方式更改头像</a></p>

																<br />

																<div class="controls">

																	<div class="thumbnail span3"
																		>

																		<img src="${currentUser.headpic}" alt="当前头像"
																			class="span12" />

																	</div>

																</div>

														</div>

													</div>

													<div id="tab_3-3" class="tab-pane">
														<div style="height: auto;" id="accordion3-3" class="accordion collapse">
															<form id="password_form" action="${root}/useraccount/savepassword" method="post">
																<input type="hidden" name="useraccountid" value="${currentUser.code}"/>
																<div class="control-group">
																	<label class="control-label">当前密码 </label>
																	<div class="controls">
																		<input type="password" name="oldpassword" id="oldpassword"
																			class="m-wrap span6" />
																	</div>
																</div>
																<div class="control-group">
																	<label class="control-label">新的密码</label>
																	<div class="controls">
																		<input type="password" name="newpassword"
																	id="newpassword" class="m-wrap span6" />
																	</div>
																</div>
																<div class="control-group">
																	<label class="control-label">确认密码 </label>
																	<div class="controls">
																		<input
																	type="password" name="cpassword" id="cpassword"
																	class="m-wrap span6" />
																	</div>
																</div>
																<div class="clearfix"></div>

																<div class="space10"></div>
																<div class="submit-btn">
																	<button type="submit" class="btn green">
																		更新</button>
																</div>
															</form>
														</div>
													</div>
												</div>

											</div>

											<!--end span9-->

										</div>

									</div>

								</div>

								<div class="tab-pane row-fluid" id="tab_1_4">

									<div class="row-fluid">

										<div class="span12">

											<div class="span3">

												<ul class="ver-inline-menu tabbable margin-bottom-10">

													<li class="active"><a data-toggle="tab" href="#tab_1">

															<i class="icon-briefcase"></i> General Questions </a> <span
														class="after"></span></li>

													<li><a data-toggle="tab" href="#tab_2"><i
															class="icon-group"></i> Membership</a>
													</li>

													<li><a data-toggle="tab" href="#tab_3"><i
															class="icon-leaf"></i> Terms Of Service</a>
													</li>

													<li><a data-toggle="tab" href="#tab_1"><i
															class="icon-info-sign"></i> License Terms</a>
													</li>

													<li><a data-toggle="tab" href="#tab_2"><i
															class="icon-tint"></i> Payment Rules</a>
													</li>

													<li><a data-toggle="tab" href="#tab_3"><i
															class="icon-plus"></i> Other Questions</a>
													</li>

												</ul>

											</div>

											<div class="span9">

												<div class="tab-content">

													<div id="tab_1" class="tab-pane active">

														<div style="height: auto;" id="accordion1"
															class="accordion collapse">

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_1" data-parent="#accordion1"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Anim pariatur
																		cliche reprehenderit, enim eiusmod high life accusamus
																		terry ? </a>

																</div>

																<div class="accordion-body collapse in" id="collapse_1">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_2" data-parent="#accordion1"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Pariatur
																		cliche reprehenderit enim eiusmod highr brunch ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_2">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3" data-parent="#accordion1"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Food truck
																		quinoa nesciunt laborum eiusmod nim eiusmod high life
																		accusamus ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_3">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_4" data-parent="#accordion1"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> High life
																		accusamus terry richardson ad ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_4">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_5" data-parent="#accordion1"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Reprehenderit
																		enim eiusmod high life accusamus terry quinoa nesciunt
																		laborum eiusmod ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_5">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_6" data-parent="#accordion1"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Wolf moon
																		officia aute non cupidatat skateboard dolor brunch ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_6">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

														</div>

													</div>

													<div id="tab_2" class="tab-pane">

														<div style="height: auto;" id="accordion2"
															class="accordion collapse">

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_2_1" data-parent="#accordion2"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Cliche
																		reprehenderit, enim eiusmod high life accusamus enim
																		eiusmod ? </a>

																</div>

																<div class="accordion-body collapse in"
																	id="collapse_2_1">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_2_2" data-parent="#accordion2"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Pariatur
																		cliche reprehenderit enim eiusmod high life non
																		cupidatat skateboard dolor brunch ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_2_2">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_2_3" data-parent="#accordion2"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Food truck
																		quinoa nesciunt laborum eiusmod ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_2_3">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_2_4" data-parent="#accordion2"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> High life
																		accusamus terry richardson ad squid enim eiusmod high
																		? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_2_4">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_2_5" data-parent="#accordion2"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Reprehenderit
																		enim eiusmod high life accusamus terry quinoa nesciunt
																		laborum eiusmod ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_2_5">

																	<div class="accordion-inner">

																		<p>Anim pariatur cliche reprehenderit, enim
																			eiusmod high life accusamus terry richardson ad
																			squid. 3 wolf moon officia aute, non cupidatat
																			skateboard dolor brunch. Food truck quinoa nesciunt
																			laborum eiusmod. Brunch 3 wolf moon tempor.</p>

																		<p>moon officia aute, non cupidatat skateboard
																			dolor brunch. Food truck quinoa nesciunt laborum
																			eiusmodBrunch 3 wolf moon tempor</p>

																	</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_2_6" data-parent="#accordion2"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Wolf moon
																		officia aute non cupidatat skateboard dolor brunch ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_2_6">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_2_7" data-parent="#accordion2"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Reprehenderit
																		enim eiusmod high life accusamus terry quinoa nesciunt
																		laborum eiusmod ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_2_7">

																	<div class="accordion-inner">

																		<p>Anim pariatur cliche reprehenderit, enim
																			eiusmod high life accusamus terry richardson ad
																			squid. 3 wolf moon officia aute, non cupidatat
																			skateboard dolor brunch. Food truck quinoa nesciunt
																			laborum eiusmod. Brunch 3 wolf moon tempor.</p>

																		<p>moon officia aute, non cupidatat skateboard
																			dolor brunch. Food truck quinoa nesciunt laborum
																			eiusmodBrunch 3 wolf moon tempor</p>

																	</div>

																</div>

															</div>

														</div>

													</div>

													<div id="tab_3" class="tab-pane">

														<div style="height: auto;" id="accordion3"
															class="accordion collapse">

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3_1" data-parent="#accordion3"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Cliche
																		reprehenderit, enim eiusmod ? </a>

																</div>

																<div class="accordion-body collapse in"
																	id="collapse_3_1">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3_2" data-parent="#accordion3"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Pariatur
																		skateboard dolor brunch ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_3_2">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3_3" data-parent="#accordion3"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Food truck
																		quinoa nesciunt laborum eiusmod ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_3_3">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3_4" data-parent="#accordion3"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> High life
																		accusamus terry richardson ad squid enim eiusmod high
																		? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_3_4">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3_5" data-parent="#accordion3"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Reprehenderit
																		enim eiusmod high eiusmod ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_3_5">

																	<div class="accordion-inner">

																		<p>Anim pariatur cliche reprehenderit, enim
																			eiusmod high life accusamus terry richardson ad
																			squid. 3 wolf moon officia aute, non cupidatat
																			skateboard dolor brunch. Food truck quinoa nesciunt
																			laborum eiusmod. Brunch 3 wolf moon tempor.</p>

																		<p>moon officia aute, non cupidatat skateboard
																			dolor brunch. Food truck quinoa nesciunt laborum
																			eiusmodBrunch 3 wolf moon tempor</p>

																	</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3_6" data-parent="#accordion3"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Anim pariatur
																		cliche reprehenderit, enim eiusmod high life accusamus
																		terry ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_3_6">

																	<div class="accordion-inner">Anim pariatur cliche
																		reprehenderit, enim eiusmod high life accusamus terry
																		richardson ad squid. 3 wolf moon officia aute, non
																		cupidatat skateboard dolor brunch. Food truck quinoa
																		nesciunt laborum eiusmod. Brunch 3 wolf moon tempor.</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3_7" data-parent="#accordion3"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Reprehenderit
																		enim eiusmod high life accusamus aborum eiusmod ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_3_7">

																	<div class="accordion-inner">

																		<p>Anim pariatur cliche reprehenderit, enim
																			eiusmod high life accusamus terry richardson ad
																			squid. 3 wolf moon officia aute, non cupidatat
																			skateboard dolor brunch. Food truck quinoa nesciunt
																			laborum eiusmod. Brunch 3 wolf moon tempor.</p>

																		<p>moon officia aute, non cupidatat skateboard
																			dolor brunch. Food truck quinoa nesciunt laborum
																			eiusmodBrunch 3 wolf moon tempor</p>

																	</div>

																</div>

															</div>

															<div class="accordion-group">

																<div class="accordion-heading">

																	<a href="#collapse_3_8" data-parent="#accordion3"
																		data-toggle="collapse"
																		class="accordion-toggle collapsed"> Reprehenderit
																		enim eiusmod high life accusamus terry quinoa nesciunt
																		laborum eiusmod ? </a>

																</div>

																<div class="accordion-body collapse" id="collapse_3_8">

																	<div class="accordion-inner">

																		<p>Anim pariatur cliche reprehenderit, enim
																			eiusmod high life accusamus terry richardson ad
																			squid. 3 wolf moon officia aute, non cupidatat
																			skateboard dolor brunch. Food truck quinoa nesciunt
																			laborum eiusmod. Brunch 3 wolf moon tempor.</p>

																		<p>moon officia aute, non cupidatat skateboard
																			dolor brunch. Food truck quinoa nesciunt laborum
																			eiusmodBrunch 3 wolf moon tempor</p>

																	</div>

																</div>

															</div>

														</div>

													</div>

												</div>

											</div>

											<!--end span9-->

										</div>

									</div>

								</div>

								<!--end tab-pane-->

							</div>

						</div>

						<!--END TABS-->

					</div>

				</div>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	<!-- BEGIN FOOTER -->
	<%@include file="include/foot.jsp"%>
	<!-- END FOOTER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="include/js.jsp"%>
	<!-- END JAVASCRIPTS -->
	<script type="text/javascript"
		src="<%=basePath%>themes/media/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>themes/media/js/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=basePath%>themes/platform/js/lhgdialog/lhgdialog.min.js${dialog_css}"></script>
	<script type="text/javascript"
		src="<%=basePath%>themes/plugins/datePicker/laydate.dev.js"></script>
	<!-- END BODY -->
	<script>
	jQuery.validator.addMethod("isPassword", function(value, element) {    
	    var tel = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*()_+`\-={} :";'<>?,.\/]).{8,30}$/;
	    return this.optional(element) || (tel.test(value));
	}, "必须字母数字符号汇合且大于8位");
		jQuery(document).ready(
				function() {
					$('#password_form').validate(
							{
								errorElement : 'label', //default input error message container
								errorClass : 'help-inline', // default input error message class
								focusInvalid : false, // do not focus the last invalid input
								rules : {
									oldpassword : {
										required : true
									},
									newpassword : {
										required : true,
										isPassword:true
									},
									cpassword : {
										required : true,
										equalTo : "#newpassword"
									}
								},

								messages : {
									oldpassword : {
										required : "请输入当前密码"
									},
									newpassword : {
										required : "请输入新密码"
									},
									cpassword : {
										required : "请输入确认密码",
										equalTo : "两次密码不一致"
									}
								},

								highlight : function(element) { // hightlight error inputs
									$(element).closest('.help-inline')
											.removeClass('ok'); // display OK icon
									$(element).closest('.control-group')
											.removeClass('success').addClass(
													'error'); // set error class to the control group
								},

								unhighlight : function(element) { // revert the change dony by hightlight
									$(element).closest('.control-group')
											.removeClass('error'); // set error class to the control group
								},

								success : function(label) {
									label.addClass('valid').addClass(
											'help-inline ok') // mark the current input as valid and display OK icon
									.closest('.control-group').removeClass(
											'error').addClass('success'); // set success class to the control group
								},

								submitHandler : function(form) {
									form.submit();
								}
							});
				});
	laydate({
			elem : '#birthDate'
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
	</script>
</html>
