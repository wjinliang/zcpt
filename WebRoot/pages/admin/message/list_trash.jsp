<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/d.tld" prefix="d"%>
<%@ taglib uri="/WEB-INF/tlds/dict.tld" prefix="dim"%>
<table class="table table-striped table-advance table-hover">
<thead>
<tr>
<th colspan="7">
<div class="checker"><span><input class="mail-checkbox mail-group-checkbox" type="checkbox"></span></div>
</th>
</thead>
<tbody>
<c:if test="${fn:length(msgList)==0}">
<tr>
<td colspan="7">
暂无回收信息。
</td>
</tr>
</c:if>
<c:forEach items="${msgList}" var="message" varStatus="status">
<tr <c:if test="${message.isRead=='0'}"> class="unread" </c:if> >
<td class="inbox-small-cells">
<div class="checker"><span><input class="mail-checkbox" type="checkbox" value="${message.msg_user_id}"></span></div>
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
<td class="view-message" style="vertical-align: middle;" onclick="Inbox.loadMessage('${message.msg_user_id}');">${message.messageSubject}</td>
<td class="view-message text-right" style="vertical-align: middle;width:20%" onclick="Inbox.loadMessage('${message.msg_user_id}');">${message.messageTime}</td>
<td class="view-message text-right" style="vertical-align: middle;width:10%">
${dim:toName('t_message_type',message.boxType)}
</td>
<td class="view-message text-right" style="vertical-align: middle;width:10%">
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
<a style="text-decoration:none;" href="javascript:Inbox.recycleMessage('${message.msg_user_id}');"><i class="icon-refresh"></i></a>
<a style="text-decoration:none;" href="javascript:Inbox.deleteMessage('${message.msg_user_id}');"><i class="icon-trash"></i></a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
${pagination}