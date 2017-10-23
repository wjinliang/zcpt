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
<title>中国海事局AIS岸基网络监控系统</title>
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
<!-- BEGIN SIDEBAR -->
<%@include file="../../admin/include/sidebar.jsp"%>
<!-- END SIDEBAR -->
<!-- BEGIN PAGE -->
<div class="page-content">
	<!-- BEGIN PAGE CONTAINER-->
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<h3 class="page-title">
				</h3>
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
						<i class="icon-angle-right"></i>
					</li>
					<li><a href="${root}/siteinfo/list">基站连接</a></li>
				</ul>
			</div>
		</div>
		<div align="right">
		<span class="query-btn" ><button href="javascript:void(0)" style="display:none" class="hidebtn btn blue" >隐藏查询面板</button><button href="javascript:void(0)"  class="showbtn btn blue" >显示查询面板</button></span>
		</div>
		<div class="query-tab " style="display:none">
		<form name="searchform" action="${root}/siteinfo/list" method="post">
				<div class="portlet box ">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-list"></i>查询条件
						</div>
					</div>
					<div class="portlet-body">
			<input type="hidden" name="thispage" id="thispage" />
			
				<table class=" list-search table-fix" summary="这是一个1行3列的表格样式模板">
					<colgroup>
						<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->

						<col width="10%"></col>
						<col width="20%"></col>
						<col width="10%"></col>
						<col width="20%"></col>
						<col width="10%"></col>
						<col width="30%"></col>
					</colgroup>
					<tbody id="searchBody">
						<tr>
							<th><label class="fn-right">基站名称</label></th>
							<td><input type="text" name="sitename"
								value="${siteinfo.sitename}"
								class="input-normal input-wd200  fn-left" />
							</td>
							<th><label class="fn-right">基站类型</label></th>
							<td>
							<select name="siteType" class="input-select input-wd200">
							<option value="">请选择基站类型</option>
							<option value="0">单</option>
							<option value="1">双</option>
							</select>
							</td>
							<th><label class="fn-right">连接状态</label></th>
							<td>
							<select name="connectFlag" class="input-select input-wd200">
							<option value="">请选择连接状态</option>
							<option value="0">未连接</option>
							<option value="1">已连接</option>
							</select>
							</td>
						</tr>
						
					</tbody>
					<tfoot>
						<tr>
							<td colspan="6" align="center">
								<button type="button" onclick="search()" class="btn green">查询</button>
								<button type="reset" onclick="resetForm()"
									class="btn blue">重置</button></td>
						</tr>
					</tfoot>
				</table>
			</div>
			</div>
		</form>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="portlet box green">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-list"></i>基站列表
						</div>
					</div>
					<div class="portlet-body">
						<div class="clearfix">
							<button type="button" onclick="newItem()" class="btn green">
								<i class="icon-plus"></i>添加
							</button>
							<button type="button" onclick="deleteItems()" class="btn red">
								<i class="icon-minus-sign"></i>删除
							</button>
						</div>
						<div class="dataTables_wrapper form-inline">
							<table class="table table-striped table-hover"
								id="siteinfo_table">
								<colgroup>
									<!--注意用colgrounp标签组定义表格的每列宽度不可删除-->
									<col></col>
									<col></col>
									<col></col>
									<col></col>
									<col></col>
									<col></col>
									<col></col>
								</colgroup>
								<thead>
									<tr>
										<th style="width:8px;"><input type="checkbox"
											class="group-checkable"
											data-set="#siteinfo_table .checkboxes" /></th>
										<th>序号</th>
										<th>基站名称</th>
										<th>基站类型</th>
										<th>IP：端口</th>
										<th>连接状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${siteList}" var="siteInfo" varStatus="vs">
										<tr>
											<td style="vertical-align: middle;"><input
												type="checkbox" class="checkboxes" name="checkboxes"
												value="${siteInfo.id}" /></td>
											<td style="vertical-align: middle;">
												${thispage*pagesize+vs.count}</td>
											<td style="vertical-align: middle;">${siteInfo.sitename}</td>
											<td style="vertical-align: middle;">${siteInfo.siteType=='0'?'单':'双'}</td>
											<td style="vertical-align: middle;">
												【A】${siteInfo.ipAddressA}:${siteInfo.portA } <c:if
													test="${siteInfo.siteType=='1' }">
													<br />【B】${siteInfo.ipAddressB}:${siteInfo.portB}
												</c:if></td>
											<td style="vertical-align: middle;">
												<c:if test="${siteInfo.connectFlag=='0'}">
													<font color=red>未连接</font>
												</c:if> <c:if test="${siteInfo.connectFlag=='1'}">
													<font color=green>已连接</font>
												</c:if></td>
											<td style="vertical-align: middle;">
												<a class="btn green" href="javascript:viewItem('${siteInfo.id}')">查看</a> 
												<!-- <a class="btn green" href="javascript:editItem('${siteInfo.id}')">修改</a>  -->
												<c:if
													test="${siteInfo.connectFlag=='0'}">
													<a class="btn green" href="javascript:setConnect('${siteInfo.id}','1');">建立连接</a>
												</c:if> <c:if test="${siteInfo.connectFlag=='1'}">
													<a class="btn blue"
														href="javascript:intelligentConfigure('${siteInfo.id}');">智能配置</a>
													<a class="btn purple"
														href="javascript:advancedConfigure('${siteInfo.id}');">高级配置</a>
													<!-- <a class="btn orange" href="javascript:setConnect('${siteInfo.id}','0');" >断开连接</a> -->
												</c:if> <a class="btn red"
												href="javascript:deleteItem('${siteInfo.id}')">删除</a></td>
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
	jQuery(document).ready(function() {
		jQuery('#siteinfo_table .group-checkable').change(function() {
			var set = jQuery(this).attr("data-set");
			var checked = jQuery(this).is(":checked");
			jQuery(set).each(function() {
				if (checked) {
					$(this).attr("checked", true);
				} else {
					$(this).attr("checked", false);
				}
			});
			jQuery.uniform.update(set);
		});
	});
	//查询
	function search(){
	    document.getElementById('thispage').value=0;
		document.searchform.submit();
	}
	//定位页数
	function gopage(thispage){
		window.location.href="${root}/siteinfo/list?thispage="+thispage;
	}
	//下一页
	function nextpage(){
		if(${thispage}<${totalpage-1}){
			gopage(${thispage+1});
		}
	}
	//上一页
	function prepage(){
		if(${thispage}>0){
			gopage(${thispage-1});
		}
	}
	//新增对象
	function newItem(){
		var url = "${root}/siteinfo/form/new";
		window.location.href=url;
	}
	//编辑对象
	function editItem(id){
		window.location.href="${root}/siteinfo/form/edit?siteid="+id;
	}
	//查看视图
	function viewItem(id){
		window.location.href="${root}/siteinfo/form/view?siteid="+id;
	}
	//删除对象
	function deleteItem(id) {
		window.bootbox.confirm("确定删除吗？", function(result) {
			if (result) {
				$.ajax({
					type : "POST",
					data : "siteid=" + id,
					url : '${root}/siteinfo/delete',
					success : function(data) {
						if (data == "ok") {
							window.location.reload();
						}
					}
				});
			}
		});
	}
	//选中多条记录
	function getcheckedids(){
		var ids=[];
		var cbs = document.getElementsByName("checkboxes");
		for(var i = 0 ; i < cbs.length; i++){
			if(cbs[i].checked == true){
				ids.push(cbs[i].value);
			}
		}
		return ids;
	}
	//批量删除
	function deleteItems(){
		var ids = getcheckedids();
		if(ids.length>0){
			window.bootbox.confirm("确定删除吗？", function(result) {
				if (result) {
					$.ajax({
						type : "POST",
						data : "siteid=" + ids,
						url : '${root}/siteinfo/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}
						}
					});
				}
			});
		}else{
			window.parent.bootbox.alert("请选择要删除的选项！");
		}
	}
	
	//建立连接
	function setConnect(id,flag){
		$.ajax({
			type : "POST",
			data : "siteid=" + id+"&connectFlag="+flag,
			url : '${root}/siteinfo/setConnect',
			success : function(data) {
				if (data == "ok") {
					alert("连接成功!");
					window.location.reload();
				}
				if (data == "error") {
					alert("连接失败!");
					window.location.reload();
				}
				if (data == "已经存在") {
					alert("基站已经存在!");
					window.location.reload();
				}
			}
		});
	}
	
	//智能配置
	function intelligentConfigure(id) {
		var url = "${root}/siteinfo/setting/form/" + id+"/"+0;
		window.location.href=url;
	}
	
	//高级配置
	function advancedConfigure(id) {
		var url = "${root}/siteinfo/setting/form/" + id+"/"+1;
		window.location.href=url;
	}
	
	//初始化查询面板的显示状态
	$(".query-btn").click(function(){
	    $(".query-tab").slideToggle(500);
        $(this).find(".showbtn").slideToggle(0);
        $(this).find(".hidebtn").slideToggle(0);
    });
</script>
<!-- END JAVASCRIPTS -->
</html>
