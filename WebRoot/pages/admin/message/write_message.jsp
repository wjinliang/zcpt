<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<form action="${root}/message/sendMessage" method="post"
	id="format_form" name="msg_form">

	<div class="inbox-compose-btn">
		<input name="messageId" value="${entity.messageId}" type="hidden">
		<input id="isDraft" name="isDraft" value="0" type="hidden"> <input
			id="msg_user_id" name="msg_user_id" value="${entity.msg_user_id}"
			type="hidden">
		<button type="submit" class="btn blue">
			<i class="icon-check"></i>发送
		</button>
		<button type="button" onclick="draftMessage()" class="btn">存为草稿</button>
	</div>
	<div class="inbox-form-group mail-to">
		<label class="control-label">发送给:</label>
		<div class="controls controls-to">
			<input class="form-control" name="to" value="${entity.to}"
				type="text">
		</div>
	</div>
	<div class="inbox-form-group">
		<label class="control-label">主题:</label>
		<div class="controls">
			<input class="form-control span12" name="messageSubject"
				value="${entity.messageSubject}" type="text">
		</div>
	</div>

	<div class="inbox-form-group">
		<textarea id="editor_id" name="content" class="span12 m-wrap"
			style="height:400px;">${entity.messageContent}</textarea>
	</div>
	<hr>
	<div class="inbox-compose-attachment">
		<span class="btn green fileinput-button"> <i class="icon-plus"></i>
			<span>添加附件...</span> <input id="fileupload" name="files[]" multiple
			type="file"> </span>
		<!-- The table listing the files available for upload/download -->
		<table role="presentation" class="table table-striped margin-top-10">
			<tbody class="files" data-toggle="modal-gallery"
				data-target="#modal-gallery">
				<c:forEach items="${attachments}" var="attachment" varStatus="status">
					<tr class="template-upload fade in" id="tr_${attachment.id}">
						<td><span class="preview"><canvas width="46"
									height="40"></canvas>
						</span></td>
						<td>
							<p class="name">${attachment.name}</p></td>
						<td>
							<p class="size">${attachment.filesize2} KB</p></td>
						<td>
							<button type="button" onclick="removeTr('${attachment.id}')" class="btn btn-warning delete" id="del_${attachment.id}">
								<i class="icon-trash icon-white"></i> <span>删除</span>
							</button></td>
						<input type="hidden" name="attId" value="${attachment.id}" class="att" />
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<hr>
	<div class="inbox-compose-btn">
		<button type="submit" class="btn blue">
			<i class="icon-check"></i>发送
		</button>
		<button type="button" onclick="draftMessage()" class="btn">存为草稿</button>
	</div>
</form>

<script>
	$(function() {
		KindEditor.ready(function(K) {
			var editor1 = K.create('#editor_id', {
				uploadJson : '${root}/KE/file_upload',
				fileManagerJson : '${root}/KE/file_manager',
				allowFileManager : true,
				afterBlur : function() {
					this.sync();
				}
			});

		});
	})
	function draftMessage() {
		document.getElementById("isDraft").value = "1";
		document.getElementById("format_form").submit();
	}
	function removeTr(id){
		$("#tr_"+id).remove();
	}
</script>

