<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<title>学生信息列表</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../admin/include/style.jsp"%>
<%@include file="../admin/include/plugin-style.jsp"%>

</head>
<%@include file="../admin/include/head.jsp"%>
<%@include file="../admin/include/sidebar.jsp"%>
<div class="page-content">
	<!-- BEGIN PAGE CONTAINER-->
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<h3 class="page-title">
					示例列表 <small>列表增删改查</small>
				</h3>
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
						<i class="icon-angle-right"></i></li>
					<li><a>示例列表</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="portlet box green">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-list"></i>列表
						</div>
					</div>
					<div class="portlet-body" id="grid-div"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- END PAGE CONTAINER-->
</div>
<%@include file="../admin/include/foot.jsp"%>
<%@include file="../admin/include/js.jsp"%>
<%@include file="../admin/include/plugin-js.jsp"%>
<script type="text/javascript">
	var grid;
	var dialog;
	jQuery(document).ready(function() {
		//定位到当前导航栏，参数为菜单id;
		App.handleNavInit("1408865489341");
		//生成grid代码
		grid = $("#grid-div").MetroGrid(options);
	});
	function deleteItem(id) {
		bootbox.confirm("确定删除吗？", function(result) {
			if (result) {
				$.ajax({
					type : "POST",
					data : "stuid=" + id,
					dataType : "json",
					url : "./mydelete",
					success : function(data) {
						if (data.status == 1) {
							grid.reload();
						}
					}
				});
			}
		});
	}
	function deleteItems(ids) {
		if (ids.length > 0) {
			bootbox.confirm("确定删除吗？", function(result) {
				if (result) {
					$.ajax({
						type : "POST",
						data : "stu=" + ids,
						dataType : "json",
						url : "./mydelete",
						success : function(data) {
							if (data.status == 1) {
								grid.reload();
							}
						}
					});
				}
			});
		} else {
			bootbox.alert("请选择要删除的选项！");
		}
	}
	function popViewItem(id) {
		dialog = $.MetroLayout({
			contentId : "viewPop",
			title : "查看",
			width : 1000,
			height : 600
		});
		if (typeof (id) != "undefined")
			dialog.$content.MetroForm(viewOpts).loadRemote(
					"./myload?stuid=" + id);
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
					"./myload?stuid=" + id);
	}
	function popNewItem() {
		dialog = $.MetroLayout({
			contentId : "newPop",
			title : "新建",
			width : 1000,
			height : 600
		});
		var form = dialog.$content.MetroForm(formOpts);
	}

	function popSelectItems() {
		dialog = $.MetroLayout({
			contentId : "itemsPop",
			width : 1000,
			height : 600
		});
		dialog.$content.MetroGrid(options);
	}
	var options = {
		url : "./mylist",
		pageNum : 1,//当前页码
		pageSize : 5,//每页显示条数
		id_filed : "id",//id域指定
		show_check : true,//是否显示checkbox
		colums : [ {
			title : "姓名",
			filed : "stuname",
			align : "center",
		}, {
			title : "下拉框",
			filed : "selector",
			align : "center",
			format : function(index, data) {
				if (data.selector == "1") {
					return "一";
				} else if (data.selector == "2") {
					return "二";
				} else {
					return data.selector;
				}
			}
		}, {
			title : "地址",
			filed : "address",
			align : "center",
		} ],
		actionCloumText : "操作",
		actionWidth : "25%",
		actionCloums : [ {
			text : "查看",
			cls : "green",
			handle : function(index, data) {
				popViewItem(data.id);
			}
		}, {
			text : "编辑",
			cls : "green",
			handle : function(index, data) {
				popEditItem(data.id);
			}
		}, {
			text : "选择",
			cls : "blue",
			handle : function(index, data) {
				popSelectItems();
			}
		}, {
			text : "删除",
			cls : "red",
			handle : function(index, data) {
				deleteItems(data.id);
			}
		} ],
		tools : [ {
			text : "+添加",
			cls : "green",
			handle : function() {
				popNewItem();
			}
		}, {
			text : "-删除",
			cls : "red",
			handle : function() {
				deleteItems(grid.currentCheckeds());
			}
		} ],
		search : {
			items : [ {
				type : "select",
				label : "下拉框",
				name : "selector",
				items : [ {
					text : "请选择",
					value : ""
				}, {
					text : "一",
					value : "1",
				}, {
					text : "二",
					value : "2"
				} ]
			}, {
				type : "text",
				label : "姓名",
				name : "name"
			}, {
				type : 'radioGroup',
				name : 'radioGroup',
				label : '单选框',
				items : [ {
					name : 'sex',
					value : '1',
					text : '男',
				}, {
					name : 'sex',
					value : '2',
					text : '女'
				} ]
			}, {
				type : 'checkboxGroup',
				name : 'checkboxGroup',
				detail : '这是复选框',
				label : '爱好',
				items : [ {
					name : 'hobby',
					value : '1',
					text : '跑步'
				}, {
					name : 'hobby',
					value : '2',
					text : '打球'
				}, {
					name : 'hobby',
					value : '3',
					text : '游泳'
				} ]
			} ]
		}
	};
	

</script>
</html>
