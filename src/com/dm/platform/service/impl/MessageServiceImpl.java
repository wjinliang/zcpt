package com.dm.platform.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.dto.MessageDto;
import com.dm.platform.model.FileEntity;
import com.dm.platform.model.Message;
import com.dm.platform.service.MessageService;
import com.dm.platform.util.DmDateUtil;

@Service
public class MessageServiceImpl implements MessageService {

	@Resource
	CommonDAO commonDAO;
	@Resource
	JdbcTemplate jdbcTemplate;

	@Override
	public String newMessage(String subject, String content, String link,
			String to, String from, String fromUserId, String hasAttach) {
		// TODO Auto-generated method stub
		Message entity = new Message();
		String id = String.valueOf(System.currentTimeMillis());
		entity.setMessageId(id);
		entity.setMessageDate(DmDateUtil.DateToStr(new Date()));
		entity.setMessageFromUserId(fromUserId);
		entity.setTo(to);
		entity.setFrom(from);
		entity.setMessageFromUserId(fromUserId);
		entity.setMessageSubject(subject);
		entity.setMessageContent(content);
		entity.setMessageLink(link);
		entity.setHasAttach(hasAttach);
		commonDAO.save(entity);
		return id;
	}

	@Override
	public void sendMessage(String messageId, String toUserId) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO T_MESSAGE_USER(ID,MESSAGE_ID,USER_ID,IS_READ,BOX_TYPE,IS_DELETE,IS_MARK) VALUES(?,?,?,?,?,?,?)";
		jdbcTemplate.update(sql,
				new Object[] { String.valueOf(System.currentTimeMillis()),
						messageId, toUserId, "0", "1", "0", "0" });
	}

	@Override
	public void sentMessage(String messageId, String fromUserId) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO T_MESSAGE_USER(ID,MESSAGE_ID,USER_ID,IS_READ,BOX_TYPE,IS_DELETE,IS_MARK) VALUES(?,?,?,?,?,?,?)";
		jdbcTemplate.update(sql,
				new Object[] { String.valueOf(System.currentTimeMillis()),
						messageId, fromUserId, "1", "2", "0", "0" });
	}
	
	@Override
	public void draft2sentMessage(String msg_user_id) {
		// TODO Auto-generated method stub
		String sql = "UPDATE T_MESSAGE_USER T SET T.IS_TRASH = ?,T.BOX_TYPE = ? WHERE T.ID = ?";
		jdbcTemplate.update(sql, new Object[] { "0","2",msg_user_id });
	}
	
	@Override
	public void draftMessage(String fromUserId, String messageId) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO T_MESSAGE_USER(ID,MESSAGE_ID,USER_ID,IS_READ,BOX_TYPE,IS_DELETE,IS_MARK) VALUES(?,?,?,?,?,?,?)";
		jdbcTemplate.update(sql,
				new Object[] { String.valueOf(System.currentTimeMillis()),
						messageId, fromUserId, "0", "3", "0", "0" });
	}

	@Override
	public Map<String, Object> getNewMessages(String userId, Integer thispage,
			Integer pagesize) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String sql = "SELECT T.*,G.* FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='1' AND G.USER_ID=? AND G.IS_READ='0' AND G.IS_TRASH='0' AND G.IS_DELETE='0' ORDER BY T.MESSAGE_DATE DESC LIMIT ?,?";
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = jdbcTemplate.queryForList(sql, new Object[] { userId, thispage,
				pagesize });
		List<MessageDto> mlist = new ArrayList<MessageDto>();
		for (Map<String, Object> map1 : list) {
			MessageDto dto = new MessageDto();
			dto.setMessageId((String) map1.get("MESSAGE_ID"));
			dto.setMessageSubject((String) map1.get("MESSAGE_SUBJECT"));
			dto.setMessageContent((String) map1.get("MESSAGE_CONTENT"));
			dto.setMessageDate((String) map1.get("MESSAGE_DATE"));
			dto.setMessageFromUserId((String) map1.get("MESSAGE_FROM_USER_ID"));
			dto.setMessageLink((String) map1.get("MESSAGE_LINK"));
			dto.setTo((String) map1.get("TO_STR"));
			dto.setFrom((String) map1.get("FROM_STR"));
			dto.setIsRead((String) map1.get("IS_READ"));
			dto.setIsMark((String) map1.get("IS_MARK"));
			dto.setMsg_user_id((String) map1.get("ID"));
			dto.setIsTrash((String) map1.get("IS_TRASH"));
			mlist.add(dto);
		}
		map.put("items", mlist);
		String countSql = "SELECT COUNT(*) FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='1' AND G.USER_ID=? AND G.IS_READ='0' AND G.IS_TRASH='0' AND G.IS_DELETE='0'";
		Long totalcount = jdbcTemplate.queryForObject(countSql,
				new Object[] { userId }, Long.class);
		map.put("totalcount", totalcount);
		return map;
	}

	@Override
	public int getNewMessagesCount(String userId) {
		// TODO Auto-generated method stub
		String sql = "SELECT COUNT(*) FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='1' AND G.USER_ID=? AND G.IS_READ='0' AND G.IS_TRASH='0' AND G.IS_DELETE='0'";
		Integer count = jdbcTemplate.queryForObject(sql,
				new Object[] { userId }, Integer.class);
		return count == null ? 0 : count.intValue();
	}

	@Override
	public Map<String, Object> getAllMessages(String userId, Integer thispage,
			Integer pagesize) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String sql = "SELECT T.*,G.* FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='1' AND G.USER_ID=? AND G.IS_TRASH='0' AND G.IS_DELETE='0' ORDER BY T.MESSAGE_DATE DESC LIMIT ?,?";
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = jdbcTemplate.queryForList(sql, new Object[] { userId, thispage,
				pagesize });
		List<MessageDto> mlist = new ArrayList<MessageDto>();
		for (Map<String, Object> map1 : list) {
			MessageDto dto = new MessageDto();
			dto.setMessageId((String) map1.get("MESSAGE_ID"));
			dto.setMessageSubject((String) map1.get("MESSAGE_SUBJECT"));
			dto.setMessageContent((String) map1.get("MESSAGE_CONTENT"));
			dto.setMessageDate((String) map1.get("MESSAGE_DATE"));
			dto.setMessageFromUserId((String) map1.get("MESSAGE_FROM_USER_ID"));
			dto.setMessageLink((String) map1.get("MESSAGE_LINK"));
			dto.setTo((String) map1.get("TO_STR"));
			dto.setFrom((String) map1.get("FROM_STR"));
			dto.setIsRead((String) map1.get("IS_READ"));
			dto.setIsMark((String) map1.get("IS_MARK"));
			dto.setMsg_user_id((String) map1.get("ID"));
			dto.setIsTrash((String) map1.get("IS_TRASH"));
			mlist.add(dto);
		}
		map.put("items", mlist);
		String countSql = "SELECT COUNT(*) FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='1' AND G.USER_ID=? AND G.IS_TRASH='0' AND G.IS_DELETE='0'";
		Long totalcount = jdbcTemplate.queryForObject(countSql,
				new Object[] { userId }, Long.class);
		map.put("totalcount", totalcount);
		return map;
	}

	@Override
	public MessageDto getMessageById(String msg_user_id) {
		// TODO Auto-generated method stub
		String sql = "SELECT G.* FROM T_MESSAGE_USER G WHERE G.ID=?";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,
				new Object[] { msg_user_id });
		if (list.size() > 0) {
			MessageDto dto = new MessageDto();
			Map<String, Object> map1 = list.get(0);
			dto.setMsg_user_id((String) map1.get("ID"));
			dto.setIsRead((String) map1.get("IS_READ"));
			dto.setIsMark((String) map1.get("IS_MARK"));
			dto.setIsTrash((String) map1.get("IS_TRASH"));
			String messageId = (String) map1.get("MESSAGE_ID");
			Message entity = new Message();
			entity = commonDAO.findOne(Message.class, messageId);
			dto.setMessageId(entity.getMessageId());
			dto.setMessageSubject(entity.getMessageSubject());
			dto.setMessageContent(entity.getMessageContent());
			dto.setMessageDate(entity.getMessageDate());
			dto.setMessageFromUserId(entity.getMessageFromUserId());
			dto.setMessageLink(entity.getMessageLink());
			dto.setTo(entity.getTo());
			dto.setFrom(entity.getFrom());
			dto.setHasAttach(entity.getHasAttach());
			dto.setBoxType((String) map1.get("BOX_TYPE"));
			return dto;
		} else {
			return null;
		}
	}

	@Override
	public Map<String, Object> getSentMessages(String userId, Integer thispage,
			Integer pagesize) {
		Map<String, Object> map = new HashMap<String, Object>();
		String sql = "SELECT T.*,G.* FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='2' AND G.USER_ID=? AND G.IS_TRASH='0' AND G.IS_DELETE='0' ORDER BY T.MESSAGE_DATE DESC LIMIT ?,?";
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = jdbcTemplate.queryForList(sql, new Object[] { userId, thispage,
				pagesize });
		List<MessageDto> mlist = new ArrayList<MessageDto>();
		for (Map<String, Object> map1 : list) {
			MessageDto dto = new MessageDto();
			dto.setMessageId((String) map1.get("MESSAGE_ID"));
			dto.setMessageSubject((String) map1.get("MESSAGE_SUBJECT"));
			dto.setMessageContent((String) map1.get("MESSAGE_CONTENT"));
			dto.setMessageDate((String) map1.get("MESSAGE_DATE"));
			dto.setMessageFromUserId((String) map1.get("MESSAGE_FROM_USER_ID"));
			dto.setMessageLink((String) map1.get("MESSAGE_LINK"));
			dto.setTo((String) map1.get("TO_STR"));
			dto.setFrom((String) map1.get("FROM_STR"));
			dto.setIsRead((String) map1.get("IS_READ"));
			dto.setIsMark((String) map1.get("IS_MARK"));
			dto.setMsg_user_id((String) map1.get("ID"));
			dto.setIsTrash((String) map1.get("IS_TRASH"));
			mlist.add(dto);
		}
		map.put("items", mlist);
		String countSql = "SELECT COUNT(*) FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='2' AND G.USER_ID=? AND G.IS_TRASH='0' AND G.IS_DELETE='0'";
		Long totalcount = jdbcTemplate.queryForObject(countSql,
				new Object[] { userId }, Long.class);
		map.put("totalcount", totalcount);
		return map;
	}

	@Override
	public Map<String, Object> getDraftMessages(String userId,
			Integer thispage, Integer pagesize) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String sql = "SELECT T.*,G.* FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='3' AND G.USER_ID=? AND G.IS_TRASH='0' AND G.IS_DELETE='0' ORDER BY T.MESSAGE_DATE DESC LIMIT ?,?";
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = jdbcTemplate.queryForList(sql, new Object[] { userId, thispage,
				pagesize });
		List<MessageDto> mlist = new ArrayList<MessageDto>();
		for (Map<String, Object> map1 : list) {
			MessageDto dto = new MessageDto();
			dto.setMessageId((String) map1.get("MESSAGE_ID"));
			dto.setMessageSubject((String) map1.get("MESSAGE_SUBJECT"));
			dto.setMessageContent((String) map1.get("MESSAGE_CONTENT"));
			dto.setMessageDate((String) map1.get("MESSAGE_DATE"));
			dto.setMessageFromUserId((String) map1.get("MESSAGE_FROM_USER_ID"));
			dto.setMessageLink((String) map1.get("MESSAGE_LINK"));
			dto.setTo((String) map1.get("TO_STR"));
			dto.setFrom((String) map1.get("FROM_STR"));
			dto.setIsRead((String) map1.get("IS_READ"));
			dto.setIsMark((String) map1.get("IS_MARK"));
			dto.setMsg_user_id((String) map1.get("ID"));
			dto.setIsTrash((String) map1.get("IS_TRASH"));
			mlist.add(dto);
		}
		map.put("items", mlist);
		String countSql = "SELECT COUNT(*) FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.BOX_TYPE='3' AND G.USER_ID=? AND G.IS_TRASH='0' AND G.IS_DELETE='0'";
		Long totalcount = jdbcTemplate.queryForObject(countSql,
				new Object[] { userId }, Long.class);
		map.put("totalcount", totalcount);
		return map;
	}

	@Override
	public Map<String, Object> getTrashMessages(String userId,
			Integer thispage, Integer pagesize) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String sql = "SELECT T.*,G.* FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.USER_ID=? AND G.IS_TRASH='1' AND G.IS_DELETE='0' ORDER BY T.MESSAGE_DATE DESC LIMIT ?,?";
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = jdbcTemplate.queryForList(sql, new Object[] { userId, thispage,
				pagesize });
		List<MessageDto> mlist = new ArrayList<MessageDto>();
		for (Map<String, Object> map1 : list) {
			MessageDto dto = new MessageDto();
			dto.setMessageId((String) map1.get("MESSAGE_ID"));
			dto.setMessageSubject((String) map1.get("MESSAGE_SUBJECT"));
			dto.setMessageContent((String) map1.get("MESSAGE_CONTENT"));
			dto.setMessageDate((String) map1.get("MESSAGE_DATE"));
			dto.setMessageFromUserId((String) map1.get("MESSAGE_FROM_USER_ID"));
			dto.setMessageLink((String) map1.get("MESSAGE_LINK"));
			dto.setTo((String) map1.get("TO_STR"));
			dto.setFrom((String) map1.get("FROM_STR"));
			dto.setIsRead((String) map1.get("IS_READ"));
			dto.setIsMark((String) map1.get("IS_MARK"));
			dto.setMsg_user_id((String) map1.get("ID"));
			dto.setIsTrash((String) map1.get("IS_TRASH"));
			dto.setBoxType((String) map1.get("BOX_TYPE"));
			mlist.add(dto);
		}
		map.put("items", mlist);
		String countSql = "SELECT COUNT(*) FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.USER_ID=? AND G.IS_TRASH='1' AND G.IS_DELETE='0'";
		Long totalcount = jdbcTemplate.queryForObject(countSql,
				new Object[] { userId }, Long.class);
		map.put("totalcount", totalcount);
		return map;
	}
	
	@Override
	public Map<String, Object> getMarkMessages(String userId,
			Integer thispage, Integer pagesize) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String sql = "SELECT T.*,G.* FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.USER_ID=? AND G.IS_MARK='1' AND G.IS_TRASH='0' AND G.IS_DELETE='0' ORDER BY T.MESSAGE_DATE DESC LIMIT ?,?";
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = jdbcTemplate.queryForList(sql, new Object[] { userId, thispage,
				pagesize });
		List<MessageDto> mlist = new ArrayList<MessageDto>();
		for (Map<String, Object> map1 : list) {
			MessageDto dto = new MessageDto();
			dto.setMessageId((String) map1.get("MESSAGE_ID"));
			dto.setMessageSubject((String) map1.get("MESSAGE_SUBJECT"));
			dto.setMessageContent((String) map1.get("MESSAGE_CONTENT"));
			dto.setMessageDate((String) map1.get("MESSAGE_DATE"));
			dto.setMessageFromUserId((String) map1.get("MESSAGE_FROM_USER_ID"));
			dto.setMessageLink((String) map1.get("MESSAGE_LINK"));
			dto.setTo((String) map1.get("TO_STR"));
			dto.setFrom((String) map1.get("FROM_STR"));
			dto.setIsRead((String) map1.get("IS_READ"));
			dto.setIsMark((String) map1.get("IS_MARK"));
			dto.setMsg_user_id((String) map1.get("ID"));
			dto.setIsTrash((String) map1.get("IS_TRASH"));
			dto.setBoxType((String) map1.get("BOX_TYPE"));
			mlist.add(dto);
		}
		map.put("items", mlist);
		String countSql = "SELECT COUNT(*) FROM T_MESSAGE_USER G,T_MESSAGE T WHERE G.MESSAGE_ID=T.MESSAGE_ID AND G.USER_ID=? AND G.IS_Mark='1' AND G.IS_TRASH='0' AND G.IS_DELETE='0'";
		Long totalcount = jdbcTemplate.queryForObject(countSql,
				new Object[] { userId }, Long.class);
		map.put("totalcount", totalcount);
		return map;
	}

	@Override
	public void insertMessage(Message entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void updateMessage(Message entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void setIsRead(String msg_user_id, String flag) {
		// TODO Auto-generated method stub
		String sql = "UPDATE T_MESSAGE_USER T SET T.IS_READ = ? WHERE T.ID = ?";
		jdbcTemplate.update(sql, new Object[] { flag, msg_user_id });
	}

	@Override
	public void setIsDelete(String msg_user_id, String flag) {
		// TODO Auto-generated method stub
		String sql = "UPDATE T_MESSAGE_USER T SET T.IS_DELETE = ? WHERE T.ID = ?";
		jdbcTemplate.update(sql, new Object[] { flag, msg_user_id });
	}

	@Override
	public void setIsMark(String msg_user_id, String flag) {
		// TODO Auto-generated method stub
		String sql = "UPDATE T_MESSAGE_USER T SET T.IS_MARK = ? WHERE T.ID = ?";
		jdbcTemplate.update(sql, new Object[] { flag, msg_user_id });
	}

	@Override
	public void trashMessage(String msg_user_id, String flag) {
		// TODO Auto-generated method stub
		String sql = "UPDATE T_MESSAGE_USER T SET T.IS_TRASH = ? WHERE T.ID = ?";
		jdbcTemplate.update(sql, new Object[] { flag, msg_user_id });
	}

	@Override
	public void insertOrUpdateMessage(Message entity) {
		// TODO Auto-generated method stub
		commonDAO.saveOrUpdate(entity);
	}

	@Override
	public void draft2draftMessage(String msg_user_id) {
		// TODO Auto-generated method stub
		String sql = "UPDATE T_MESSAGE_USER T SET T.IS_TRASH = 0 WHERE T.ID = ?";
		jdbcTemplate.update(sql, new Object[] {msg_user_id });
	}

	@Override
	public List<FileEntity> getAttechments(String messageId, String status) {
		// TODO Auto-generated method stub
		String sql = "SELECT T.* FROM T_MESSAGE_FILE G,T_FILETABLE T WHERE G.FILE_ID=T.ID AND G.MESSAGE_ID = ? AND G.STATUS = ? ORDER BY T.CDATE DESC";
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = jdbcTemplate.queryForList(sql, new Object[] { messageId, status});
		List<FileEntity> mlist = new ArrayList<FileEntity>();
		for (Map<String, Object> map1 : list) {
			FileEntity dto = new FileEntity();
			dto.setId((String)map1.get("ID"));
			dto.setName((String)map1.get("NAME"));
			dto.setUrl((String)map1.get("URL"));
			dto.setRealPath((String)map1.get("REALPATH"));
			dto.setFilesize((String)map1.get("FILESIZE"));
			mlist.add(dto);
		}
		return mlist;
	}

	@Override
	public void addAttechment(String messageId, String fileId, String status) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO T_MESSAGE_FILE(ID,MESSAGE_ID,FILE_ID,STATUS) VALUES(?,?,?,?)";
		jdbcTemplate.update(sql, new Object[] {String.valueOf(System.currentTimeMillis()),messageId, fileId,status });
	}

}
