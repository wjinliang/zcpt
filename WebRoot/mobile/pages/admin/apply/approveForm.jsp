<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>审批申请</title>
<link rel="stylesheet"
	href="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<script src="<%=basePath%>themes/jquery-mobile/jquery-1.10.2.min.js"></script>
<script src="<%=basePath%>themes/jquery-mobile/js/index.js"></script>
<script
	src="<%=basePath%>themes/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
	<div data-role="page">
		<script>
			function submitForm() {
				document.approveForm.submit();
			}
		</script>
		<div data-role="header" data-position="fixed" data-theme="a">
			<h1>审批申请</h1>
			<a href="javascript:window.history.back();" rel="external" data-shadow="false"
				data-iconshadow="false"
				class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-icon-carat-l ui-btn-icon-left">返回</a>
			<c:if test="${d:aPable(apply.applyId)}">
				<a href="javascript:submitForm()"
					class="ui-btn ui-btn-right ui-corner-all ui-shadow ui-icon-check ui-btn-icon-left">确认</a>
			</c:if>
		</div>
		<div role="main" class="ui-content">
			<div>
				<ul data-role="listview" data-inset="true">
					<li><h2>申请内容</h2>
					</li>
					<li data-role="list-divider">${apply.applyDate}</li>
					<li>
						<h2>${d:gName(apply.applyUserId)}</h2>
						<p>
							申请内容:<strong> ${apply.applyContent} </strong>
						</p>
						<p>
							总体审批情况:<strong> ${d:gDet(apply.applyId)}</strong>
						</p></li>
				</ul>
			</div>
			<div>
				<ul data-role="listview" data-inset="true">
					<li><h2>审批记录</h2>
					</li>
					<c:forEach items="${approves}" var="approve">
						<li data-role="list-divider">${approve.approveDate}</li>
						<li>
							<h2>${d:gName(approve.approveUserId)}（${d:gLName(approve.approveUserId)}）</h2>
							<p>
								结果:<strong> <c:if test="${approve.approveStatus=='1'}">同意
                     </c:if> <c:if test="${approve.approveStatus=='2'}">驳回
                     </c:if> </strong>
							</p>
							<p>
								意见:<strong> ${approve.approveComment}</strong>
							</p></li>
					</c:forEach>
				</ul>
			</div>
			<c:if test="${d:aPable(apply.applyId)}">
				<form name="approveForm" id="approveForm" method="post"
					action="${root}/apply/saveApprove" data-ajax="false">
					<input type="hidden" name="applyId" value="${apply.applyId}" /> <input
						type="hidden" name="applyObjType" value="${apply.applyObjType}">
						<input type="hidden" name="applyObjId" value="${apply.applyObjId}">
					<ul data-role="listview" data-inset="true">
						<li class="">
							<fieldset data-role="controlgroup" data-type="horizontal">
								<legend>是否同意</legend>
								<input type="radio" name="approveStatus" id="agree" value="1"
									checked="checked"> <label for="agree">同意</label> <input
									type="radio" name="approveStatus" id="disagree" value="2">
										<label for="disagree">驳回</label>      
							</fieldset></li>
						<li class=""><label for="approveComment">审批意见:</label> <textarea
								cols="40" rows="8" placeholder="请输入审批意见" name="approveComment"
								id="approveComment"></textarea></li>         
					</ul>
				</form>
			</c:if>
		</div>
		<div data-role="footer" data-position="fixed" data-theme="a">
			<p>Copyright 2014</p>
		</div>
	</div>
</body>
</html>
