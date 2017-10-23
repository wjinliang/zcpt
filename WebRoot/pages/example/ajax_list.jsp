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
<title>示例列表</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../admin/include/style.jsp"%>
<%@include file="../admin/include/plugin-style.jsp"%>
</head>
<!-- END HEAD -->

<!-- BEGIN HEADER -->
<%@include file="../admin/include/head.jsp"%>
<!-- END HEADER -->
<!-- BEGIN SIDEBAR -->
<%@include file="../admin/include/sidebar.jsp"%>
<!-- END SIDEBAR -->
<!-- BEGIN PAGE -->
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
						<i class="icon-angle-right"></i>
					</li>
					<li><a href="${root}/example/list">示例列表</a></li>
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
<!-- END PAGE -->
<!-- BEGIN FOOTER -->
<%@include file="../admin/include/foot.jsp"%>
<%@include file="../admin/include/js.jsp"%>
<%@include file="../admin/include/plugin-js.jsp"%>
<script>
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
					data : "exampleid=" + id,
					dataType : "json",
					url : "./ajaxDelete",
					success : function(data) {
						if (data.status == 1) {
							grid.reload();
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
					data : "exampleid=" + ids,
					dataType : "json",
					url : "./ajaxDelete",
					success : function(data) {
						if (data.status == 1) {
							grid.reload();
						}
					}
				});
			}
		});
		}else{
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
					"./ajaxLoad?exampleid=" + id);
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
					"./ajaxLoad?exampleid=" + id);
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
	
	function popSelentItems() {
		dialog = $.MetroLayout({
			contentId : "itemsPop",
			width : 1000,
			height : 600
		});
		dialog.$content.MetroGrid(options);;
	}
	
	var options = {
		url : "./ajaxList", // ajax地址
		pageNum : 1,//当前页码
		pageSize : 5,//每页显示条数
		id_filed : "id",//id域指定
		show_check : true,//是否显示checkbox
		cloums : [ {
			title : "普通文本",
			filed : "name",
			align : "center",
			width : "15%"
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
				popEditItem(data.id);
			}
		}, {
			text : "选择",
			cls : "blue",
			handle : function(index, data) {
				popSelentItems();
			}
		}, {
			text : "删除",
			cls : "red",
			handle : function(index, data) {
				deleteItem(data.id);
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
			items : [ {
				type : "select",//元素类型
				label : "下拉框",//元素说明
				name : "selector",//元素name
				//若元素为select,则items为其option
				items : [ {
					text : "请选择",
					value : ""
				}, {
					text : "一",
					value : "1"
				}, {
					text : "二",
					value : "2"
				} ]
			}, {
				type : "text",
				label : "普通文本",
				name : "name"
			}, {
				type : 'radioGroup',
				name : 'radioGroup',
				label : '单选框',
				items : [ {
					name : 'radio',
					value : '1',
					text : '单选框1'
				}, {
					name : 'radio',
					value : '2',
					text : '单选框2'
				} ]
			}, {
				type : 'checkboxGroup',
				name : 'checkboxGroup',
				detail : '这是复选框',
				label : '复选框',
				items : [ {
					name : 'checkbox',
					value : '1',
					text : '复选框1'
				}, {
					name : 'checkbox',
					value : '2',
					text : '复选框2'
				//初始默认选中
				} ]
			} ]
		}
	};

	var formOpts = {
		id : "example_form",//表单id
		name : "example_form",//表单名
		method : "post",//表单method
		action : "./ajaxSave",//表单action
		ajaxSubmit : true,//是否使用ajax提交表单
		ajaxSuccess : function() {
			dialog.close();
			grid.reload();
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
			type : 'hidden',
			name : 'id',
			id : 'id'
		}, {
			type : 'text',//类型
			name : 'name',//name
			id : 'name',//id
			label : '普通文本框',//左边label
			detail : '这是普通文本',//描述
			span : '6',//宽度 1-8
			value : '默认值',//默认显示值
			rule : {//验证规则
				required : "true",
				email : "true"
			},
			msg : {//对应验证提示信息
				required : "请输入文本",
				email : "请输入正确的邮箱格式"
			}
		}, {
			type : 'password',
			name : 'password',
			id : 'password',
			detail : '这是密码',
			label : '密码'
		}, {
			type : 'htmlEditor',
			name : 'textarea',
			id : 'textarea',
			label : 'kindeditor',
			rule : {
				required : "true"
			},
			msg : {
				required : "请输入"
			}
		}, {
			type : 'display',
			name : 'display',
			id : 'display',
			label : '展示内容',
			value : '这是展示的内容'
		}, {
			type : 'checkboxGroup',
			name : 'checkboxGroup',
			id : 'checkboxGroup',
			detail : '这是复选框',
			label : '复选框',
			items : [ {
				name : 'checkbox',
				value : '1',
				text : '复选框1'
			}, {
				name : 'checkbox',
				value : '2',
				text : '复选框2'
			//初始默认选中
			} ],
			//itemsUrl : '../jsp/checkbox.jsp',//异步加载路径
			rule : {
				required : "true"
			},
			msg : {
				required : "请选择一项"
			}
		}, {
			type : 'radioGroup',
			name : 'radioGroup',
			id : 'radioGroup',
			label : '单选框',
			items : [ {
				name : 'radio',
				value : '1',
				text : '单选框1'
			}, {
				name : 'radio',
				value : '2',
				text : '单选框2'
			} ],
			//itemsUrl : '../jsp/radio.jsp',
			rule : {
				required : "true"
			},
			msg : {
				required : "请选择"
			}
		}, {
			type : 'select',
			name : 'selector',
			id : 'selector',
			label : '下拉框',
			span : '6',
			items : [ {
				value : '',
				text : '请选择'
			}, {
				value : '1',
				text : '下拉框1'
			}, {
				value : '2',
				text : '下拉框2'
			} ],
			rule : {
				required : "true"
			},
			msg : {
				required : "请选择"
			}
		}, {
			type : 'datepicker',
			name : 'datepicker',
			id : 'datepicker',
			label : '时间选择器',
			span : '4',
			isTime : true,//选择时间模式
			format : 'YYYY-MM-DD hh:mm:ss',//日期格式
			rule : {
				required : "true"
			},
			msg : {
				required : "请选择日期"
			}
		}, {
			type : 'file',
			hiddenName : 'fileId',
			hiddenId : 'fileId',
			id : 'file',
			name : 'file',
			label : '文件',
			detail : "这是文件控件",
			isAjaxUpload : false,
			uploadUrl : '../../useraccount/upload',//文件单独上传路径
			onSuccess : function(data) {
				//上传成功后执行回调函数
				//例如：
				$("#fileId").val(data.file_id);
				alert(data.file_url);
			}
		}, {
			type : "tree",
			name : "tree",
			id : "tree",
			span : "6",
			hiddenName : "node",//隐藏域name属性
			hiddenId : "node",//隐藏域id属性
			detail : "这是树控件",
			checkMode : "checkbox",//属性选择类型 radio checkbox
			label : '树',
			treeId : "demoTree",//ztree的id
			url : '../usermenu/load'//树的异步加载url
		} ]
	};
	var viewOpts = {
			id : "view_form",//表单id
			name : "view_form",
			showSubmit :false,
			showReset : false,//是否显示重置按钮
			buttons : [ {
				type : 'button',
				text : '关闭',
				handle : function() {
					dialog.close();
				}
			} ],
			//表单元素
			items : [  {
				type : 'display',//类型
				name : 'name',//name
				label : '普通文本框',//左边label
				span : '6'
			}, {
				type : 'display',
				name : 'password',
				label : '密码'
			}, {
				type : 'display',
				name : 'textarea',
				label : '文本域'
			}, {
				type : 'display',
				name : 'checkbox',
				label : '复选框'
			}, {
				type : 'display',
				name : 'radio',
				label : '单选框'
			}, {
				type : 'display',
				name : 'selector',
				label : '下拉框',
				span : '6'
			}, {
				type : 'display',
				name : 'datepicker',
				label : '时间选择器',
				span : '4'
			}, {
				type : 'display',
				name : 'node',
				label : '树',
				span : '4'
			} ]
		};
</script>

<!-- END JAVASCRIPTS -->
</html>
