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
<title>菜单管理</title>
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
							菜单管理 <small>菜单增删改查、菜单排序</small>
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="<%=basePath%>mainpage">主页</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="<%=basePath%>usermenu/list">菜单管理</a></li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span6">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>菜单树
								</div>
								<div class="actions">
									<a href="javascript:expandAll(true)" class="btn blue"><i class="icon-plus"></i> 展开所有</a>
									<a href="javascript:expandAll(false)" class="btn yellow"><i class="icon-minus"></i> 折叠所有</a>
								</div>
							</div>
							
							<div class="portlet-body">
							<div class="scroller" data-height="30px">
								<div id="alert" class="alert alert-success hide">
										<button class="close" data-dismiss="alert"></button>
										操作成功！
								</div>
								<hr/>
							</div>
							<div class="scroller" data-height="300px"  data-always-visible="1" data-rail-visible="1">
								<ul id="treeMenu" class="ztree"></ul>
							</div>
							<div class="space10"></div>

							<span class="label label-important">注意!</span>

							<span>

								菜单树点击右键试试看:)

							</span>
							<div class="space10"></div>
							<div class="form-actions form-horizontal" >
							<div class="control-group">
										<label class="control-label">拖拽功能开关</label>
										<div class="controls">
											<div class="success-toggle-button">

												<input type="checkbox" class="toggle" id="isdrag" onchange="changeGrag()"/>

											</div>
										</div>
							</div>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="rMenu">
			<ul class="dropdown-menu dropdown-context">
				<li class="nav-header" id="m_add" onclick="addMenu();">增加子级菜单</li>
				<li class="nav-header" id="m_addroot" onclick="addTopMenu();">增加顶级菜单</li>
				<li class="nav-header" id="m_del" onclick="deleteMenu();">删除菜单</li>
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
	<script type="text/javascript" src="<%=basePath%>themes/media/js/jquery.toggle.buttons.js"></script>
	<script>
		jQuery(document).ready(function() {
			$.fn.zTree.init($("#treeMenu"), settingMenu, "");
			zTree = $.fn.zTree.getZTreeObj("treeMenu");
			zTree.setting.edit.drag.isCopy = false;
			zTree.setting.edit.drag.isMove = true;
			zTree.setting.edit.drag.prev = true;
			zTree.setting.edit.drag.inner = true;
			zTree.setting.edit.drag.next = true;
			rMenu = $("#rMenu");
			//定位到当前导航栏，参数为菜单id;
			$('.success-toggle-button').toggleButtons({
            style: {
                enabled: "success",
                disabled: "info"
            }
       		});
		});
		var zTree;
		var rMenu;
		var settingMenu = {
		view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				showIcon : false,
				selectedMulti: false
			},
		edit: {
				enable: false,
				showRemoveBtn: false,
				showRenameBtn: false
		},
		check : {
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
			url : "<%=basePath%>usermenu/load",
			autoParam : [ "id", "name", "pId" ]
		},
		callback : {
			onRightClick : OnRightClick,
			beforeDrag: beforeDrag,
			beforeDrop: beforeDrop,
			onDrop: onDrop
		}
	};
	
	function changeGrag(){
		var fl = document.getElementById("isdrag").checked;
		zTree.setting.edit.enable=fl;
	}
	
	function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr ="<span class='button2 add' id='addBtn_" + treeNode.tId
				+ "' title='增加子级菜单' onfocus='this.blur();'></span>"+
				"<span class='button2 edit' id='editBtn_" + treeNode.tId
				+ "' title='编辑菜单' onfocus='this.blur();'></span>"+
				"<span class='button2 view' id='viewBtn_" + treeNode.tId
				+ "' title='查看菜单' onfocus='this.blur();'></span>"+
				"<span class='button2 delete' id='removeBtn_" + treeNode.tId
				+ "' title='删除菜单' onfocus='this.blur();'></span>"+
				"<span class='button2 up' id='upBtn_" + treeNode.tId
				+ "' title='上移' onfocus='this.blur();'></span>"+
				"<span class='button2 down' id='downBtn_" + treeNode.tId
				+ "' title='下移' onfocus='this.blur();'></span>";
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
				deleteMenu();
				return false;
			});
			var btn4 = $("#viewBtn_"+treeNode.tId);
			if (btn4) btn4.bind("click", function(){
				zTree.selectNode(treeNode);
				viewMenu();
				return false;
			});
			var btn5 = $("#upBtn_"+treeNode.tId);
			if (btn5) btn5.bind("click", function(){
				zTree.selectNode(treeNode);
				moveUp();
				return false;
			});
			var btn6 = $("#downBtn_"+treeNode.tId);
			if (btn6) btn6.bind("click", function(){
				zTree.selectNode(treeNode);
				moveDown();
				return false;
			});
	}
	function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
			$("#editBtn_"+treeNode.tId).unbind().remove();
			$("#removeBtn_"+treeNode.tId).unbind().remove();
			$("#viewBtn_"+treeNode.tId).unbind().remove();
			$("#upBtn_"+treeNode.tId).unbind().remove();
			$("#downBtn_"+treeNode.tId).unbind().remove();
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
	function moveUp() {
		var Node = zTree.getSelectedNodes()[0];
		if (Node) {
			if(Node.isFirstNode){
				return;
			}else {
				$.ajax({
				type : "POST",
				data : "currentid=" + Node.id+"&targetid="+Node.getPreNode().id+"&moveType=prev&moveMode=same",
				url : '<%=basePath%>usermenu/setseq',
				success : function(data) {
					if (data == "ok") {
						refreshmenutree();
					}
				}
			});
			}
		} 
	}
	
	
	function moveDown() {
		var Node = zTree.getSelectedNodes()[0];
		if (Node) {
			if(Node.isLastNode){
				return;
			}else {
				$.ajax({
				type : "POST",
				data : "currentid=" + Node.id+"&targetid="+Node.getNextNode().id+"&moveType=next&moveMode=same",
				url : '<%=basePath%>usermenu/setseq',
				success : function(data) {
					if (data == "ok") {
						refreshmenutree();
					}
				}
			});
			}
		} 
	}
	
	function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {
		if(targetNode!=null){
		$.ajax({
				type : "POST",
				data : "currentid=" + treeNodes[0].id+"&targetid="+targetNode.id+"&moveType="+moveType+"&moveMode="+moveMode,
				url : '<%=basePath%>usermenu/setseq',
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
			title : '',
			width : dgw,
			height : dgh,
			max : false,
			min : false,
			lock : true,
			id : 'menupop',
			content : 'url:' + dgurl
		});
	}
	function addMenu() {
		hideRMenu();
		if (zTree.getSelectedNodes()[0]) {
			var menuid = zTree.getSelectedNodes()[0].id;
			opendg('<%=basePath%>usermenu/form/new?menuid=' + menuid, 600,
					500);
		} else {
			alert("请选中父菜单节点");
		}
	}
	function addTopMenu() {
		hideRMenu();
		opendg('<%=basePath%>usermenu/form/new', 600, 500);
	}
	function editMenu() {
		hideRMenu();
		if (zTree.getSelectedNodes()[0]) {
			var menuid = zTree.getSelectedNodes()[0].id;
			opendg('<%=basePath%>usermenu/form/edit?menuid=' + menuid, 600,
					500);
		}
	}
	function viewMenu(){
		hideRMenu();
		if (zTree.getSelectedNodes()[0]) {
			var menuid = zTree.getSelectedNodes()[0].id;
			opendg('<%=basePath%>usermenu/form/view?menuid=' + menuid, 600,
					500);
		}
	}
	function refreshmenutree() {
		$("#alert").show();
		var zTree2 = $.fn.zTree.getZTreeObj("treeMenu");
		zTree2.reAsyncChildNodes(null, "refresh");
		setTimeout("alertHide()",2000);
	}
	function alertHide(){
		$("#alert").fadeOut();
	}
	function expandAll(flag){
		zTree.expandAll(flag);
	}
	function deleteMenu() {
		hideRMenu();
		window.parent.bootbox.confirm("确定删除吗？", function(result) {
			if (result) {
				if (zTree.getSelectedNodes()[0]) {
					var menuid = zTree.getSelectedNodes()[0].id;
					$.ajax({
						type : "POST",
						data : "menuid=" + menuid,
						url : '<%=basePath%>usermenu/delete',
						success : function(data) {
							if (data == "ok") {
								refreshmenutree();
							}
						}
					});
				}
			}
		});
	}
	</script>

	<!-- END JAVASCRIPTS -->
</html>
