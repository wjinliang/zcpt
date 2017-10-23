package com.dm.ais.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;


import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class FileSaveAndLoad {
	
	private static FileSaveAndLoad fileSaveAndLoad = new FileSaveAndLoad();
	private FileSaveAndLoad()
	{
		
	}
    public static FileSaveAndLoad getInstance()
    {
    	return fileSaveAndLoad;
    }
    public  synchronized  byte[] download(String location,String fileName) throws IOException
    {
    	File file = new File(location+fileName);  
    	long fileSize = file.length();   	
    	
			FileInputStream fis = new FileInputStream(file);
			byte[] bytes = new byte[(int) fileSize];
	        int numRead = fis.read(bytes, 0, bytes.length-0);
           
			/*while (offset < bytes.length  
				        && (numRead = fis.read(bytes, offset, bytes.length - offset)) >= 0) {  
				            offset += numRead;
				            k++;  
		 		        } */
            fis.close();
    	    return bytes;
    }
    
    public synchronized void saveFileGet(String url,String fileName,String location)
    {
    	HttpClient httpClient = new HttpClient();
    	HttpMethod method  = new GetMethod(url);
    	byte[] bytes = null;
    	try {
			int status = httpClient.executeMethod(method);
			bytes = method.getResponseBody();
			
		} catch (HttpException e) {
			// TODO Auto-generated catch block
		} catch (IOException e) {
			// TODO Auto-generated catch block
		}
    	File file = new File(location+fileName);
	    OutputStream opm = null;
		try {
			opm = new FileOutputStream(file);
			opm.write(bytes);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			
		}
		finally{
			try {
				opm.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
			}
		}
    }
}
