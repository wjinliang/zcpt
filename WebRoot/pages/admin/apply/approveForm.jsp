<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
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
<%@include file="../include/meta.jsp"%>
<title>审批表单</title>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/select2_metro.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/media/css/chosen.css" />
<link href="<%=basePath%>themes/media/css/timeline.css" rel="stylesheet"
	type="text/css" />
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
						<h3 class="page-title">审批信息</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="${root}/apply/list">审批 管理</a> <i
								class="icon-angle-right"></i></li>
							<li><a>审批信息</a></li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-reorder"></i>申请
								</div>
							</div>
							<div class="portlet-body form">

								<!-- BEGIN FORM-->

								<div class="form-horizontal form-view">

									<div class="row-fluid">

										<div class="span12 ">
											<h3 class="form-section">申请信息</h3>
											<div class="control-group">

												<label class="control-label" for="firstName">申请人</label>

												<div class="controls">

													<span class="text"><a href="${root}/common/userInfo/${apply.applyUserId}">${d:gName(apply.applyUserId)}</a></span>

												</div>

											</div>

											<div class="control-group">

												<label class="control-label">申请时间</label>

												<div class="controls">

													<span class="text">${apply.applyDate}</span>

												</div>

											</div>

											<div class="control-group">

												<label class="control-label">申请内容</label>

												<div class="controls">

													<span class="text"><a
													href="${root}/common/
													<c:if test="${apply.applyObjType=='5'||apply.applyObjType=='8'}">kjInfo/</c:if>
													<c:if test="${apply.applyObjType=='6'||apply.applyObjType=='9'}">pointItemInfo/</c:if>
													<c:if test="${apply.applyObjType=='1'||apply.applyObjType=='2'||apply.applyObjType=='3'}">userInfo/</c:if>
													${apply.applyObjId}"
													>${apply.applyContent}</a></span>

												</div>

											</div>

											<div class="control-group">

												<label class="control-label">总体审批情况</label>

												<div class="controls">

													<span class="text">${d:gDet(apply.applyId)}</span>

												</div>

											</div>

										</div>
									</div>
									<div class="row-fluid">
										<div class="span12">
											<h3 class="form-section">审批记录</h3>
											<ul class="timeline">
												<c:forEach items="${approves}" var="approve">
													<c:if test="${approve.approveStatus=='2'}">
															<li class="timeline-green">
															</c:if>
													<c:if test="${approve.approveStatus=='3'}">
															<li class="timeline-red">
													</c:if>
														<div class="timeline-time">
															<span class="date">${fn:substring(approve.approveDate, 0, 10)}</span>
															<span class="time">${fn:substring(approve.approveDate, 10, 19)}</span>
														</div>
														<div class="timeline-icon">
															<c:if test="${approve.approveStatus=='2'}">
															<i class="icon-ok" style="margin-top: 12px;"></i>
															</c:if>
															<c:if test="${approve.approveStatus=='3'}">
															<i class="icon-remove" style="margin-top: 12px;"></i>
															</c:if>
														</div>
														<div class="timeline-body">
															<h2>
															<c:if test="${approve.approveStatus=='2'}">
																同意
															</c:if>
															<c:if test="${approve.approveStatus=='3'}">
																驳回
															</c:if></h2>
															<div class="timeline-content">
																审批意见：${approve.approveComment}
															</div>

															<div class="timeline-footer">

																审批人：<a href="${root}/common/userInfo/${approve.approveUserId}">${d:gName(approve.approveUserId)}</a>

															</div>
														</div>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</div>

							</div>

						</div>
					</div>

				</div>
				<c:if test="${d:aPable(apply.applyId)}">
					<div class="row-fluid">
						<div class="span12">
							<div class="portlet box green">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-reorder"></i>审批
									</div>
								</div>
								<div class="portlet-body form">
									<form action="${root}/apply/saveApprove" method="post"
										id="format_form" class="form-horizontal">
										<input type="hidden" name="applyId" value="${apply.applyId}" />
										<input type="hidden" name="applyObjType"
											value="${apply.applyObjType}"> <input type="hidden"
											name="applyObjId" value="${apply.applyObjId}">
												<h3 class="form-section">审批</h3>
												<div class="control-group">

													<label class="control-label">审批选项</label>

													<div class="controls">

														<label class="radio line"> <input type="radio"
															name="approveStatus" checked="checked" value="2" /> 同意 </label>
														<label class="radio line"> <input type="radio"
															name="approveStatus" value="3" /> 驳回 </label>

													</div>

												</div>

												<div class="control-group">
													<label class="control-label">审批意见 </label>

													<div class="controls">
														<textarea class="large m-wrap" name="approveComment"
															rows="6"></textarea>
													</div>

												</div>
												<div class="form-actions">
													<button type="submit" class="btn green">确认</button>
													<button type="button" onclick="window.history.back();"
														class="btn ">
														<i class="icon-arrow-left"></i> 返 回
													</button>

												</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${!d:aPable(apply.applyId)}">
					<div class="row-fluid">
						<div class="span12">
							<div class="portlet box green">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-reorder"></i>返回
									</div>
								</div>
								<div class="portlet-body form">
									<div class="form-actions">
										<button type="button" onclick="window.history.back();"
											class="btn ">
											<i class="icon-arrow-left"></i> 返 回
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>
			</div>
			<!-- END PAGE CONTAINER-->
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

	<!-- END PAGE LEVEL PLUGINS -->
</html>
