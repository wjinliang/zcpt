<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim" %>
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
<title>字典管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<link rel="stylesheet"
	href="<%=basePath%>themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/media/css/bootstrap-toggle-buttons.css" />
<link rel="stylesheet"
	href="<%=basePath%>themes/plugins/rightContext/css/context.standalone.css"
	type="text/css">
<style>
div#rMenu {
	position: absolute;
	visibility: hidden;
	top: 0;
	text-align: center;
	padding: 2px;
}

div#rMenu ul li {
	cursor: pointer;
}
ul.ztree {
	height: 290px;
}
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
.ztree li span.button2{
	line-height:0; margin:0; width:16px; height:16px; display: inline-block; vertical-align:middle;
	border:0 none; cursor: pointer;outline:none;
	background-color:transparent; background-repeat:no-repeat; background-attachment: scroll;
}
.ztree li span.button2.up {
	background-image:url("<%=basePath%>themes/zTree/css/zTreeStyle/img/diy/arrow_up.png");
}
.ztree li span.button2.down {
	background-image:url("<%=basePath%>themes/zTree/css/zTreeStyle/img/diy/arrow_down.png");
}
.ztree li span.button2.edit {
	background-image:url("<%=basePath%>themes/zTree/css/zTreeStyle/img/diy/page_edit.png");
}
.ztree li span.button2.add {
	background-image:url("<%=basePath%>themes/zTree/css/zTreeStyle/img/diy/page_add.png");
}
.ztree li span.button2.delete {
	background-image:url("<%=basePath%>themes/zTree/css/zTreeStyle/img/diy/page_delete.png");
}
.ztree li span.button2.view {
	background-image:url("<%=basePath%>themes/zTree/css/zTreeStyle/img/diy/page.png");
}

</style>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body onload="refreshDictCache('${dictId}');">
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
							字典管理管理 
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="<%=basePath%>mainpage">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><i class="icon-home"></i> <a href="<%=basePath%>dict/list">字典管理</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a>管理</a></li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span6">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>字典树
								</div>
								<div class="actions">
									<a href="javascript:expandAll(true)" class="btn blue"><i class="icon-plus"></i> 展开所有</a>
									<a href="javascript:expandAll(false)" class="btn yellow"><i class="icon-minus"></i> 折叠所有</a>
								</div>
							</div>
							<div class="portlet-body">
								<div id="alert" class="alert alert-success hide">

										<button class="close" data-dismiss="alert"></button>

										操作成功！

								</div>
							<div class="scroller" data-height="300px"  data-always-visible="1" data-rail-visible="1">
								<ul id="treeItem" class="ztree"></ul>
							</div>
							<div class="space10"></div>

							<span class="label label-important">注意!</span>

							<span>

								菜单树点击右键试试看:)

							</span>
							<div class="space10"></div>
							<span>
							<select id="select1" class="medium  m-wrap"  tabindex="1" onchange="getSub('select2','select1')" onclick="getSub('select2','select1')">
								<option value=''>请选择</option>
							</select>
							<select id="select2" class="medium  m-wrap"  tabindex="1">
								<option value=''>请选择</option>
							</select>
							</span>
							<div class="space10"></div>
							<div class="form-actions form-horizontal" >
								<a href="javascript:refreshDictCache('${dictId}')" class="btn blue" style="display:none"><i class="icon-refresh"></i> 刷新缓存</a>
								<a href="javascript:window.history.back();" class="btn blue"><i class="icon-arrow-left"></i> 返回</a>
							</div>
							<div class="space10"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="rMenu">
			<ul class="dropdown-menu dropdown-context">
				<li class="nav-header" id="m_add" onclick="addMenu();">增加子级菜单</li>
				<li class="nav-header" id="m_addroot" onclick="addTopMenu();">增加顶级菜单</li>
				<li class="nav-header" id="m_del" onclick="deleteItem();">删除菜单</li>
				<li class="nav-header" id="m_edit" onclick="editMenu();">编辑菜单</li>
			</ul>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	<!-- BEGIN FOOTER -->
	<%@include file="../include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../include/js.jsp"%>
	<script type="text/javascript" src="<%=basePath%>themes/lhgdialog/lhgdialog.min.js${dialog_css}"></script>
	<script type="text/javascript"
	src="<%=basePath%>themes/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript"
	src="<%=basePath%>themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	<script type="text/javascript" src="<%=basePath%>themes/zTree/js/jquery.ztree.exedit-3.5.js"></script>		
