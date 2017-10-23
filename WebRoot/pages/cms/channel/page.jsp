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
<title>频道管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
<%@include file="../../admin/include/plugin-style.jsp"%>
</head>
<!-- END HEAD -->

<!-- BEGIN HEADER -->
<%@include file="../../admin/include/head.jsp"%>
<!-- END HEADER -->
<!-- BEGIN SsiteIdEBAR -->
<%@include file="../../admin/include/sidebar.jsp"%>
<!-- END SsiteIdEBAR -->
<!-- BEGIN PAGE -->
<div class="page-content">
	<!-- BEGIN PAGE CONTAINER-->
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<h3 class="page-title">
					频道管理 
				</h3>
				<ul class="breadcrumb">
					<li>内容管理
						<i class="icon-angle-right"></i></li>
					<li><a href="${root}/cms/channel/page">频道管理</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span4">
				<div class="portlet box green">
					<div class="portlet-title">
						<div class="caption">
							频道树
						</div>
					</div>
					<div class="portlet-body" id="channel-tree"></div>
				</div>
			</div>
			<div class="span8">
				<div class="portlet box green">
					<div class="portlet-title">
						<div class="caption">
							列表
						</div>
					</div>
					<div class="portlet-body" id="channel-list"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- END PAGE CONTAINER-->
</div>
<!-- END PAGE -->
<%@include file="../../admin/include/foot.jsp"%>
<%@include file="../../admin/include/js.jsp"%>
<%@include file="../../admin/include/plugin-js.jsp"%>
<script>
var grid;
var tree;
var dialog;
var options = {
		url : "./jsonList", // ajax地址
		pageNum : 1,//当前页码
		pageSize : 5,//每页显示条数
		id_filed : "channelId",//id域指定
		show_check : true,//是否显示checkbox
		//show_index : true,//是否显示序号
		cloums : [ {
			title : "id",
			filed : "channelId",
			align : "center",
			width : "5%"
		},{
			title : "父节点id",
			filed : "parentId",
			align : "center",
			width : "5%"
		},{
			title : "频道名称",
			filed : "channelName",
			align : "center",
			width : "15%"
		} ],
		actionCloumText : "操作",//操作列文本
		actionWidth : "25%",
		actionCloums : [  {
			text : "查看",
			cls : "green",
			handle : function(index, data) {
				popViewItem(data.id);
			}
		},{
			//text : "编辑",
			textHandle : function(index, data) {
				//index为点击操作的行数
				//data为该行的数据
				//特殊需要时，textHandle能更具需要改变操作项的文本显示
				return "编辑";
			},
			cls : "green",
			handle : function(index, data) {
				//index为点击操作的行数
				//data为该行的数据
				popEditItem(data.channelId);
			}
		}, {
			text : "增加子节点",
			cls : "blue",
			handle : function(index, data) {
				popChildItem(data.channelId);
			}
		}, {
			text : "删除",
			cls : "red",
			handle : function(index, data) {
				deleteItem(data.channelId);
			}
		} ],
		tools : [
		//工具属性
		{
			text : "添加",//按钮文本
			cls : "green",//按钮样式
			handle : function() {//按钮点击事件
				popNewItem();
			}
		}, {
			text : "删除",
			cls : "red ",//按钮样式
			handle : function() {
				deleteItems(grid.currentCheckeds());
			}
		} ],
		search : {
			//搜索栏元素
			items : [{
				type : "text",
				label : "频道名称",
				name : "channelName"
			} ]
		}
};
var formOpts = {
		id : "channel_form",//表单id
		name : "channel_form",//表单名
		method : "post",//表单method
		action : "./ajaxSave",//表单action
		ajaxSubmit : true,//是否使用ajax提交表单
		ajaxSuccess : function() {
			dialog.close();
			grid.reload();
			tree.reload();
		},
		submitText : "保存",//保存按钮的文本
		showReset : true,//是否显示重置按钮
		resetText : "重置",//重置按钮文本
		isValidate : true,//开启验证
		buttons : [ {
			type : 'button',
			text : '关闭',
			handle : function() {
				dialog.close();
			}
		} ],
		//表单元素
		items : [ {
			type : "hidden",
			name : "channelId",
			id : "channelId"
		},{
			type : "hidden",
			name : "parentId",
			id : "parentId"
		}, {
			type : 'select',
			name : 'siteId',
			id : 'siteId',
			label : '所属站点',
			span : '6',
			itemsUrl : '../site/loadSites'
		}, {
			type : "text",//类型
			name : "channelName",//name
			id : "channelName",//id
			label : "频道名称",//左边label
			//detail : '这是普通文本',//描述
			span : "6",//宽度 1-8
			rule : {//验证规则
				required : "true"
			},
			msg : {//对应验证提示信息
				required : "请输入频道名称"
			}
		}]
};
function popNewItem() {
	dialog = $.MetroLayout({
		contentId : "newPop",
		title : "新建",
		width : 1000,
		height : 600
	});
	dialog.$content.MetroForm(formOpts);
}
function popEditItem(id) {
	dialog = $.MetroLayout({
		contentId : "editPop",
		title : "编辑",
		width : 1000,
		height : 600
	});
	if (typeof (id) != "undefined")
		dialog.$content.MetroForm(formOpts).loadRemote(
				"./ajaxLoad?channelId=" + id);
}
function popChildItem(pId) {
	dialog = $.MetroLayout({
		contentId : "newChildPop",
		title : "新建子节点",
		width : 1000,
		height : 600
	});
	dialog.$content.MetroForm(formOpts);
	$("#parentId").val(pId);
}
function deleteItem(id) {
	bootbox.confirm("确定删除吗？", function(result) {
		if (result) {
			$.ajax({
				type : "POST",
				data : "channelId=" + id,
				dataType : "json",
				url : "./ajaxDelete",
				success : function(data) {
					if (data.status == 1) {
						grid.reload();
						tree.reload();
					}
				}
			});
		}
	});
}
function deleteItems(ids){
	if(ids.length>0){
		bootbox.confirm("确定删除吗？", function(result) {
			if (result) {
				$.ajax({
				type : "POST",
				data : "channelId=" + ids,
				dataType : "json",
				url : "./ajaxDelete",
				success : function(data) {
					if (data.status == 1) {
						grid.reload();
						tree.reload();
					}
				}
			});
		}
	});
	}else{
		bootbox.alert("请选择要删除的选项！");
	}
}
$(document).ready(function() {
	//生成grid代码
	grid = $("#channel-list").MetroGrid(options);
	tree = $("#channel-tree").MetroZTree({
		treeId : "channel_tree",
		setting : {
			async : {
				enable : true,
				dataType : "json",
				url : "./jsonTree",
				autoParam : [ "id", "name", "pId" ]
			}
		}
	});
});
</script>
</html>
