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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery Mobile Framework</title>
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
	function hideLoading(){
		$.mobile.loading( "hide" );
	} 
	function showLoading(){
		$.mobile.loading( "show", {
					text: "执行中...",
					textVisible: true
		});
	} 
	function submitForm() {
		showLoading();
		document.newForm.submit();
	}
	function deleteItem(id) {
		showLoading();
		$.ajax({
			type : "POST",
			data : "exampleid=" + id,
			timeout : 8000, //超时时间设置，单位毫秒
			url : '${root}/example/delete',
			success : function(data) {
				if (data == "ok") {
					window.location.reload();
				}
			},
			complete : function(XMLHttpRequest,status){ 
　　　　			if(status=='timeout'){
　　　　　 				hideLoading();
　　　　			}
　　			}
		});
	}
</script>
		<div data-role="header" data-position="fixed" data-theme="a">
			<h1>示例</h1>
			<a href="<%=basePath%>mainpage" data-shadow="false"
				data-iconshadow="false" data-ajax="false"
				class="ui-btn ui-btn-left ui-corner-all ui-shadow ui-icon-home ui-btn-icon-left ui-btn-icon-notext"></a>
			<a href="<%=basePath%>example/form/new" data-ajax="false"
				class="ui-btn ui-btn-right ui-corner-all ui-shadow ui-icon-plus ui-btn-icon-left ui-btn-icon-notext"></a>
		</div>
		<div role="main" class="ui-content">
			<ul data-role="listview" data-theme="a" data-dividertheme="b"
				data-split-icon="minus" data-filter="true" data-filter-theme="a"
				data-filter-placeholder="搜索">
				<c:forEach items="${examples}" var="example">
					<li>
					<a href="<%=basePath%>example/form/edit?exampleid=${example.id}"
						data-ajax="false">${example.name}
					</a> 
					<a href="javascript:deleteItem('${example.id}')">删除</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div data-role="popup" id="popupNew" data-overlay-theme="a"
			class="ui-content" data-theme="a" style="min-width:250px;">
			<form class="userform" name="newForm" data-ajax="false"
				action="${root}/example/save" method="post">
				<label for="name">示例名称:</label>              <input type="text"
					name="name" id="name" data-clear-btn="true" data-mini="true">
				<div class="ui-grid-a">
					<a href="javascript:submitForm()"
						class="ui-btn ui-shadow ui-corner-all ui-btn-inline ui-btn-a ui-mini">保存</a>
					<a href="#" data-rel="back"
						class="ui-btn ui-shadow ui-corner-all ui-btn-inline ui-btn-a ui-mini">取消</a>
				</div>
			</form>
		</div>
		<div data-role="footer" data-position="fixed" data-theme="a">
			<p>Copyright 2014</p>
		</div>
	</div>
</body>
</html>
