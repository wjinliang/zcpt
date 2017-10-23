<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
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
<%@include file="../include/meta.jsp"%>
<title>审批管理</title>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<%@include file="../include/style.jsp"%>
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
							审批中心
						</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="${root}/mainpage">主页</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="${root}/apply/list">
							
							</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-search"></i>申请类型分类
								</div>
								<div class="tools">

									<a href="javascript:;" class="collapse"></a>

								</div>
							</div>
							<div class="portlet-body form">
								<form action="#" class="form-horizontal">

									<div class="control-group">

										<label class="control-label"><font style="font-weight: bold;">审批类型</font></label>

										<div class="controls">										
												<c:forEach items="${dim:itemList('t_apply_obj_type')}" var="type">
													<label class="checkbox"> 
														<input name="applyObjType" id="type_${type.itemCode}" data="${type.itemName}" type="checkbox" value="${type.itemCode}" /> ${type.itemName} 
													</label> 	
												</c:forEach>
										</div>

									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box green">
							<div class="portlet-title">

								<div class="caption">
									<i class="icon-reorder"></i>审批管理
								</div>

							</div>

							<div class="portlet-body">
								<form action="#" class="form-horizontal">
								<div class="control-group">

										<label class="control-label"><font style="font-weight: bold;">当前搜索分类：</font></label>

										<div class="controls">
											<span class="text" id="searchText"></span>										
										</div>

								</div>
								<div class="control-group">

										<label class="control-label"><font style="font-weight: bold;">搜索结果：</font></label>

										<div class="controls">
											<span class="text" id="searchText">
											待审批<span class="label label-important">${d:gAn("1",applyObjType)}</span>项；
											已通过<span class="label label-important">${d:gAn("2",applyObjType)}</span>项；
											已退回<span class="label label-important">${d:gAn("3",applyObjType)}</span>项。
											</span>										
										</div>

								</div>
								</form>
								<div class="tabbable tabbable-custom">
									<ul class="nav nav-tabs">
										<li <c:if test="${approveStatus=='1'}">class="active"</c:if> >
										<a href="${root}/apply/list?approveStatus=1"><font style="font-size: 16px;font-weight: bold;">待审批</font></a>
										</li>

										<li 
										<c:if test="${approveStatus=='2'}">class="active"</c:if>
										><a href="${root}/apply/list?approveStatus=2"><font style="font-size: 16px;font-weight: bold;">已通过</font></a>
										</li>
										
										<li 
										<c:if test="${approveStatus=='3'}">class="active"</c:if>
										><a href="${root}/apply/list?approveStatus=3"><font style="font-size: 16px;font-weight: bold;">已退回</font></a>
										</li>

									</ul>

									<div class="tab-content">

										<div class="tab-pane active" id="portlet_tab1">

											<table class="table table-striped table-bordered table-advance table-hover"
												id="apply_table">
												<colgroup>
													<col width="5%"></col>
													<col width="70%"></col>
													<col width="25%"></col>
												</colgroup>
												<thead>
													<tr>
														<th>#</th>
														<th>内容</th>
														<th>操作</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${applys}" var="apply" varStatus="status">
														<tr>
															<td style="vertical-align: middle;">
																${thispage*pagesize+status.count}</td>
															<td style="vertical-align: middle;">${apply.applyContent}</td>
															<td style="vertical-align: middle;">
																<div class="btn-group">
																	<a class="btn mini green" href="javascript:viewItem('${apply.applyId}')"> 进入审批</a>
																</div>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
					
									</div>
									${pagination}
								</div>

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
	<%@include file="../include/foot.jsp"%>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<%@include file="../include/js.jsp"%>
	<script>
		jQuery(document).ready(function() {
			var types = "${applyObjType}";
			if(types!=""){
			var type_array =  types.split(",");
			var searchTexts=[];
			for(var i in type_array)
            {	
				 $("#type_"+type_array[i]).attr("checked",true);
				 searchTexts.push($("#type_"+type_array[i]).attr("data"));
				 $("#uniform-type_"+type_array[i]).find("span").addClass("checked");        
            }
			}
			if(searchTexts==null){
				$("#searchText").html("全部");
			}else{
				$("#searchText").html(searchTexts.toString());
			}
			$('input[name="applyObjType"]').change(function(e) {
				selectChange();
				e.preventDefault();
			});
		});
		function selectChange(){
			gopage(0);
		}
		function searchByStatus(status){
			var types=[];
				$('input[name="applyObjType"]:checked').each(function(){    
					types.push($(this).val());    
				});  
				var paramters = "";
				if(types.length>0){
					paramters +=("&applyObjType="+types);
				}
				window.location.href="${root}/apply/list?approveStatus="+status+"&thispage=0"+paramters;
		}
		function gopage(thispage){
				var types=[];
				$('input[name="applyObjType"]:checked').each(function(){    
					types.push($(this).val());    
				});  
				var paramters = "";
				if(types.length>0){
					paramters +=("&applyObjType="+types);
				}
				window.location.href="${root}/apply/list?approveStatus=${approveStatus}&thispage="+thispage+paramters;
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
		function viewItem(applyId){
			window.location.href="${root}/apply/approveForm?applyId="+applyId;	
		}
	</script>

	<!-- END JAVASCRIPTS -->
</html>
