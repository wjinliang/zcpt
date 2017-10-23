package com.dm.platform.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.FileEntity;
import com.dm.platform.service.FileService;
import com.dm.platform.util.ConfigUtil;

@Controller
@RequestMapping("/file")
public class FileController extends DefaultController {

	@Resource
	FileService fileService;

	@Resource
	CommonDAO commonDAO;

	@RequestMapping("/list")
	public ModelAndView list(
			ModelAndView model,
			FileEntity file,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = 20;
			}
			if (thispage == null) {
				thispage = 0;
			}
			Long totalcount = fileService.countFile(file);
			if ((thispage) * pagesize >= totalcount && totalcount > 0) {
				thispage--;
			}
			model.addObject("files",
					fileService.listFileEntity(file, thispage, pagesize));
			model.setViewName("/pages/admin/file/list");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/download/{fileid}")
	public void downloadFile(@PathVariable String fileid,
			HttpServletResponse response) throws UnsupportedEncodingException {
		FileEntity f = new FileEntity();
		f = commonDAO.findOne(FileEntity.class, fileid);
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		String fileName = f.getRealPath().substring(
				f.getRealPath().lastIndexOf("/") + 1);
		response.setHeader("Content-Disposition", "attachment;fileName="
				+ new String(fileName.getBytes("gbk"), "iso-8859-1"));
		try {
			File file = new File(f.getRealPath());
			InputStream inputStream = new FileInputStream(file);
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[1024];
			int length;
			while ((length = inputStream.read(b)) > 0) {
				os.write(b, 0, length);
			}
			inputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/delete")
	public void delete(HttpServletResponse response,
			@RequestParam(value = "fileid", required = false) String fileid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (fileid != null) {
				String[] ids = fileid.split(",");
				for (String str : ids) {
					FileEntity f = new FileEntity();
					f = fileService.findOne(str);
					if (f.getUserObject() != null
							&& !f.getUserObject().equals("")) {
						// 去掉关联
						commonDAO.execute("update " + f.getUserObject()
								+ " g set g." + f.getUrlField() + "= null,g."
								+ f.getObjField() + " = null where g."
								+ f.getObjField() + ".id='" + str + "'");
						// 逻辑删除
					}
					fileService.deleteOne(f);
				}
				out.write("ok");
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}

	@RequestMapping("/deleteReal")
	public void deleteReal(HttpServletResponse response,
			@RequestParam(value = "fileid", required = false) String fileid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (fileid != null) {
				String[] ids = fileid.split(",");
				for (String str : ids) {
					FileEntity f = new FileEntity();
					f = fileService.findOne(str);
					if (f.getUserObject() != null
							&& !f.getUserObject().equals("")) {
						// 去掉关联
						commonDAO.execute("update " + f.getUserObject()
								+ " g set g." + f.getUrlField() + "= null,g."
								+ f.getObjField() + " = null where g."
								+ f.getObjField() + ".id='" + str + "'");
						// 逻辑删除
					}
					fileService.deleteReal(f);
				}
				out.write("ok");
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/upload")
	public void upload(
			HttpServletResponse response,
			@RequestParam(value = "files[]", required = false) MultipartFile[] file) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			String path = ConfigUtil.getConfigContent("dm",
					"filePath");
			String folderUrl = ConfigUtil.getConfigContent("dm",
					"fileUrl");
			if (file.length > 0) {
				for (MultipartFile multipartFile : file) {
					String id = "";
					String realfileName = multipartFile.getOriginalFilename();
					String fileName = String
							.valueOf(System.currentTimeMillis())
							+ realfileName.substring(realfileName
									.lastIndexOf("."));
					File targetFile = new File(path);
					if (!targetFile.exists()) {
						targetFile.mkdirs();
					}
					SaveFileFromInputStream(multipartFile.getInputStream(),
							path, fileName);
					String url = folderUrl
							+ "/" + fileName;
					id = String.valueOf(System.currentTimeMillis());
					fileService.insertFile(id, url,
							String.valueOf(multipartFile.getSize()),
							realfileName, multipartFile.getContentType(), path
									+ "/" + fileName, "0");
					Map map = new HashMap();
					map.put("fileUrl", url);
					map.put("id", id);
					JSONObject jsonlist = JSONObject.fromObject(map);
					out.write(jsonlist.toString());
					out.flush();
					out.close();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}

	private void SaveFileFromInputStream(InputStream stream, String path,
			String filename) throws IOException {
		FileOutputStream fs = new FileOutputStream(path + "/" + filename);
		byte[] buffer = new byte[1024 * 1024];
		int byteread = 0;
		while ((byteread = stream.read(buffer)) != -1) {
			fs.write(buffer, 0, byteread);
			fs.flush();
		}
		fs.close();
		stream.close();
	}
	
	@RequestMapping("/fileJson")
	public @ResponseBody
	Object fileJson(
			@RequestParam(value = "fileId", required = true) String fileId) {
		try {
			FileEntity f = new FileEntity();
			f = fileService.findOne(fileId);
			Map result = new HashMap();
			Map data = new HashMap();
			if(f!=null)
			{
			data.put("id",f.getId());
			data.put("name", f.getName());
			data.put("size", f.getFilesize());
			data.put("fileUrl", f.getUrl());//用于获取url,来读取图片。@addBy zhaomin @date 2015-4-22
			}
			result.put("result", data);
			result.put("status", "1");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("异常！");
		}
	}

}
