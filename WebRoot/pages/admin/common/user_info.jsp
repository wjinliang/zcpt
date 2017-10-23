<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
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
<title>查看用户</title>
<%@include file="../../include/meta.jsp"%>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-full-width page-header-fixed">
	<!-- BEGIN HEADER -->
	<%@include file="../../admin/include/head.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<%@include file="../../admin/include/sidebar.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<h3 class="page-title">个人信息</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i></li>
							<li><a>个人信息</a>
							</li>
						</ul>
					</div>
				</div>

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid profile">

					<div class="span12">

						<!--BEGIN TABS-->

						<div class="tabbable tabbable-custom tabbable-full-width">

							<div class="tab-content">

								<div class="tab-pane row-fluid active" id="tab_1_1">

									<ul class="unstyled profile-nav span3">

										<li><img src="${userInfo.headPic}"
											style="width:250px;height:250px;" alt="头像"  onerror="this.src='<%=basePath%>themes/media/image/avatar.png'" />
										</li>

									</ul>

									<div class="span9">

										<div class="row-fluid">

											<div class="span10 profile-info">

												<h1>${userInfo.userName}</h1>

												<ul class="unstyled">
													
													<li><i class="icon-tag"></i><span>登录名:</span> ${userInfo.loginName}</li>

													<li><i class="icon-tag"></i><span>真实姓名:</span> ${userInfo.realName}</li>
													
													<li><i class="icon-male"></i>性别：${dim:toName('dm_gender',userInfo.gender)}</li>

													<li><i class="icon-time"></i>教龄： ${userInfo.teachAge}</li>

													<li><i class="icon-tag"></i><span>教学职称:</span> ${userInfo.professional}</li>

													<li><i class="icon-tag"></i><span>教学初高中:</span>
														${dim:toName('kj_class_level',userInfo.classLevel)}</li>

													<li><i class="icon-tag"></i><span>教学学科:</span>
														${dim:toName('kj_subject_type',userInfo.subjectType)}</li>

													<li><i class="icon-tag"></i><span>教学年级课本:</span>
														${dim:toName('ttxw_teach_book',userInfo.textBook)}</li>

													<li><i class="icon-tag"></i><span>教学版本:</span>
														${dim:toName('KJ_EDITION',userInfo.materialType)}</li>

													<li><i class="icon-tag"></i><span>电子邮箱:</span> <a href="#">${userInfo.email}</a>
													</li>

													<li><i class="icon-tag"></i><span>qq :</span> ${userInfo.qq}</li>

													<li><i class="icon-tag"></i><span>电话:</span>${currentUser.mobilephone}</li>
													
													
													<li><i class="icon-map-marker"></i>所在地：${userInfo.location}</li>
	
													<li><i class="icon-map-marker"></i><span>详细地址:</span> ${userInfo.address}</li>

													<li><i class="icon-tag"></i><span>个人简介:</span> ${userInfo.introduce}</li>

												</ul>
											</div>

											<!--end span8-->

											<div class="span2">

												<div class="portlet sale-summary">

													<div class="portlet-title">

														<div class="caption" style="float: right;">
															<a href="javascript:window.history.back()" class="btn"><i
																class="icon-arrow-left"></i> 返回</a>
														</div>

													</div>

												</div>

											</div>

											<!--end span4-->

										</div>
										
										<div class="space10"></div>
										<div class="space10"></div>
										<!--end row-fluid-->

										<div class="tabbable tabbable-custom tabbable-custom-profile">

											<ul class="nav nav-tabs">

												<li class="active"><a href="#tab_1_11"
													data-toggle="tab">他的课件</a>
												</li>
												<li class=""><a href="#tab_1_12" data-toggle="tab">他的知识点</a>
												</li>
												<li class=""><a href="#tab_1_22" data-toggle="tab">他的活跃记录</a>
												</li>

											</ul>

											<div class="tab-content">

												<div class="tab-pane active" id="tab_1_11">

													<div class="portlet-body" style="display: block;">

														<table
															class="table table-striped table-bordered table-advance table-hover">

															<thead>

																<tr>

																	<th>#</th>

																	<th>课件名称</th>

																	<th>状态</th>

																	<th>查看</th>

																</tr>

															</thead>

															<tbody>
																<c:if test="${fn:length(kjList)==0}">
																	<tr>

																		<td colspan="4" style="text-align:center;">暂无数据</td>

																	</tr>
																</c:if>
																<c:forEach items="${kjList}" var="kjInfo"
																	varStatus="status">
																	<tr>

																		<td>${status.index}</td>

																		<td>${kjInfo.kjName}</td>

																		<td><span class="label label-success label-mini">${dim:toName("kj_publish_status",kjInfo.kjStatus)}</span>
																		</td>

																		<td><a class="btn mini green-stripe"
																			href="${root}/common/kjInfo/${kjInfo.kjId}">查看</a> <a
																			class="btn mini green-stripe"
																			href="${root}/common/approveInfo/${kjInfo.kjId}">申请审批记录</a>
																		</td>

																	</tr>
																</c:forEach>
															</tbody>

														</table>

													</div>

												</div>

												<div class="tab-pane" id="tab_1_12">

													<div class="portlet-body" style="display: block;">

														<table
															class="table table-striped table-bordered table-advance table-hover">

															<thead>

																<tr>

																	<th>#</th>

																	<th>知识点名称</th>

																	<th>状态</th>

																	<th>操作</th>

																</tr>

															</thead>

															<tbody>
																<c:if test="${fn:length(pointItemList)==0}">
																	<tr>

																		<td colspan="4" style="text-align:center;">暂无数据</td>

																	</tr>
																</c:if>
																<c:forEach items="${pointItemList}" var="pointItem"
																	varStatus="status">
																	<tr>

																		<td>${status.index}</td>

																		<td>${pointItem.itemName}</td>

																		<td><span class="label label-success label-mini">${dim:toName("kj_point_status",pointItem.itemStatus)}
																		</span>
																		</td>

																		<td><a class="btn mini green-stripe" href="#">查看</a>
																			<a class="btn mini green-stripe"
																			href="${root}/common/approveInfo/${pointItem.itemId}">申请审批记录</a>
																		</td>

																	</tr>
																</c:forEach>
															</tbody>

														</table>

													</div>

												</div>

												<!--tab-pane-->

												<div class="tab-pane" id="tab_1_22">

													<div class="tab-pane active" id="tab_1_1_1">

														<div class="scroller" data-height="290px"
															data-always-visible="1" data-rail-visible1="1">

															<ul class="feeds">

																<li>

																	<div class="col1">

																		<div class="cont">

																			<div class="cont-col1">

																				<div class="label label-success">

																					<i class="icon-bell"></i>

																				</div>

																			</div>

																			<div class="cont-col2">

																				<div class="desc">

																					You have 4 pending tasks. <span
																						class="label label-important label-mini">

																						Take action <i class="icon-share-alt"></i> </span>

																				</div>

																			</div>

																		</div>

																	</div>

																	<div class="col2">

																		<div class="date">Just now</div>

																	</div></li>



															</ul>

														</div>

													</div>

												</div>

												<!--tab-pane-->

											</div>

										</div>

									</div>

									<!--end span9-->

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
	</div>
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER -->
	<%@include file="../../admin/include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../../admin/include/js.jsp"%>
	<script>
		jQuery(document).ready(function() {

			//定位到当前导航栏，参数为菜单id;
			//App.handleNavInit("1417937493456");
		});
	</script>

	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</body>
</html>
