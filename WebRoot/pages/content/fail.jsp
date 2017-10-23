<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
		<%
			String path = request.getContextPath();
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
		%>
        <meta charset="utf-8" />
        <title>错误</title>
        
        <!-- styles -->
        <link href="<%=basePath%>/themes/platform/css/pages2/bootstrap.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/bootstrap-responsive.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/stilearn.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/stilearn-responsive.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/stilearn-helper.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/stilearn-icon.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/font-awesome.css" rel="stylesheet" />
        <link href="<%=basePath%>/themes/platform/css/pages2/uniform.default.css" rel="stylesheet" />
        
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>

    <body>
        <section class="section">
            <div class="container">
                <div class="error-page">
                    <h1 class="error-code color-red">SORRY</h1>
                    <p class="error-description muted">${error}</p>
                </div>
            </div>
        </section>
    </body>
</html>
