 package com.dm.platform.util;
/*     */ import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
import java.io.InputStreamReader;
/*     */ import java.io.ObjectInputStream;
/*     */ import java.io.PrintStream;
/*     */ import java.net.InetAddress;
/*     */ import java.net.NetworkInterface;
/*     */ import java.net.SocketException;
/*     */ import java.net.URL;
/*     */ import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.nio.charset.CharsetEncoder;
import java.nio.charset.spi.CharsetProvider;
import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
/*     */ import java.security.PrivateKey;
/*     */ import java.security.PublicKey;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.text.FieldPosition;
import java.text.ParseException;
/*     */ import java.text.SimpleDateFormat;
/*     */ import java.util.Date;
import java.util.HashMap;
import java.util.Map;
/*     */ import java.util.Properties;

import javax.crypto.Cipher;


/*     */ public class KeyRSA
/*     */ {
	public static final String KEY_ALGORITHM = "RSA";  
	public static final String SIGNATURE_ALGORITHM = "MD5withRSA";  

	/** *//** 
	 * 获取公钥的key 
	 */  
	private static final String PUBLIC_KEY = "RSAPublicKey";  
	  
	/** *//** 
	 * 获取私钥的key 
	 */  
	private static final String PRIVATE_KEY = "RSAPrivateKey";  
	  
	/** *//** 
	 * RSA最大加密明文大小 
	 */  
	private static final int MAX_ENCRYPT_BLOCK = 117;  
	  
	/** *//** 
	 * RSA最大解密密文大小 
	 */  
	private static final int MAX_DECRYPT_BLOCK = 128;  

	/** *//** 
	 * <p> 
	 * 生成密钥对(公钥和私钥) 
	 * </p> 
	 *  
	 * @return 
	 * @throws Exception 
	 */  
/*  20 */   private static KeyRSA instance = new KeyRSA();
/*     */   
/*     */   public static KeyRSA getInstance()
/*     */   {
/*  25 */     return instance;
/*     */   }
/*     */   
/*  27 */   public Properties properties = new Properties();
/*     */   
/*     */   public String getValue(String key)
/*     */   {
	          String valueString = null ; 
              InputStream in =   KeyRSA.class.getResourceAsStream("/license.properties");
	          try {
					this.properties.load(in);
					in.close();
					valueString = this.properties.getProperty(key);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					System.out.println("未找到授权文件");
				}
                  return valueString;
/*     */   }
/*     */   
/*     */   
/*解密算法*/

public  String decrypt(String cryptograph) throws Exception{
	   /** 将文件中的私钥对象读出 */
	   /** 得到Cipher对象对已用公钥加密的数据进行RSA解密 */
	   Cipher cipher = Cipher.getInstance("RSA");
	   cipher.init(Cipher.DECRYPT_MODE, getPrivateKey());
	   BASE64Decoder decoder = new BASE64Decoder();
	   byte[] cpuId = decoder.decodeBuffer(cryptograph);
	   /** 执行解密操作 */
	   byte[] cpuIdByte = cipher.doFinal(cpuId);
	   return new String(cpuIdByte);
	}
        public boolean checkLicense()
             {
              boolean flag = true;
	           String cpuIdString = null;
			try {
				cpuIdString = decrypt(getValue("mcode"));
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				System.out.println("解码失败！");
				return false;
			}
	          if(!HardWareUtils.getCPUSerial().equals(cpuIdString))
	          {
	             return false;
	          }
	          else {
	        	  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	        	  Date date = null;
				try {
						date = sdf.parse(decrypt(getValue("endate")));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					System.out.println("授权时间输入有误，请联系管理员重新生成license！");
					return false;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					System.out.println("认证失败！");
					return false;
				} 
				
	        	  if(date.getTime()<new Date().getTime())
	        	  {
	        		  System.out.println("license过期！");
	        		  return false;
	        	  }
	          }
	          return flag;
             }
        
        public  Key getPrivateKey() throws NoSuchAlgorithmException, InvalidKeySpecException { 
            String str = KeyRSA.class.getClassLoader().getResource("private.dat").getPath();
        	FileInputStream in = null;
			try {
				in = new FileInputStream(str);
			} catch (FileNotFoundException e1) {
				// TODO Auto-generated catch block
				System.out.println("缺少秘钥文件！");
			}
        	PrivateKey privateKey = null;
        	byte[] bytes ; 
        		try {
        			bytes = new BASE64Decoder().decodeBuffer(in);
        			PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(bytes);  
                    KeyFactory keyFactory = KeyFactory.getInstance("RSA");  
                   privateKey = keyFactory.generatePrivate(keySpec);   
        		} catch (IOException e) {
        			// TODO Auto-generated catch block
        			System.out.println("读取秘钥失败！");
        		}
             try {
        		in.close();
        	} catch (IOException e) {
        		// TODO Auto-generated catch block
        		e.printStackTrace();
        	}
           return privateKey;
        }  
        
        
     /* public static void main(String[] args)
        {
        	boolean ttt = KeyRSA.getInstance().checkLicense();
        	System.out.println(ttt);
        }*/
        
     }


