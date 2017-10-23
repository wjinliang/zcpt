<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<table class="table table-striped table-advance table-hover">
<thead>
<tr>
<th colspan="7">
<input  type="checkbox"/>
</th>
<c:if test="${fn:length(msgList)==0}">
<tr>
<td colspan="7">
暂无接收的消息。
</td>
</tr>
</c:if>
</thead>
<tbody>
<c:forEach items="${msgList}" var="message" varStatus="status">
<tr <c:if test="${message.isRead=='0'}"> class="unread" </c:if> >
<td class="inbox-small-cells">
<input class="mail-checkbox" type="checkbox" value="${message.msg_user_id}">
</td>
<td class="inbox-small-cells" style="vertical-align: middle;" onclick="Inbox.loadMessage('${message.msg_user_id}');">
<c:if test="${message.isRead=='0'}">
<i class="icon-envelope-alt"></i>
</c:if>
<c:if test="${message.isRead=='1'}">
<i class="icon-ok"></i>
</c:if>
</td>
<td class="view-message" style="vertical-align: middle;" onclick="Inbox.loadMessage('${message.msg_user_id}');">${message.from}</td>
<td class="view-message" style="vertical-align: middle;width:30%;text-align: left;" onclick="Inbox.loadMessage('${message.msg_user_id}');">${message.messageSubject}</td>
<td class="view-message text-right" style="vertical-align: middle;width:20%" onclick="Inbox.loadMessage('${message.msg_user_id}');">${message.messageTime}</td>
<td class="view-message text-right" style="vertical-align: middle;width:5%">
<c:if test="${message.isMark=='0'}">
<a style="text-decoration:none;" href="javascript:Inbox.markMessage('${message.msg_user_id}');">
<i id="mark_${message.msg_user_id}" class="icon-star"></i>
</a>
</c:if>
<c:if test="${message.isMark=='1'}">
<a style="text-decoration:none;" href="javascript:Inbox.markMessage('${message.msg_user_id}');">
<i id="mark_${message.msg_user_id}" class="icon-star-empty"></i>
</a>
</c:if>
<a style="text-decoration:none;" href="javascript:Inbox.trashMessage('${message.msg_user_id}','1');"><i class="icon-trash"></i></a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
${pagination}