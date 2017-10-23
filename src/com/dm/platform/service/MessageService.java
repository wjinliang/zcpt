package com.dm.platform.service;

import java.util.List;
import java.util.Map;

import com.dm.platform.dto.MessageDto;
import com.dm.platform.model.FileEntity;
import com.dm.platform.model.Message;

public interface MessageService {
	public void insertMessage(Message entity);

	public void insertOrUpdateMessage(Message entity);
	
	public void updateMessage(Message entity);

	public String newMessage(String subject, String content, String link,
			String to, String from, String fromUserId, String hasAttach);

	public void sendMessage(String messageId, String toUserId);

	public void sentMessage(String messageId, String fromUserId);

	public void draft2sentMessage(String msg_user_id);
	
	public void draftMessage(String fromUserId,String messageId);
	
	public void draft2draftMessage(String msg_user_id);
	
	public void trashMessage(String msg_user_id,String flag);

	public void setIsRead(String msg_user_id,String flag);
	
	public void setIsDelete(String msg_user_id,String flag);
	
	public void setIsMark(String msg_user_id,String flag);
	
	public MessageDto getMessageById(String msg_user_id);

	public Map<String, Object> getNewMessages(String userId, Integer thispage,
			Integer pagesize);

	public Map<String, Object> getAllMessages(String userId, Integer thispage,
			Integer pagesize);

	public Map<String, Object> getSentMessages(String userId, Integer thispage,
			Integer pagesize);

	public Map<String, Object> getDraftMessages(String userId,
			Integer thispage, Integer pagesize);

	public Map<String, Object> getTrashMessages(String userId,
			Integer thispage, Integer pagesize);

	public Map<String, Object> getMarkMessages(String userId,
			Integer thispage, Integer pagesize);

	public int getNewMessagesCount(String userId);
	
	public List<FileEntity> getAttechments(String messageId,String status);
	
	public void addAttechment(String messageId,String fileId,String status);
	
}
