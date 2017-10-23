package com.dm.platform.dto;

import java.io.Serializable;

import com.dm.platform.model.Message;
import com.dm.platform.util.DmDateUtil;

public class MessageDto extends Message implements Serializable{

	/**
	 * @author CHENGJ
	 */
	private static final long serialVersionUID = -1425705524243643029L;
	
	private String msg_user_id;
	private String isRead;
	private String isMark;
	private String isTrash;
	private String boxType;

	public String getIsRead() {
		return isRead;
	}
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
	public String getMessageTime() {
		String time = DmDateUtil.formatDateTime(getMessageDate());
		return time;
	}
	public String getIsMark() {
		return isMark;
	}
	public void setIsMark(String isMark) {
		this.isMark = isMark;
	}
	public String getMsg_user_id() {
		return msg_user_id;
	}
	public void setMsg_user_id(String msg_user_id) {
		this.msg_user_id = msg_user_id;
	}
	public String getIsTrash() {
		return isTrash;
	}
	public void setIsTrash(String isTrash) {
		this.isTrash = isTrash;
	}
	public String getBoxType() {
		return boxType;
	}
	public void setBoxType(String boxType) {
		this.boxType = boxType;
	}
}
