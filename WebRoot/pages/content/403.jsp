<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    	<%
			String path = request.getContextPath();
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
		%>
        <meta charset="utf-8" />
        <title>403错误</title>
        
        <!-- styles -->
        <link href="<%=basePath%>/themes/platform/css/pages2/bootstrap.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/bootstrap-responsive.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/stilearn.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/stilearn-responsive.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/stilearn-helper.css" rel="stylesheet" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
    <body>
        <section class="section">
            <div class="container">
                <div class="error-page">
                    <h1 class="error-code color-red">Error 403</h1>
                    <p class="error-description muted">没有权限访问该页面。</p>
                </div>
            </div>
        </section>
    </body>
</html>
