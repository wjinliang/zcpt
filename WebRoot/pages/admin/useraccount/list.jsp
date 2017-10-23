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
<title>用户管理</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
<link rel="stylesheet"
	href="${root}/themes/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
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
							用户列表 <small>用户增删改查、角色授权、重置密码</small>
						</h3>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span3">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>组织机构
								</div>
							</div>
							<div class="portlet-body">
							<ul id="treeOrg" style="font-weight: bold" class="ztree"></ul>
							</div>
						</div>
					</div>
					<div class="span9">
						<input type="hidden" name="orgid" id="orgid" value="${orgid}">
						<input type="hidden" name="divisionid" id="divisionid" value="${divisionid}">
						<div class="portlet box green" >
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>列表
								</div>
							</div>
							<div class="portlet-body">
								<p>
									<button type="button" onclick="newItem()" class="btn green">
										<!-- <i class="icon-plus"></i> -->添加用户
									</button>
									<button type="button" onclick="excelExport('${orgid}')" class="btn green">
										导出用户
									</button>
									<button type="button" onclick="deleteItems()" class="btn red">
										<!-- <i class="icon-minus-sign"></i> -->删除用户
									</button>
									<button type="button" onclick="gopage(0);" class="btn" style="float:right">
										查询 
									</button>
									<i style="float:right">&nbsp;&nbsp;</i>
									<input type="text" class="m-wrap" id="tjcx" style="float:right" value="${param.tj}">
									<label class="control-label" style="float:right;font-size: 18px;text-align: center">用户名:&nbsp;&nbsp;</label>
									<i style="float:right">&nbsp;&nbsp;</i>
									 <select id="xt" style="float:right">
										<option value="all">==请选择==</option>
										<c:forEach items="${appList}" var="app" varStatus="status">
											<option value="${app.appName}" <c:if test="${app.appName==param.xt}">selected="selected"</c:if>>${app.appName}</option>
										</c:forEach>
									</select>
									<!-- <label class="control-label" style="float:right;font-size: 18px;text-align: center">系统标识:&nbsp;&nbsp;</label> -->
								
								</p>
								<table class="table table-condensed table-hover"
									id="useraccount_table">
									<colgroup>
										<col width="5%"></col>
										<col width="5%"></col>
										<col ></col>
										<col ></col>
										<col ></col>
										<%-- <col ></col>
										<col ></col>
										<col ></col> --%>
										<col width="20%"></col>
									</colgroup>
									<thead>
										<tr>
											<th style="width:8px;"><input type="checkbox"
												class="group-checkable"
												data-set="#useraccount_table .checkboxes" /></th>
											<th>#</th>
											<th>用户(登录名)</th>
											<th>所在单位</th>
											<th>系统标识</th>
											<!-- <th>登录次数</th>
											<th>上次登录</th>
											<th>上次登录IP</th> -->
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${userList}" var="useraccount" varStatus="status">
											<tr >
												<td style="vertical-align: middle;">
												<c:if test="${ currentUser.code !=useraccount.code}">
												<c:if test="${currentUser.systemId==useraccount.systemId }">
												<input type="checkbox" class="checkboxes" name="checkboxes"
													value="${useraccount.code}" />
												</c:if></c:if></td>
												<td style="vertical-align: middle;">
													${thispage*pagesize+status.count}
												</td>
												<td style="vertical-align: middle;color:#06184A;">${useraccount.name}(${useraccount.loginname})</td>
												<td style="vertical-align: middle;color:#020E29;">${useraccount.org.name}</td>
												<td style="vertical-align: middle;color:#020E29;">${useraccount.systemId}</td>
												<%-- <td style="vertical-align: middle;">${useraccount.loginCount}</td>
												<td style="vertical-align: middle;">${useraccount.lastLoginTime}</td>
												<td style="vertical-align: middle;">${useraccount.remoteIpAddr}</td> --%>
												<td style="vertical-align: middle;">
													<c:if test="${currentUser.systemId!=useraccount.systemId }">
													<a class='btn mini green' href="javascript:viewItem('${useraccount.code}')"> </i>
															查看 </a>
													</c:if>
													<div class="btn-group">
															
															
															<c:if test="${ currentUser.code !=useraccount.code}">
															<c:if test="${currentUser.systemId==useraccount.systemId }">
														<a class="btn mini green" href="#" data-toggle="dropdown">
															<i class="icon-cog"></i>
															<!--[if gt IE 7]>&nbsp;<![endif]-->
															<!--[if lte IE 7]>操作&nbsp;▽<![endif]--><i class="icon-angle-down"></i>
														</a>
														<ul class="dropdown-menu">
															
															<li><a href="javascript:viewItem('${useraccount.code}')"> <i class="icon-list-alt"></i>
																	查看 </a>
															</li>
															<li>
															<a href="javascript:editItem('${useraccount.code}')"> <i class="icon-pencil"></i> 修改
															</a>
															</li>
															<%-- <li>
															<a href="javascript:selectOrgs('${useraccount.code}')"> <i class="icon-sitemap"></i> 设置组织
															</a>
															</li> --%>
															
															<li>
															<a href="javascript:selectRoles('${useraccount.code}')"> <i class="icon-user-md"></i> 设置角色
															</a>
															</li>
															<li>
															<a href="javascript:resetPassword('${useraccount.code}')"> <i class="icon-lock"></i> 重置密码
															</a>
															</li>
															<li class="divider"></li>
															<li><a href="javascript:deleteItem('${useraccount.code}')"> <i class="icon-remove"></i>删除 </a>
															</li>
															<li>
															<a href="javascript:mergeUser('${useraccount.code}')"> <i class="icon-sitemap"></i> 关联用户
															</a>
															</li>
															<li>
															<a href="javascript:shouquan('${useraccount.code}')"> <i class="icon-user-md"></i> 用户授权
															</a>
															</li>
														</ul>
															</c:if>
															</c:if>
													</div></td>
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
	<%@include file="../include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../include/js.jsp"%>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript"
	src="${root}/themes/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	<script>
		jQuery(document).ready(function() {
			jQuery('#useraccount_table .group-checkable').change(function() {
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
			$.fn.zTree.init($("#treeOrg"), settingMenu, zNodesMenu);
			zTree = $.fn.zTree.getZTreeObj("treeOrg");
			selectNodes();
		});
		/* var settingMenu = {
				check : {
					enable : false
				},
			data : {
				simpleData : {
					enable : true
					}
				},
			callback : {
				onClick : goorgpage
			}
			}; */
			var settingMenu = {
					check : {
						enable : false
					},
					async: {
						enable: true,
						url:"${root}/orgAndUser/loadSonDivision",
						autoParam:["id=divisionid"]
					},
				data : {
					simpleData : {
						enable : true
						}
					},
				callback : {
					onClick : goorgpage
				}
				};
			var zNodesMenu=${orgStr};
		function selectNodes(){
 				var node = zTree.getNodeByParam("id", "${orgid}", null);
 				zTree.selectNode(node);
 			}
 		function goorgpage(){
				var ids=[];
				if (zTree.getSelectedNodes()[0]) {
					var orgid = zTree.getSelectedNodes()[0].id;
					if(orgid!=""){
						ids.push(orgid);
					}
					var nodes = zTree.getSelectedNodes()[0].children;
					if(nodes!=null){
						for(var i=0;i<nodes.length;i++){
							ids.push(nodes[i].id);
							getNodes(nodes[i],ids);
						}
					}
					document.getElementById('divisionid').value=orgid;
					gopage1("0");
				}
			}
			function getNodes(treeNode,ids){
				var nodes = treeNode.children;
				if(nodes!=null){
					for(var i=0;i<nodes.length;i++){
						ids.push(nodes[i].id);
						getNodes(nodes[i],ids);
					}
				}
			}
		function gopage(thispage){
			var xt=$("#xt").val();
			var tj=$("#tjcx").val();
			var orgid=document.getElementById('orgid').value;
			window.location.href="${root}/orgAndUser/listUsers?thispage="+thispage+"&orgid="+orgid+"&tj="+tj+"&xt="+xt;
		}
		function gopage1(thispage){
			var divisionid=document.getElementById('divisionid').value;
			window.location.href="${root}/orgAndUser/listOrgs?thispage="+thispage+"&divisionid="+divisionid;
		}
		function nextpage(){
				if(${thispage}<${totalpage-1}){
					gopage(${thispage+1});
				}
		}
		function prepage(){
				if(${thispage}>0){
					gopage(${thispage-1});
				}
		}
		function newItem(){
			window.location.href="${root}/useraccount/form/new?orgid=${orgid}";
		}
		function editItem(id){
			window.location.href="${root}/useraccount/form/edit?useraccountid="+id+"&orgid=${orgid}";
		}
		function viewItem(id){
			window.location.href="${root}/useraccount/form/view?useraccountid="+id+"&orgid=${orgid}";
		}
		function deleteItem(id) {
				window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "userid=" + id,
						url : '${root}/synuser/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}else if(data == "false"){
								alert("删除同步时出现错误，请查看同步日志！");
							}
						}
					});
				}
			});
	}
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
	function deleteItems(){
		var ids = getcheckedids();
		if(ids.length>0){
				window.bootbox.confirm("确定删除吗？", function(result) {
					if (result) {
						$.ajax({
						type : "POST",
						data : "userid=" + ids,
						url : '${root}/synuser/delete',
						success : function(data) {
							if (data == "ok") {
								window.location.reload();
							}else if(data == "false"){
								alert("删除同步时出现错误，请查看同步日志！");
							}
						}
					});
				}
			});
			}else{
				window.parent.bootbox.alert("请选择要删除的选项！");
			}
	}
	
	function resetPassword(id){
		window.bootbox.confirm("密码将重置为：1password!", function(result) {
			if (result) {
		$.ajax({
						type : "POST",
						data : "useraccountid=" + id+"&p=1password!",
						url : '${root}/synuseraccount/resetPassword',
						success : function(data) {
							if (data == "ok") {
								window.bootbox.alert("重置密码成功！");
							}else{
								window.bootbox.alert("重置密码失败！");
							}
						}
		});
			}
		});
	}
	
	function selectRoles(id) {
		var url = "${root}/useraccount/selectuserroles/" + id;
		window.location.href=url;
	}
	
	function selectOrgs(id){
		var url = "${root}/useraccount/selectorg/" + id;
		window.location.href=url;
	}
	/* function tjcx(){
		var xt=$("#xt").val();
		var tj=$("#tjcx").val();
		window.location.href="${root}/tjfx/listOrgUsers?tj="+tj+"&xtid="+xt;
	} */
	function mergeUser(id){
		var url = "${root}/orgAndUser/listMergeUsers?userid=" + id;
		window.open(url);
	}
	function excelExport(id){
		var xt=$("#xt").val();
		var tj=$("#tjcx").val();
		var url = "${root}/orgAndUser/excelExport?orgId=" + id+"&tj="+tj+"&xt="+xt;
		window.open(url,'','height=500, width=900, top=50, left=200,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no');
	}
	function shouquan(userId){
		//var url = '${root}/synuseraccount/ssoServiceBySession?xtbs='+app.appCode+'&TYPE='+data.type+'&ID='+data.id;
		var br =window.open('','','height=500, width=900, top=50, left=200,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no');
		$.ajax({
            //cache: true,
            type: "POST",
            url:'${root}/synuser/synAppList',
            data:{userCode:userId},// 你的formid
            //dataType:'json',
           // async: false,
            error: function(request) {
                alert("Connection error");
            	br.close();
            },
            success: function(data) {
            	
            if(data.status='1'){
            	var list = data.list;
				for(var i=0;i<list.length;i++){
		 			var app=list[i];
		 			br.location= '${root}/synuseraccount/ssoServiceBySession?xtbs='+app.appCode+'&TYPE='+data.type+'&ID='+data.id;
		 			//window.open('','','height=500, width=400, top=50, left=200');
		 			
		 		}
            }else{
            	alert("服务器处理错误");
            	br.close();
            }
            }
            });
	}
	</script>

	<!-- END JAVASCRIPTS -->
</html>
