<%@ page language="java" pageEncoding="UTF-8"%>
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="<%=basePath%>themes/media/js/jquery-1.11.1.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/platform/js/jquery.timers-1.1.2.js"></script>
	<script src="<%=basePath%>themes/media/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/media/js/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>themes/media/js/jquery-ui-1.10.1.custom.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/media/js/jquery.slimscroll.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/media/js/jquery.blockui.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/media/js/jquery.cookie.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/media/js/jquery.uniform.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/platform/js/bootbox.js"></script>
	<script src="<%=basePath%>themes/media/js/app.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>themes/platform/js/metro.menu.js"></script>
	<script src="<%=basePath%>themes/platform/js/metro.dropdown.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->
	<script>
		//菜单实例
		var metro_menu;
		//根路径
		var dm_root = "${root}";
		jQuery(document).ready(function() {
			//APP初始化
			App.init();
			$('.portlet.box').attr("class", "portlet box blue");
			//菜单初始化
			var type = $('#layoutSetting').val()=="0"?"side":"vertical";
			var menuOptions = {
				url : dm_root+"/loadMenus",
				type : type
			};
			metro_menu = $.MetroMenu(menuOptions);
			/*
			var inbox = $.MetroDropdown({
				type : "inbox",
				dataUrl : dm_root+"/loadInbox",
				totalUrl : dm_root+"/inboxTotal"
			});
			*/
			//jsp版翻页事件初始化
			$("[data-title='go']").bind("click",function(){
				var page = $("[data-title='page']").val();
				var reg = /^[0-9]*[1-9][0-9]*$/;
				if(reg.test(page)){
					var num = page-1;
					gopage(num);
				}
			});
			$("[data-title='page']").val("${thispage+1}");
		});
		//布局菜单选项监听
		$('#layoutSetting').change(function(){
			var type = $('#layoutSetting').val()=="0"?"side":"vertical";
			metro_menu.reload({
				type : type
			});
			$.cookie('layout_dm', $('#layoutSetting').val(), {
				expires : 7,
				path : '/',
				secure : false
			});
		});
	</script>