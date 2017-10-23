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
<title>站点管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../../admin/include/style.jsp"%>
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
					站点管理 <small>站点增删改查</small>
				</h3>
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
						<i class="icon-angle-right"></i></li>
					<li><a href="${root}/cms/site/listItems">站点管理</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="row-fluid">
			<div class="portlet box green">
				<div class="portlet-title">
					<div class="caption">
						<i class="icon-list"></i>列表
					</div>
				</div>
				<div class="portlet-body">
					<div class="clearfix">
						<button type="button" onclick="newItem()" class="btn green">
							<i class="icon-plus"></i>添加
						</button>
						<button type="button" onclick="deleteItems()" class="btn red">
							<i class="icon-remove"></i>删除
						</button>
					</div>
					<div class="dataTables_wrapper form-inline">
					<table class="table table-striped table-hover" id="item_table">
						<colgroup>
							<col width="5%"></col>
							<col width="5%"></col>
							<col width="35%"></col>
							<col width="35%"></col>
							<col width="20%"></col>
						</colgroup>
						<thead>
							<tr>
								<th style="width:8px;"><input type="checkbox"
									class="group-checkable" data-set="#item_table .checkboxes" />
								</th>
								<th>#</th>
								<th>站点名称</th>
								<th>站点域名</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${items}" var="item" varStatus="status">
								<tr>
									<td style="vertical-align: middle;"><input type="checkbox"
										class="checkboxes" name="checkboxes"
										value="${item.siteId}" /></td>
									<td style="vertical-align: middle;">
										${thispage*pagesize+status.count}</td>
									<td style="vertical-align: middle;">${item.siteName}</td>
									<td style="vertical-align: middle;">${item.domain}</td>
									<td style="vertical-align: middle;">
										<a class="btn green"
										href="javascript:viewItem('${item.siteId}')">查看</a>
										<a class="btn green"
										href="javascript:editItem(${item.siteId})">修改</a>
										<a class="btn red"
										href="javascript:deleteItem('${item.siteId}')">删除</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					${pagination}
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END PAGE CONTAINER-->
</div>
<!-- END PAGE -->
<!-- BEGIN FOOTER -->
<%@include file="../../admin/include/foot.jsp"%>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../../admin/include/js.jsp"%>
<script>
	$(document).ready(function() {
		//复选框选中事件
		$('#item_table .group-checkable').change(function() {
			var set = $(this).attr("data-set");
			var checked = $(this).is(":checked");
			$(set).each(function() {
				if (checked) {
					$(this).attr("checked", true);
				} else {
					$(this).attr("checked", false);
				}
			});
			$.uniform.update(set);
		});
		//定位到当前导航栏，参数为菜单id;
		App.handleNavInit("1422849949174");
	});
	//获取当前页
	var pageNum = ${thispage};
	//获取总条数
	var total = ${totalpage};
	//跳转任意页面
	function gopage(num) {
		window.location.href = "./listItems?thispage=" + num;
	}
	//下一页
	function nextpage() {
		if (pageNum < (total - 1)) {
			gopage(pageNum + 1);
		}
	}
	//上一页
	function prepage() {
		if (pageNum > 0) {
			gopage(pageNum - 1);
		}
	}
	//新建
	function newItem() {
		window.location.href = "./newItem";
	}
	//修改
	function editItem(siteId) {
		window.location.href = "./editItem?siteId=" + siteId;
	}
	//查看
	function viewItem(siteId) {
		window.location.href = "./viewItem?siteId=" + siteId;
	}
	//删除单个
	function deleteItem(siteId) {
		bootbox.confirm("确定删除吗？", function(result) {
			if (result) {
				$.ajax({
					type : "POST",
					data : "siteId=" + siteId,
					url : './deleteItem',
					dataType : "json",//返回json格式的数据
					success : function(data) {
						if (data.status == 1) {
							window.location.reload();
						}else if(data.status == 0){
							
						}
					}
				});
			}
		});
	}
	//批量删除
	function deleteItems(){
		var getcheckedids=function(){
			var ids=[];
			var cbs = document.getElementsByName("checkboxes");
			for(var i = 0 ; i < cbs.length; i++){
				if(cbs[i].checked == true){
					ids.push(cbs[i].value);
				}
			}
			return ids;
		};
		var ids = getcheckedids();
		if(ids.length>0){
			window.bootbox.confirm("确定删除吗？", function(result) {
				if (result) {
					$.ajax({
					type : "POST",
					data : "siteIds=" + ids,
					dataType : "json",//返回json格式的数据
					url : './deleteItems',
					success : function(data) {
						if (data.status == 1) {
							window.location.reload();
						}else if(data.status == 0){
							
						}
					}
				});
			}
		});
		}else{
			window.parent.bootbox.alert("请选择要删除的选项！");
		}
	}
</script>

</html>
