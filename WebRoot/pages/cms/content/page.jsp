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
<title>内容维护</title>
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
					内容维护 
				</h3>
				<ul class="breadcrumb">
					<li>内容管理
						<i class="icon-angle-right"></i></li>
					<li><a href="${root}/cms/content/page">内容维护</a>
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
						<div class="actions">
							<a href="javascript:expandAll(true);" class="btn blue mini"><i class="icon-plus"></i>展开</a>
							<a href="javascript:expandAll(false);" class="btn blue mini"><i class="icon-minus"></i>折叠</a>
							<a href="javascript:refreshTree();" class="btn mini">刷新</a>
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
			filed : "contentId",
			align : "center",
			width : "5%"
		},{
			title : "标题",
			filed : "title",
			align : "center",
			width : "15%"
		},{
			title : "类型",
			filed : "contentType",
			align : "center",
			width : "15%",
			format : function(index,content){
				if(content.contentType=="1"){
					return "新闻";
				}else if(content.contentType=="2"){
					return "图片";
				}
			}
		} ],
		actionCloumText : "操作",//操作列文本
		actionWidth : "25%",
		actionCloums : [  {
			text : "查看",
			cls : "green",
			handle : function(index, data) {
				newOpenView(data.contentId);
				//window.open(window.location.href);
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
				popEditItem(data.contentId);
			}
		}, {
			text : "删除",
			cls : "red",
			handle : function(index, data) {
				deleteItem(data.contentId);
			}
		} ],
		tools : [
		//工具属性
		{
			text : "删除",
			cls : "red ",//按钮样式
			handle : function() {
				deleteItems(grid.currentCheckeds());
			}
		} ],
		dropDowns : [{
			buttonText :　"发布",
			items:[{
				text : "新闻",//文本
				handle : function() {//按钮点击事件
					popNewItem();
					$("#contentType").val("1");
				}
			},{
				text : "图片",//文本
				handle : function() {//按钮点击事件
					popNewItem();
					$("#contentType").val("2");
				}
			}]
		}],
};
var formOpts = {
		id : "content_form",//表单id
		name : "content_form",//表单名
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
			name : "contentId",
			id : "contentId"
		},{
			type : "hidden",
			name : "contentType",
			id : "contentType"
		}, {
			type : 'select',
			name : 'channelId',
			id : 'channelId',
			label : "所属频道",
			span : '6',
			itemsUrl : '../channel/loadChannels'
		}, {
			type : "text",//类型
			name : "title",//name
			id : "title",//id
			label : "标题",//左边label
			//detail : '这是普通文本',//描述
			span : "6",//宽度 1-8
			rule : {//验证规则
				required : "true"
			},
			msg : {//对应验证提示信息
				required : "请输入标题"
			}
		}, {
			type : "textarea",//类型
			name : "digest",//name
			id : "digest",//id
			label : "摘要",//左边label
			detail : '不多于200字',//描述
			span : "8",//宽度 1-8
			rule : {//验证规则
				required : "true"
			},
			msg : {//对应验证提示信息
				required : "请输入摘要"
			}
		}, {
			type : "text",//类型
			name : "origin",//name
			id : "origin",//id
			label : "来源",//左边label
			span : "6"
		}, {
			type : "text",//类型
			name : "originUrl",//name
			id : "originUrl",//id
			label : "来源链接",//左边label
			span : "6"
		}, {
			type : 'datepicker',
			name : 'publishTime',
			id : 'publishTime',
			label : "发布时间",
			span : '4',
			isTime : true,//选择时间模式
			format : 'YYYY-MM-DD hh:mm:ss'//日期格式
		}, {
			type : 'htmlEditor',
			name : 'content',
			id : 'content',
			label : '文本内容',
			rule : {
				required : "true"
			},
			msg : {
				required : "请输入"
			}
		}]
};
function newOpenView(contentId){
	window.open("${root}/portal/content/"+contentId);
}
function popNewItem() {
	dialog = $.MetroLayout({
		contentId : "newPop",
		title : "新建",
		width : 1000,
		height : 600
	});
	dialog.$content.MetroForm(formOpts);
	var node = tree.getSelectNode();
	var setValue = function(){
		if($("#channelId option").length==0){
			setTimeout(function(){
				setValue();
			},500);
		}else{
			$("#channelId").val(node.id);
			return false;
		}
	}
	if(typeof(node)!="undefined"){
		setValue();
	}
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
				"./ajaxLoad?contentId=" + id);
}

function deleteItem(id) {
	bootbox.confirm("确定删除吗？", function(result) {
		if (result) {
			$.ajax({
				type : "POST",
				data : "contentId=" + id,
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
				data : "contentId=" + ids,
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

function selectChannel(event, treeId, treeNode){
	var channelId=treeNode.id;
	if(channelId!=0){
		grid.reload({
			url:"./jsonList?channelId="+channelId
		});
	}else{
		grid.reload({
			url:"./jsonList"
		});
	}
	
}
function expandAll(boolean){
	tree.expandAll(boolean);
}
function refreshTree(){
	tree.reload();
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
				url : "../channel/jsonTree",
				autoParam : [ "id", "name", "pId" ]
			},
			callback : {
				onClick : selectChannel
			}
		}
	});
});
</script>
</html>