<script>
$(document).ready(function() {
	getFirstlist('select1');
	App.handleNavInit("1404211232034");
});
var json = eval('${dim:json(dictId)}');
function getFirstlist(domId){
	var options="<option value=\"\">请选择</option>";
	if(json!=null){
		for(var i = 0;i<json.length;i++){
	 		if(json[i].pid==0){
	 			options+="<option title='"+json[i].id+"' value='"+json[i].itemCode+"'>"+json[i].itemName+"</option>"
	 		}
		}
	}
	$("#"+domId).html(options);
}
function getSub(domId,itemId){
	var id = $('#'+itemId).find("option:selected").attr("title");
	var options="";
	for(var i = 0;i<json.length;i++){
	 	if(json[i].pid==id){
	 		options+="<option title='"+json[i].id+"' value='"+json[i].itemCode+"'>"+json[i].itemName+"</option>"
	 	}
	}
	if(options==""){
		options="<option value=\"\">请选择</option>";
	}
	$("#"+domId).html(options);
}
</script>

<script type="text/javascript">
	var zTree;
	var rMenu;
	$(document).ready(function() {
		$.fn.zTree.init($("#treeItem"), settingItem, "");
		zTree = $.fn.zTree.getZTreeObj("treeItem");
		zTree.setting.edit.drag.isCopy = false;
		zTree.setting.edit.drag.isMove = true;
		zTree.setting.edit.drag.prev = true;
		zTree.setting.edit.drag.inner = true;
		zTree.setting.edit.drag.next = true;
		rMenu = $("#rMenu");
		$('[data-form=uniform]').uniform();
	});
	var settingItem = {
		view: {
				addHoverDom: addHoverDom,
				showIcon : false,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},
		edit: {
				enable: false,
				showRemoveBtn: false,
				showRenameBtn: false
		},
		check:{
			enable : false
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		async : {
			enable : true,
			dataType : "text",
			url : "${root}/dict/load/${dictId}",
			autoParam : [ "id", "name", "pId","drag" ]
		},
		callback : {
			onRightClick : OnRightClick,
			onDrop: onDrop,
			beforeDrag: beforeDrag,
			beforeDrop: beforeDrop,
			onAsyncSuccess: expandAllNode
		}
	};
	function expandAllNode(){
		zTree.expandAll(true);
	}
	function setDargable(flag){
		if(!flag){
			flag=true;
		}
		var fl = document.getElementById("isdrag").checked;
		return fl;
	}
	function changeGrag(){
		var fl = document.getElementById("isdrag").checked;
		zTree.setting.edit.enable=fl;
	}
	function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr ="<span class='button2 add' id='addBtn_" + treeNode.tId
				+ "' title='增加子级节点' onfocus='this.blur();'></span>"+
				"<span class='button2 edit' id='editBtn_" + treeNode.tId
				+ "' title='编辑节点' onfocus='this.blur();'></span>"+
				"<span class='button2 view' id='viewBtn_" + treeNode.tId
				+ "' title='查看节点' onfocus='this.blur();'></span>"+
				"<span class='button2 delete' id='removeBtn_" + treeNode.tId
				+ "' title='删除节点' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				zTree.selectNode(treeNode);
				addMenu();
				return false;
			});
			var btn2 = $("#editBtn_"+treeNode.tId);
			if (btn2) btn2.bind("click", function(){
				zTree.selectNode(treeNode);
				editMenu();
				return false;
			});
			var btn3 = $("#removeBtn_"+treeNode.tId);
			if (btn3) btn3.bind("click", function(){
				zTree.selectNode(treeNode);
				deleteItem();
				return false;
			});
			var btn4 = $("#viewBtn_"+treeNode.tId);
			if (btn4) btn4.bind("click", function(){
				zTree.selectNode(treeNode);
				viewMenu();
				return false;
			});
			
	}
	function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
			$("#editBtn_"+treeNode.tId).unbind().remove();
			$("#removeBtn_"+treeNode.tId).unbind().remove();
			$("#viewBtn_"+treeNode.tId).unbind().remove();
			
	}
	
	function beforeDrag(treeId, treeNodes) {
			for (var i=0,l=treeNodes.length; i<l; i++) {
				if (treeNodes[i].drag === false) {
					return false;
				}
			}
			return true;
	}
	var moveMode;
	function beforeDrop(treeId, treeNodes, targetNode, moveType) {
		if(treeNodes[0].getParentNode()!=null&&targetNode.getParentNode()!=null){
			if(treeNodes[0].getParentNode().id==targetNode.getParentNode().id){
				moveMode="same";
			}else{
				moveMode="diffrent";
			}
		}else if(treeNodes[0].getParentNode()==null&&targetNode.getParentNode()==null){
			moveMode="same";
		}else{
			moveMode="diffrent";
		}
		return targetNode ? targetNode.drop !== false : true;
			
	}
	
	function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {
		if(targetNode!=null){
		$.ajax({
				type : "POST",
				data : "currentid=" + treeNodes[0].id+"&targetid="+targetNode.id+"&moveType="+moveType+"&moveMode="+moveMode,
				url : '${root}/kjManager/KjPoint/setseq',
				success : function(data) {
					if (data == "ok") {
						refreshmenutree();
					}
				}
		});
		}
	}
	
	function OnRightClick(event, treeId, treeNode) {
		var x=event.pageX||(event.clientX+(document.documentElement.scrollLeft||document.body.scrollLeft));
		var y=event.pageY||(event.clientY+(document.documentElement.scrollTop||document.body.scrollTop));
		if (!treeNode && event.target.tagName.toLowerCase() != "button"
				&& $(event.target).parents("a").length == 0) {
			zTree.cancelSelectedNode();
			showRMenu("root", x, y);
		} else if (treeNode && !treeNode.noR) {
			zTree.selectNode(treeNode);
			showRMenu("node", x, y);
		}
	}
	function showRMenu(type, x, y) {
		$("#rMenu ul").show();
		if (type == "root") {
			$("#m_del").hide();
			$("#m_edit").hide();
			$("#m_add").hide();
			$("#m_addroot").show();
		} else {
			$("#m_del").show();
			$("#m_edit").show();
			$("#m_add").show();
			$("#m_addroot").hide();
		}
		rMenu.css({
			"top" : y + "px",
			"left" : x + "px",
			"visibility" : "visible"
		});
		$("body").bind("mousedown", onBodyMouseDown);
	}
	function hideRMenu() {
		if (rMenu)
			rMenu.css({
				"visibility" : "hidden"
			});
		$("body").unbind("mousedown", onBodyMouseDown);
	}
	function onBodyMouseDown(event) {
		if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
			rMenu.css({
				"visibility" : "hidden"
			});
		}
	}
	
	function opendg(dgurl, dgw, dgh) {
		$.dialog({
			title : '新窗口',
			width : dgw,
			height : dgh,
			max : false,
			min : false,
			lock : true,
			content : 'url:' + dgurl
		});
	}
	function addMenu() {
		hideRMenu();
		if (zTree.getSelectedNodes()[0]) {
			var dictItemId = zTree.getSelectedNodes()[0].id;
			opendg('${root}/dict/dictItem/form/new?dictId=${dictId}&dictItemId=' + dictItemId, 600,
					350);
		} else {
			opendg('${root}/dict/dictItem/form/new?dictId=${dictId}', 600, 350);
		}
	}
	function addTopMenu() {
		hideRMenu();
		opendg('${root}/dict/dictItem/form/new?dictId=${dictId}', 600, 350);
	}
	function addSubMenu() {
		if (zTree.getSelectedNodes()[0]) {
			var dictItemId = zTree.getSelectedNodes()[0].id;
			opendg('${root}/dict/dictItem/form/new?dictId=${dictId}&dictItemId=' + dictItemId, 600,
					350);
		}else{
			window.parent.bootbox.alert("请选择父级节点！");
		}
	}
	function editMenu() {
		hideRMenu();
		if (zTree.getSelectedNodes()[0]) {
			var dictItemId = zTree.getSelectedNodes()[0].id;
			opendg('${root}/dict/dictItem/form/edit?dictItemId=' + dictItemId, 600,
					350);
		}
	}
	function viewMenu(){
		hideRMenu();
		if (zTree.getSelectedNodes()[0]) {
			var dictItemId = zTree.getSelectedNodes()[0].id;
			opendg('${root}/dict/dictItem/form/view?dictItemId=' + dictItemId, 600,
					350);
		}
	}
	function refreshmenutree() {
		var zTree2 = $.fn.zTree.getZTreeObj("treeItem");
		zTree2.reAsyncChildNodes(null, "refresh");
	}
	function expandAll(flag){
		zTree.expandAll(flag);
	}
	function deleteItem() {
		hideRMenu();
		window.parent.bootbox.confirm("确定删除吗？", function(result) {
			if (result) {
				if (zTree.getSelectedNodes()[0]) {
					var dictItemId = zTree.getSelectedNodes()[0].id;
					$.ajax({
						type : "POST",
						data : "dictItemId=" + dictItemId,
						url : '${root}/dict/dictItem/delete',
						success : function(data) {
							if (data == "ok") {
								refreshmenutree();
								window.location.reload();
							}
						}
					});
				}
			}
		});
	}
	
	var treenodes=[];
	function getchildernode(Nodes){
		for(var i = 0; i<Nodes.length;i++){
			treenodes.push(Nodes[i].id);
			if(Nodes[i].children!=null){
				getchildernode(Nodes[i].children);
			}
		}
	}
	
	function deleteItems() {
		hideRMenu();
		window.parent.bootbox.confirm("确定级联删除吗？", function(result) {
			if (result) {
				if (zTree.getSelectedNodes()[0]) {
					var pointItemId = zTree.getSelectedNodes()[0].id;
					treenodes.push(pointItemId);
					var nodes = zTree.getSelectedNodes()[0].children;
					if(nodes!=null){
						getchildernode(nodes);
					}
					$.ajax({
						type : "POST",
						data : "pointItemId=" + treenodes,
						url : '${root}/dict/dictItem/delete',
						success : function(data) {
							if (data == "ok") {
								refreshmenutree();
							}
						}
					});
					treenodes=[];
				}
			}
		});
	}
	
	var sortNodes=[];
	function getSubNodes(Nodes){
		for(var i = 0; i<Nodes.length;i++){
			sortNodes.push(Nodes[i].id);
			if(Nodes[i].children!=null){
				getSubNodes(Nodes[i].children);
			}
		}
	}
	function getSortNodes(){
		var lv1nodes = zTree.getNodes();
		for(var i=0;i<lv1nodes.length;i++){
			sortNodes.push(lv1nodes[i].id);
			var nodes = lv1nodes[i].children;
			if(nodes!=null){
				getSubNodes(nodes);
			}
		}
		return sortNodes;
		sortNodes=[];
	}
	function refreshDictCache(id){
		$.ajax({
			type : "POST",
			data : "dictId=" + id,
			url : '${root}/dict/refreshCache',
			success : function(data) {
					if (data == "ok") {
						//alert("缓存刷新成功");
						//window.location.reload();
					}else if(data == "error"){
						alert("刷新失败，请联系管理员！");
					}
				}
		});
	}
</script>
</body>
	<!-- END JAVASCRIPTS -->
</html>
