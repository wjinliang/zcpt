<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<div class="inbox-header inbox-view-header">
<h1 class="pull-left">主题：${inbox.messageSubject}</h1>

</div>


<div class="inbox-view-info">
<div class="row">
<div class="col-md-5" style="margin:0 0 0 30px;">
<img src="${root}/themes/media/assets/img/avatar1_small.jpg"> 
<span class="bold">${inbox.from}</span> 发送给 <span class="bold">${inbox.to}</span>
 于 ${inbox.messageTime}
</div>
<div class="col-md-5 inbox-info-btn">
<button type="button" class="btn blue reply-btn" onclick="Inbox.replyMessage('${inbox.msg_user_id}')">
<i class="icon-reply"></i> 回复
</button>
</div>
</div>
</div>

<div class="inbox-view">
${inbox.messageContent}
</div>
<hr>
<c:if test="${inbox.messageLink!=null}">
<a href="${inbox.messageLink}">快捷链接</a>
<hr>
</c:if>
<c:if test="${fn:length(attachments)>0}">
<div class="inbox-attached">
<div class="margin-bottom-15">
<span>${fn:length(attachments)} 附件 —</span> 
<a href="#">下载</a>   
<a href="#">预览</a>   
</div>
<c:forEach items="${attachments}" var="attachment" varStatus="status">
<div class="margin-bottom-25">
<!--<img src="${root}/themes/media/assets/img/gallery/image4.jpg">-->
<div>
<strong>${attachment.name}</strong>
<span>${attachment.filesize2}</span>
<a href="#">预览</a>
<a href="#">下载</a>
</div>
</div>
</c:forEach>
</div>
</c:if>