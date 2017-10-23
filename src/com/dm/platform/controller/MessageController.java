package com.dm.platform.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.platform.dto.MessageDto;
import com.dm.platform.model.FileEntity;
import com.dm.platform.model.Message;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.FileService;
import com.dm.platform.service.MessageService;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.util.DmDateUtil;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping("/message")
public class MessageController extends DefaultController {
	@Resource
	MessageService messageService;
	@Resource
	UserAccountService userAccountService;
	@Resource
	FileService fileService;

	@RequestMapping("/messageCenter")
	public ModelAndView messageCenter(ModelAndView model) {
		try {
			model.setViewName("/pages/admin/message/message_center");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/listInbox")
	public ModelAndView listInbox(ModelAndView model, Integer thispage) {
		try {
			if (thispage == null) {
				thispage = 0;
			}
			List<Message> list = new ArrayList<Message>();
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			Map<String, Object> map = new HashMap<String, Object>();
			map = messageService.getAllMessages(currentUser.getCode(),
					thispage, 20);
			list = (List<Message>) map.get("items");
			Long totalcount = (Long) map.get("totalcount");
			model.addObject("msgList", list);
			model.addObject("path", "listAll");
			model.setViewName("/pages/admin/message/list_inbox");
			return Model(model, thispage, 20, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/listOutbox")
	public ModelAndView listOutbox(ModelAndView model, Integer thispage) {
		try {
			if (thispage == null) {
				thispage = 0;
			}
			List<Message> list = new ArrayList<Message>();
			String currentUserId = UserAccountUtil.getInstance()
					.getCurrentUserId();
			Map<String, Object> map = new HashMap<String, Object>();
			map = messageService.getSentMessages(currentUserId, thispage, 20);
			list = (List<Message>) map.get("items");
			Long totalcount = (Long) map.get("totalcount");
			model.addObject("msgList", list);
			model.setViewName("/pages/admin/message/list_outbox");
			return Model(model, thispage, 20, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/listDraft")
	public ModelAndView listDraft(ModelAndView model, Integer thispage) {
		try {
			if (thispage == null) {
				thispage = 0;
			}
			List<Message> list = new ArrayList<Message>();
			String currentUserId = UserAccountUtil.getInstance()
					.getCurrentUserId();
			Map<String, Object> map = new HashMap<String, Object>();
			map = messageService.getDraftMessages(currentUserId, thispage, 20);
			list = (List<Message>) map.get("items");
			Long totalcount = (Long) map.get("totalcount");
			model.addObject("msgList", list);
			model.setViewName("/pages/admin/message/list_draft");
			return Model(model, thispage, 20, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/listTrash")
	public ModelAndView listTrash(ModelAndView model, Integer thispage) {
		try {
			if (thispage == null) {
				thispage = 0;
			}
			List<Message> list = new ArrayList<Message>();
			String currentUserId = UserAccountUtil.getInstance()
					.getCurrentUserId();
			Map<String, Object> map = new HashMap<String, Object>();
			map = messageService.getTrashMessages(currentUserId, thispage, 20);
			list = (List<Message>) map.get("items");
			Long totalcount = (Long) map.get("totalcount");
			model.addObject("msgList", list);
			model.setViewName("/pages/admin/message/list_trash");
			return Model(model, thispage, 20, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/listMark")
	public ModelAndView listMark(ModelAndView model, Integer thispage) {
		try {
			if (thispage == null) {
				thispage = 0;
			}
			List<Message> list = new ArrayList<Message>();
			String currentUserId = UserAccountUtil.getInstance()
					.getCurrentUserId();
			Map<String, Object> map = new HashMap<String, Object>();
			map = messageService.getMarkMessages(currentUserId, thispage, 20);
			list = (List<Message>) map.get("items");
			Long totalcount = (Long) map.get("totalcount");
			model.addObject("msgList", list);
			model.setViewName("/pages/admin/message/list_mark");
			return Model(model, thispage, 20, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/loadMessage")
	public ModelAndView loadMessage(ModelAndView model, String msg_user_id) {
		try {
			messageService.setIsRead(msg_user_id, "1");
			MessageDto dto = messageService.getMessageById(msg_user_id);
			model.addObject("inbox", dto);
			List<FileEntity> flist = messageService.getAttechments(dto.getMessageId(), "1");
			model.addObject("attachments", flist);
			model.setViewName("/pages/admin/message/load_message");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/loadSentMessage")
	public ModelAndView loadSentMessage(ModelAndView model, String msg_user_id) {
		try {
			MessageDto entity = messageService.getMessageById(msg_user_id);
			model.addObject("inbox", entity);
			List<FileEntity> flist = messageService.getAttechments(entity.getMessageId(), "1");
			model.addObject("attachments", flist);
			model.setViewName("/pages/admin/message/load_sent_message");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/loadDraftMessage")
	public ModelAndView loadDraftMessage(ModelAndView model, String msg_user_id) {
		try {
			MessageDto entity = messageService.getMessageById(msg_user_id);
			model.addObject("entity", entity);
			List<FileEntity> flist = messageService.getAttechments(entity.getMessageId(), "0");
			model.addObject("attachments", flist);
			model.setViewName("/pages/admin/message/write_message");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/writeMessage")
	public ModelAndView writeMessage(ModelAndView model) {
		try {
			String messageId = String.valueOf(System.currentTimeMillis());
			MessageDto entity = new MessageDto();
			entity.setMessageId(messageId);
			model.addObject("entity", entity);
			model.setViewName("/pages/admin/message/write_message");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/replyMessage")
	public ModelAndView replyMessage(ModelAndView model, String msg_user_id) {
		try {
			MessageDto entity = messageService.getMessageById(msg_user_id);
			entity.setMessageId(String.valueOf(System.currentTimeMillis()));
			entity.setMsg_user_id("");
			entity.setMessageContent(getReplyHeadContent(entity.getFrom(),
					entity.getTo(), entity.getMessageDate(),
					entity.getMessageSubject(), entity.getMessageContent()));
			entity.setTo(entity.getFrom());
			entity.setMessageSubject("回复："+entity.getMessageSubject());
			model.addObject("entity", entity);
			model.setViewName("/pages/admin/message/write_message");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	
	@RequestMapping("/editMessage")
	public ModelAndView editMessage(ModelAndView model, String msg_user_id) {
		try {
			MessageDto entity = messageService.getMessageById(msg_user_id);
			String oldId = entity.getMessageId();
			entity.setMessageId(String.valueOf(System.currentTimeMillis()));
			entity.setMsg_user_id("");
			model.addObject("entity", entity);
			List<FileEntity> flist = messageService.getAttechments(entity.getMessageId(), "1");
			model.addObject("attachments", flist);
			model.setViewName("/pages/admin/message/write_message");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/sendMessage")
	public ModelAndView sendMessage(ModelAndView model, Message entity,
			String to, String isDraft, String msg_user_id, String content,String attId) {
		try {
			UserAccount cUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			entity.setMessageDate(DmDateUtil.Current());
			entity.setMessageFromUserId(cUser.getCode());
			entity.setHasAttach("0");
			entity.setTo(to);
			entity.setFrom(cUser.getName() + "[" + cUser.getEmail() + "]");
			entity.setMessageContent(content);
			// 生成主表数据
			messageService.insertOrUpdateMessage(entity);
			
			if (isDraft != null && isDraft.equals("0")) {
				if (msg_user_id != null && !msg_user_id.equals("")) {
					messageService.draft2sentMessage(msg_user_id);
				} else {
					// 生成已发数据
					messageService.sentMessage(entity.getMessageId(),
							cUser.getCode());
				}
				String[] lgn = to.split(",");
				for (String str : lgn) {
					if (str.indexOf("[") != -1 && str.indexOf("]") != -1) {
						str = str.substring(str.indexOf("[") + 1,
								str.indexOf("]"));
						UserAccount u = userAccountService.findByEmail(str);
						// 发送数据
						messageService.sendMessage(entity.getMessageId(),
								u.getCode());
					}
				}
				
				
				if(attId!=null&&!attId.equals("")){
					String[] ids = attId.split(",");
					for (String id : ids) {
						messageService.addAttechment(entity.getMessageId(), id, "1");
					}
				}
				
			} else if (isDraft != null && isDraft.equals("1")) {
				if (msg_user_id != null && !msg_user_id.equals("")) {
					messageService.draft2draftMessage(msg_user_id);
				} else {
					messageService.draftMessage(cUser.getCode(),
							entity.getMessageId());
				}
				
				if(attId!=null&&!attId.equals("")){
					String[] ids = attId.split(",");
					for (String id : ids) {
						messageService.addAttechment(entity.getMessageId(), id, "0");
					}
				}
			}
			model.addObject("redirect", getRootPath()
					+ "/message/messageCenter");
			model.setViewName("/pages/content/redirect");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/draftMessage")
	public ModelAndView draftMessage(ModelAndView model, Message entity,
			String to) {
		try {
			entity.setMessageDate(DmDateUtil.Current());
			entity.setMessageFromUserId(UserAccountUtil.getInstance()
					.getCurrentUserId());
			entity.setHasAttach("0");
			messageService.insertMessage(entity);
			model.addObject("redirect", getRootPath()
					+ "/message/messageCenter");
			model.setViewName("/pages/content/redirect");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/trashMessage")
	public void trashMessage(HttpServletResponse response, String msg_user_id)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			messageService.trashMessage(msg_user_id, "1");
			out.write("y");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.write("n");
			out.flush();
			out.close();
		}
	}
	
	@RequestMapping("/deleteMessage")
	public void deleteMessage(HttpServletResponse response, String msg_user_id)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			messageService.setIsDelete(msg_user_id, "1");
			out.write("y");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.write("n");
			out.flush();
			out.close();
		}
	}

	@RequestMapping("/recycleMessage")
	public void recycleMessage(HttpServletResponse response, String msg_user_id)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			messageService.trashMessage(msg_user_id, "0");
			out.write("y");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.write("n");
			out.flush();
			out.close();
		}
	}

	@RequestMapping("/markMessage")
	public void markMessage(HttpServletResponse response, String msg_user_id)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			messageService.setIsMark(msg_user_id, "1");
			out.write("y");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.write("n");
			out.flush();
			out.close();
		}
	}

	@RequestMapping("/cancelMarkMessage")
	public void cancelMarkMessage(HttpServletResponse response,
			String msg_user_id) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			messageService.setIsMark(msg_user_id, "0");
			out.write("y");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.write("n");
			out.flush();
			out.close();
		}
	}

	private String getReplyHeadContent(String from, String to,
			String messageDate, String subject, String m_content) {
		StringBuffer content = new StringBuffer();
		content.append("<br/>");
		content.append("<br/>");
		content.append("<div style=\"background-color:#FFFFFF;font-family:'Arial Narrow';padding:2px 0px;\">");
		content.append("------------------&nbsp;原始邮件&nbsp;------------------");
		content.append("</div>");
		content.append("<div style=\"font-family:Verdana;background-color:#EFEFEF;padding:8px;\">");
		content.append("<div><b>发件人:</b>&nbsp;" + from + "</div>");
		content.append("<div><b>发送时间:</b>&nbsp;" + messageDate + "</div>");
		content.append("<div><b>收件人:</b>&nbsp;" + to + "</div>");
		content.append("<div></div>");
		content.append("<div><b>主题:</b>&nbsp;" + subject + "</div>");
		content.append("</div>");
		content.append("<br/>");
		content.append(m_content);
		return content.toString();
	}
	
}
