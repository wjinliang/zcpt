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
<title>上传头像</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<script type="text/javascript" src="<%=basePath%>themes/plugins/upload/scripts/swfobject.js"></script>
<script type="text/javascript" src="<%=basePath%>themes/plugins/upload/scripts/fullAvatarEditor.js"></script>
</head>
<body>
		<div style="width:632px;margin: 0 auto;text-align:center">
			<div>
				<p id="swfContainer">
                  	  本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
					<br/>
					 点击<a href="">这里</a>选择普通方式上传头像。
				</p>
			</div>
        </div>
		<script type="text/javascript">
            swfobject.addDomLoadEvent(function () {
				var swf = new fullAvatarEditor("<%=basePath%>themes/plugins/upload/fullAvatarEditor.swf", "<%=basePath%>themes/plugins/upload/expressInstall.swf", "swfContainer",450,650, {
					    id : 'swf',
						upload_url : '${url}',	//上传接口
						src_size : '5MB',
						src_size_over_limit : '文件大小（{0}）超出限制（5MB）\n请重新上传',
						browse_tip : '仅支持JPG、JPEG、GIF、PNG格式的图片文件\n文件不能大于5MB',
						avatar_sizes : '160*160|80*80|32*32',
						avatar_sizes_desc : '160*160像素|80*80像素|32*32像素',
						method : 'post',	//传递到上传接口中的查询参数的提交方式。更改该值时，请注意更改上传接口中的查询参数的接收方式
						src_upload : 1		//是否上传原图片的选项，有以下值：0-不上传；1-上传；2-显示复选框由用户选择
					}, function (msg) {
						switch(msg.code)
						{
							case 1 : break;
							case 2 : 
								break;
							case 3 :
								if(msg.type == 0)
								{
								}
								else if(msg.type == 1)
								{
									alert("摄像头已准备就绪但用户未允许使用！");
								}
								else
								{
									alert("摄像头被占用！");
								}
							break;
							case 5 : 
								if(msg.type == 0)
								{
									if(msg.content.sourceUrl)
									{
										setTimeout(function(){closeWin();},500);
									}
									
								}
							break;
						}
					}
				);
            });
            function closeWin(){
            	var api = frameElement.api, W = api.opener; // api.opener 为载加lhgdialog.min.js文件的页面的window对象
				api.reload();
				api.close();
            }
        </script>
    </body>
</html>