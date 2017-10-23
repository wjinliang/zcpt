package com.dm.ais.util;

import java.io.IOException;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.junit.Test;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.DlmEntity;
import com.dm.ais.model.OutputEntity;
import com.dm.ais.model.SettingEntity;
import com.dm.ais.model.ReportEntity;
import com.sun.xml.internal.stream.Entity;

public class WebServiceTemplate {

	private static Logger log = LogManager.getLogger(WebServiceTemplate.class);
	
	private static WebServiceTemplate uniqueInstance = null;  
	   
    private WebServiceTemplate() {  
    }  
   
    public static WebServiceTemplate getInstance() {  
       if (uniqueInstance == null) {  
           uniqueInstance = new WebServiceTemplate();  
       }  
       return uniqueInstance;  
    } 
	
	
	public final static String http = AisPropertiesUtil.getInstance().getProperty("http");
	//一、AIS系统管理设置电文
	//1.基站设置类接口
	public final static String webServiceBCF_setPositionSource = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setPositionSource");
	public final static String webServiceBCF_setPosition = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setPosition");
	public final static String webServiceBCF_setPositionAccuracy = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setPositionAccuracy");
	public final static String webServiceBCF_setRadioRx = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setRadioRx");
	public final static String webServiceBCF_setRadioTx = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setRadioTx");
	public final static String webServiceBCF_setPowerLevelChannelA = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setPowerLevelChannelA");
	public final static String webServiceBCF_setPowerLevelChannelB = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setPowerLevelChannelB");
	public final static String webServiceBCF_setMsgRetries = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setMsgRetries");
	public final static String webServiceBCF_setRepeatIndicator = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setRepeatIndicator");
	public final static String webServiceBCF_setTalkerID = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setTalkerID");
	public final static String webServiceBCF_setFull = AisPropertiesUtil.getInstance().getProperty("webServiceBCF_setFull");
	//2.扩展通用基站类接口
	public final static String webServiceBCE_setRATDMAontrol = AisPropertiesUtil.getInstance().getProperty("webServiceBCE_setRATDMAontrol");
	public final static String webServiceBCE_setUTCSource = AisPropertiesUtil.getInstance().getProperty("webServiceBCE_setUTCSource");
	public final static String webServiceBCE_setADSInterval = AisPropertiesUtil.getInstance().getProperty("webServiceBCE_setADSInterval");
	public final static String webServiceBCE_setFull = AisPropertiesUtil.getInstance().getProperty("webServiceBCE_setFull");
	//3.控制AIS基站类接口 /cab/setChannelAControl
	public final static String webServiceCAB_setChannelAControl = AisPropertiesUtil.getInstance().getProperty("webServiceCAB_setChannelAControl");
	public final static String webServiceCAB_setChannelBControl = AisPropertiesUtil.getInstance().getProperty("webServiceCAB_setChannelBControl");
	public final static String webServiceCAB_restartBaseStation = AisPropertiesUtil.getInstance().getProperty("webServiceCAB_restartBaseStation");
	public final static String webServiceCAB_restoreBaseStation = AisPropertiesUtil.getInstance().getProperty("webServiceCAB_restoreBaseStation");
	public final static String webServiceCAB_setFull = AisPropertiesUtil.getInstance().getProperty("webServiceCAB_setFull");
	//4.分配基站报文报告率类接口
	public final static String webServiceECB_setReprotingRatesForMsg4=AisPropertiesUtil.getInstance().getProperty("webServiceECB_setReprotingRatesForMsg4");
	public final static String webServiceECB_setReprotingRatesForMsg17=AisPropertiesUtil.getInstance().getProperty("webServiceECB_setReprotingRatesForMsg17");
	public final static String webServiceECB_setReprotingRatesForMsg20=AisPropertiesUtil.getInstance().getProperty("webServiceECB_setReprotingRatesForMsg20");
	public final static String webServiceECB_setReprotingRatesForMsg22=AisPropertiesUtil.getInstance().getProperty("webServiceECB_setReprotingRatesForMsg22");
	public final static String webServiceECB_setReprotingRatesForMsg23=AisPropertiesUtil.getInstance().getProperty("webServiceECB_setReprotingRatesForMsg23");
	public final static String webServiceECB_setFull=AisPropertiesUtil.getInstance().getProperty("webServiceECB_setFull");
	//5.站点识别安装类接口
	public final static String webServiceSID_setNewUID=AisPropertiesUtil.getInstance().getProperty("webServiceSID_setNewUID");
	public final static String webServiceSID_setNewMMSI=AisPropertiesUtil.getInstance().getProperty("webServiceSID_setNewMMSI");
	public final static String webServiceSID_setFull=AisPropertiesUtil.getInstance().getProperty("webServiceSID_setFull");
	//6.传输时隙禁用类接口
	public final static String webServiceTSP_setTSPForChA=AisPropertiesUtil.getInstance().getProperty("webServiceTSP_setTSPForChA");
	public final static String webServiceTSP_setTSPForChB=AisPropertiesUtil.getInstance().getProperty("webServiceTSP_setTSPForChB");
	public final static String webServiceTSP_setFull=AisPropertiesUtil.getInstance().getProperty("webServiceTSP_setFull");
	//7.选择AIS设备的处理和输出类接口
	public final static String webServiceSPO_setVSIOutput=AisPropertiesUtil.getInstance().getProperty("webServiceSPO_setVSIOutput");
	public final static String webServiceSPO_setFSROutput=AisPropertiesUtil.getInstance().getProperty("webServiceSPO_setFSROutput");
	public final static String webServiceSPO_setFull=AisPropertiesUtil.getInstance().getProperty("webServiceSPO_setFull");
	
	//二、AIS广播电文
	//1.ACM-准备及启动AIS基站处理报文管理模式类接口
	public final static String webServiceACM_setACM=AisPropertiesUtil.getInstance().getProperty("webServiceACM_setACM");
	//2.AGA-AIS基站准备开始播报一组报文类接口
	public final static String webServiceAGA_setAGA=AisPropertiesUtil.getInstance().getProperty("webServiceAGA_setAGA");
	//3.ASN-AIS基站准备开始播报VDL报文类接口
	public final static String webServiceASN_setFirstAisUnitMMSI=AisPropertiesUtil.getInstance().getProperty("webServiceASN_setFirstAisUnitMMSI");
	//4.DLM-在基站中用数据链接管理时隙分配类接口
	public final static String webServiceDLM_setChADataLinkForReservation1=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setChADataLinkForReservation1");
	public final static String webServiceDLM_setChADataLinkForReservation2=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setChADataLinkForReservation2");
	public final static String webServiceDLM_setChADataLinkForReservation3=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setChADataLinkForReservation3");
	public final static String webServiceDLM_setChADataLinkForReservation4=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setChADataLinkForReservation4");
	public final static String webServiceDLM_setChBDataLinkForReservation1=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setChBDataLinkForReservation1");
	public final static String webServiceDLM_setChBDataLinkForReservation2=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setChBDataLinkForReservation2");
	public final static String webServiceDLM_setChBDataLinkForReservation3=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setChBDataLinkForReservation3");
	public final static String webServiceDLM_setChBDataLinkForReservation4=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setChBDataLinkForReservation4");
	public final static String webServiceDLM_sefFull=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setFull");
	//5.TSA-传输时隙分配类接口
	public final static String webServiceTSA_setTSAForChA=AisPropertiesUtil.getInstance().getProperty("webServiceTSA_setTSAForChA");
	public final static String webServiceTSA_setTSAForChB=AisPropertiesUtil.getInstance().getProperty("webServiceTSA_setTSAForChB");
	//6.ABM-AIS寻址二进制及寻址安全相关报文类接口
	public final static String webServiceABM_setABMForMessage6IMF0=AisPropertiesUtil.getInstance().getProperty("webServiceABM_setABMForMessage6IMF0"); 
	public final static String webServiceABM_setABMForMessage6IMF3=AisPropertiesUtil.getInstance().getProperty("webServiceABM_setABMForMessage6IMF3"); 
	public final static String webServiceABM_setABMForMessage6IMF4=AisPropertiesUtil.getInstance().getProperty("webServiceABM_setABMForMessage6IMF4"); 
	//7.BBM-AIS二进制广播报文类接口
	public final static String webServiceBBM_setBBMForMessage8=AisPropertiesUtil.getInstance().getProperty("webServiceBBM_setBBMForMessage8"); 
	public final static String webServiceBBM_setBBMForMessage14=AisPropertiesUtil.getInstance().getProperty("webServiceBBM_setBBMForMessage14"); 
	//8.AIR-AIS询问类接口
	public final static String webServiceAIR_setAIR=AisPropertiesUtil.getInstance().getProperty("webServiceAIR_setAIR"); 
	//9.ACA-AIS信道指配报文类接口
	public final static String webServiceACA_setACA=AisPropertiesUtil.getInstance().getProperty("webServiceACA_setACA");
	//10.ACS-AIS信道管理信息源类接口
	public final static String webServiceACS_setACS=AisPropertiesUtil.getInstance().getProperty("webServiceACS_setACS");
	//11.CBR- AIS基站广播频率设置报文命令类接口
	public final static String webServiceCBR_setCBR=AisPropertiesUtil.getInstance().getProperty("webServiceCBR_setCBR");
	//12.LRI-AIS长距离类接口
	public final static String webServiceLRI_setLRI=AisPropertiesUtil.getInstance().getProperty("webServiceLRI_setLRI");
	//13.LRF-AIS长距离功能类接口
	public final static String webServiceLRF_setLRF=AisPropertiesUtil.getInstance().getProperty("webServiceLRF_setLRF");
	//14.MEB-广播命令的报文输入类接口
	public final static String webServiceMEB_setMebForMessage6IFM0=AisPropertiesUtil.getInstance().getProperty("webServiceMEB_setMebForMessage6IFM0");
	public final static String webServiceMEB_setMebForMessage8=AisPropertiesUtil.getInstance().getProperty("webServiceMEB_setMebForMessage8");
	public final static String webServiceMEB_setMebForMessage12=AisPropertiesUtil.getInstance().getProperty("webServiceMEB_setMebForMessage12");
	public final static String webServiceMEB_setMebForMessage14=AisPropertiesUtil.getInstance().getProperty("webServiceMEB_setMebForMessage14");
	
	//三、AIS系统管理查看电文
	public final static String webServiceBCF =AisPropertiesUtil.getInstance().getProperty("webServiceBCF");
	public final static String webServiceBCE =AisPropertiesUtil.getInstance().getProperty("webServiceBCE");
	public final static String webServiceCAB =AisPropertiesUtil.getInstance().getProperty("webServiceCAB");
	public final static String webServiceECB =AisPropertiesUtil.getInstance().getProperty("webServiceECB");
	
	//四、基站连接信息维护
	public final static String webService_add = AisPropertiesUtil.getInstance().getProperty("webService_add");
	public final static String webService_update = AisPropertiesUtil.getInstance().getProperty("webService_update");
	public final static String webService_delete = AisPropertiesUtil.getInstance().getProperty("webService_delete");
	
	//广播6号报文
	@Test
	public void testSetMebForMessage6IFM0() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceMEB_setMebForMessage6IFM0);
		post.addParameter("idCode", "00010401");
		post.addParameter("channel", "1");    //0-3
		post.addParameter("mmsi", "111111111");    //int
		post.addParameter("messageIDIndex", "1"); //String
		post.addParameter("broadcastBehaviour", "3");  //0-9 
		post.addParameter("destinationMMSI", "2");    //int
		post.addParameter("binaryDataFlag", "2");  //0-1
		post.addParameter("sentenceStatusFlag", "R");  //R C
		post.addParameter("repeatIndicator", "1");  //0-3
		post.addParameter("sourceID", "111111111");
		post.addParameter("sequenceNumber", "2");   //0-3
		post.addParameter("destinationID", "111111111");
		post.addParameter("retransmitFlag", "1");  //0-1
		post.addParameter("applicationIdentifierDAC", "1"); 
		post.addParameter("acknowledgeRequiredFlag", "1");  //0-1
		post.addParameter("textSequenceNumber", "1");  
		post.addParameter("text", "1");  //6位ASCII码 小于696
		executePost(post);  
	}
	//广播8号报文
	@Test
	public void testSetMebForMessage8() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceMEB_setMebForMessage8);
		post.addParameter("idCode", "00010401");
		post.addParameter("channel", "1");    //0-3
		post.addParameter("mmsi", "111111111");    //int
		post.addParameter("messageIDIndex", "1"); //String
		post.addParameter("broadcastBehaviour", "3");  //0-9 
		post.addParameter("destinationMMSI", "2");    //int
		post.addParameter("binaryDataFlag", "2");  //0-1
		post.addParameter("sentenceStatusFlag", "R");  //R C
		post.addParameter("repeatIndicator", "1");  //0-3
		post.addParameter("sourceID", "111111111");
		post.addParameter("applicationIdentifierDAC", "1"); 
		post.addParameter("acknowledgeRequiredFlag", "1");  //0-1
		post.addParameter("textSequenceNumber", "1");  
		post.addParameter("text", "1");  //6位ASCII码 小于696
		executePost(post);  
	}
	//广播12号报文
	@Test
	public void testSetMebForMessage12() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceMEB_setMebForMessage12);
		post.addParameter("idCode", "00010401");
		post.addParameter("channel", "1");    //0-3
		post.addParameter("mmsi", "111111111");    //int
		post.addParameter("messageIDIndex", "1"); //String
		post.addParameter("broadcastBehaviour", "3");  //0-9 
		post.addParameter("destinationMMSI", "2");    //int
		post.addParameter("binaryDataFlag", "2");  //0-1
		post.addParameter("sentenceStatusFlag", "R");  //R C
		post.addParameter("repeatIndicator", "1");  //0-3
		post.addParameter("sourceID", "111111111");
		post.addParameter("sequenceNumber", "2");   //0-3
		post.addParameter("destinationID", "111111111");
		post.addParameter("retransmitFlag", "1");  //0-1
		post.addParameter("text", "1");  //6位ASCII码 小于696
		executePost(post);  
	}
	//广播14号报文
	@Test
	public void testSetMebForMessage14() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceMEB_setMebForMessage14);
		post.addParameter("idCode", "00010401");
		post.addParameter("channel", "1");    //0-3
		post.addParameter("mmsi", "111111111");    //int
		post.addParameter("messageIDIndex", "1"); //String
		post.addParameter("broadcastBehaviour", "3");  //0-9 
		post.addParameter("destinationMMSI", "2");    //int
		post.addParameter("binaryDataFlag", "2");  //0-1
		post.addParameter("sentenceStatusFlag", "R");  //R C
		post.addParameter("repeatIndicator", "1");  //0-3
		post.addParameter("sourceID", "111111111");
		post.addParameter("text", "1");  //6位ASCII码 小于696
		executePost(post);  
	}
	
	//设置AIS长距离询问应答
	@Test
	public void testSetLRF() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceLRF_setLRF);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "1");    //0-9 
		post.addParameter("requestorMMSI", "1");    //int
		post.addParameter("requestorName", "requestorName"); //String
		post.addParameter("requestFunction", "3");  //A B C E F I O P U W  
		post.addParameter("replyStatus", "2");    //2-4
		executePost(post);  
	}
	
	//设置AIS长距离询问
	@Test
	public void testSetLRI() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceLRI_setLRI);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "1");    //0-9 
		post.addParameter("controlFlag", "1");  //0-1
		post.addParameter("requestorMMSI", "1");    //int
		post.addParameter("destinationMMSI", "1");        //int
		post.addParameter("nelat", "3");        //XXXX.XX 
		post.addParameter("nelatType", "N");    //N|S
		post.addParameter("nelon", "5");        //XXXX.XX
		post.addParameter("nelonType", "1");    //E|W
		post.addParameter("swlat", "3");        //XXXX.XX 
		post.addParameter("swlatType", "N");    //N|S
		post.addParameter("swlon", "5");        //XXXX.XX
		post.addParameter("swlonType", "1");    //E|W
		executePost(post);  
	}
	
	//设置AIS基站广播频率
	@Test
	public void testSetCBR() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCBR_setCBR);
		post.addParameter("idCode", "00010401");
		post.addParameter("mmsi", "111111111");    //9位 
		post.addParameter("messageID", "1");  
		
		post.addParameter("messageIDIndex", "1");    //0-7
		post.addParameter("startUTCHourForChA", "1");        //1-24
		post.addParameter("startUTCMinuteForChA", "1");    //1-60
		post.addParameter("startSlotForChA", "1");        //-1-2249
		
		post.addParameter("slotIntervalForChA", "1");  //-1-3240000
		post.addParameter("tdmaMode", "1");   //0-2
		post.addParameter("startUTCHourForChB", "1");  //1-24
		post.addParameter("startUTCMinuteForChB", "1");  //1-60
		post.addParameter("startSlotForChB", "1");   //-1-2249
		post.addParameter("slotIntervalForChB", "1");  //-1-3240000
		post.addParameter("sentenceStatus", "R");   //R C
		executePost(post);  
	}
	
	//设置AIS信道信息源
	@Test
	public void testSetACS() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceACS_setACS);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "1");    //0-9 
		post.addParameter("originatorMMSI", "1111111111");  //9位 
		post.addParameter("receiptTime", "1328");    //Hhmmss.ss
		post.addParameter("receiptDay", "1");        //1-31
		post.addParameter("receiptMonth", "1");    //1-12
		post.addParameter("receiptYear", "1");        //XXXX.XX 
		executePost(post);  
	}
	
	//设置AIS信道分配管理
	@Test
	public void testSetACA() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceACA_setACA);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "1");    //0-9 
		post.addParameter("nelat", "3");        //XXXX.XX 
		post.addParameter("nelatType", "N");    //N|S
		post.addParameter("nelon", "5");        //XXXX.XX
		post.addParameter("nelonType", "1");    //E|W
		post.addParameter("swlat", "3");        //XXXX.XX 
		post.addParameter("swlatType", "N");    //N|S
		post.addParameter("swlon", "5");        //XXXX.XX
		post.addParameter("swlonType", "1");    //E|W
		
		post.addParameter("transitionZone", "2");  //1-8
		post.addParameter("channelA", "1001");  //1001-2087 
		post.addParameter("bandWidthForChA", "0");  //0-1
		
		post.addParameter("channelB", "1002");  //1001-2087
		post.addParameter("bandWidthChB", "1");   //0-1
		post.addParameter("trxMode", "2");   //0-6
		post.addParameter("powerLevel", "1");    //0-1
		post.addParameter("informationSource", "A");   //A B C D M
		post.addParameter("inUseFlag", "1");  //0-1
		post.addParameter("inUseChangeTime", "1105");
		executePost(post);  
	}
	
	//设置设置AIS询问请求
	@Test
	public void testSetAIR() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceAIR_setAIR);
		post.addParameter("idCode", "00010401");
		post.addParameter("station1MMSI", "1"); 
		post.addParameter("station1Msg1Num", "3");     //3 5 9 18 19 21 24 11 4 24 
		post.addParameter("station1Msg1Sub", "1");     //0-3
		post.addParameter("station1Msg2Num", "5");    //3 5 9 18 19 21 24 11 4 24
		post.addParameter("station1Msg2Sub", "1"); 
		
		post.addParameter("station2MMSI", "2"); 
		post.addParameter("station2MsgNum", "3");  //3 5 9 18 19 21 24 11 4 24 
		post.addParameter("station2MsgSub", "2"); 
		
		post.addParameter("channel", "A"); 
		post.addParameter("replySlotOfStation1Msg1", "2");   //0-2249
		post.addParameter("replySlotOfStation1Msg2", "2");   //0-2249
		post.addParameter("replySlotOfStation2Msg", "2");    //0-2249
		executePost(post);  
	}
	
	//广播二进制8号报文
	@Test
	public void testSetBBMForMessage8() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBBM_setBBMForMessage8);
		post.addParameter("idCode", "00010401");
		post.addParameter("channel", "1");     //0-3
		post.addParameter("repeatIndicator", "3");     //0-3
		post.addParameter("sourceID", "111111111");   
		post.addParameter("applicationIdentifierDAC", "1"); 
		post.addParameter("acknowledgeRequiredFlag", "1"); 
		post.addParameter("textSequenceNumber", "11"); 
		post.addParameter("text", "935"); 
		executePost(post);
	}
	//广播二进制14号报文
	@Test
	public void testSetBBMForMessage14() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBBM_setBBMForMessage14);
		post.addParameter("idCode", "00010401");
		post.addParameter("channel", "1");     //0-3
		post.addParameter("repeatIndicator", "3");     //0-3
		post.addParameter("sourceID", "111111111");   
		post.addParameter("text", "935"); 
		executePost(post);
	}
	
	//AIS寻址二级制报文6号报文
	@Test
	public void testSetABMForMessage6IMF0() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceABM_setABMForMessage6IMF0);
		post.addParameter("idCode", "00010401");
		post.addParameter("destinationAisMMSI", "111111111");     //15位
		post.addParameter("channel", "1");
		post.addParameter("repeatIndicator", "3");     //0-3
		post.addParameter("sourceID", "111111111");   
		post.addParameter("destinationID", "111111111");      
		post.addParameter("retransmitFlag", "1");        //0-1
		post.addParameter("applicationIdentifierDAC", "1"); 
		post.addParameter("acknowledgeRequiredFlag", "1"); 
		post.addParameter("textSequenceNumber", "11"); 
		post.addParameter("text", "935"); 
		executePost(post);
	}
	//AIS寻址二级制报文能力查询
	@Test
	public void testSetABMForMessage6IMF4() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceABM_setABMForMessage6IMF4);
		post.addParameter("idCode", "00010401");
		post.addParameter("destinationAisMMSI", "11111111111111");     //15位
		post.addParameter("channel", "1");
		post.addParameter("repeatIndicator", "3");     //0-3
		post.addParameter("sourceID", "111111111");   
		post.addParameter("destinationID", "111111111");      
		post.addParameter("retransmitFlag", "1");        //0-1
		post.addParameter("applicationIdentifierDAC", "1"); 
		post.addParameter("dacCode", "IAI");   //IAI RAI test
		post.addParameter("fiAvailability", "1");  //0-1
		executePost(post);
	}
	//AIS寻址二级制报文能力查询应答
	@Test
	public void testSetABMForMessage6IMF3() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceABM_setABMForMessage6IMF3);
		post.addParameter("idCode", "00010401");
		post.addParameter("destinationAisMMSI", "11111111111111");     //15位
		post.addParameter("channel", "1");
		post.addParameter("repeatIndicator", "3");     //0-3
		post.addParameter("sourceID", "111111111");   
		post.addParameter("destinationID", "111111111");      
		post.addParameter("retransmitFlag", "1");        //0-1
		post.addParameter("applicationIdentifierDAC", "1"); 
		post.addParameter("requestedDACCode", "IAI");   //IAI RAI test
		executePost(post);
	}
	
	//设置A频道传输时隙分配
	@Test
	public void testSetTSAForChA() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceTSA_setTSAForChA);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");     //15位
		post.addParameter("seqMessage", "9");     //0-9
		post.addParameter("requestUTC", "1011");   //UTC 
		post.addParameter("startSoltNum", "2.1");      //X.X
		post.addParameter("priority", "200");        //1-2
		executePost(post);
	}
	//设置B频道传输时隙分配
	@Test
	public void testSetTSAForChB() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceTSA_setTSAForChB);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");     //15位
		post.addParameter("seqMessage", "9");     //0-9
		post.addParameter("requestUTC", "1011");   //UTC 
		post.addParameter("startSoltNum", "2.1");      //X.X
		post.addParameter("priority", "200");        //1-2
		executePost(post);
	}
	
	//设置基站A频道保留1的数据链接管理
	public JSONObject testSetChADataLinkForReservation1(DlmEntity entity, String agreementId) throws HttpException, IOException {
		System.out.println("A1"+http + webServiceDLM_setChADataLinkForReservation1);
		PostMethod post = new PostMethod(http + webServiceDLM_setChADataLinkForReservation1);
		post.addParameter("idCode", agreementId);
		post.addParameter("seqNumber", entity.getSeqNumber());     //1-40
		post.addParameter("ownership", entity.getOwnership());     //L R C
		post.addParameter("startSlot", String.valueOf(entity.getStartSlot()));   //0-2249
		post.addParameter("slotNumber", String.valueOf(entity.getSlotNumber()));      //0-5
		post.addParameter("timeout", String.valueOf(entity.getTimeout()));       //0-7
		post.addParameter("increment", String.valueOf(entity.getIncrement()));        //0-1125
		return executePost(post);
	}
	//设置基站A频道保留2的数据链接管理
	public JSONObject testSetChADataLinkForReservation2(DlmEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChADataLinkForReservation2);
		post.addParameter("idCode", agreementId);
		post.addParameter("seqNumber", entity.getSeqNumber());     //1-40
		post.addParameter("ownership", entity.getOwnership());     //L R C
		post.addParameter("startSlot", String.valueOf(entity.getStartSlot()));   //0-2249
		post.addParameter("slotNumber", String.valueOf(entity.getSlotNumber()));      //0-5
		post.addParameter("timeout", String.valueOf(entity.getTimeout()));       //0-7
		post.addParameter("increment", String.valueOf(entity.getIncrement()));        //0-1125
		return executePost(post);
	}
	//设置基站A频道保留3的数据链接管理
	public JSONObject testSetChADataLinkForReservation3(DlmEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChADataLinkForReservation3);
		post.addParameter("idCode", agreementId);
		post.addParameter("seqNumber", entity.getSeqNumber());     //1-40
		post.addParameter("ownership", entity.getOwnership());     //L R C
		post.addParameter("startSlot", String.valueOf(entity.getStartSlot()));   //0-2249
		post.addParameter("slotNumber", String.valueOf(entity.getSlotNumber()));      //0-5
		post.addParameter("timeout", String.valueOf(entity.getTimeout()));       //0-7
		post.addParameter("increment", String.valueOf(entity.getIncrement()));        //0-1125
		return executePost(post);
	}
	//设置基站A频道保留4的数据链接管理
	public JSONObject testSetChADataLinkForReservation4(DlmEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChADataLinkForReservation4);
		post.addParameter("idCode", agreementId);
		post.addParameter("seqNumber", entity.getSeqNumber());     //1-40
		post.addParameter("ownership", entity.getOwnership());     //L R C
		post.addParameter("startSlot", String.valueOf(entity.getStartSlot()));   //0-2249
		post.addParameter("slotNumber", String.valueOf(entity.getSlotNumber()));      //0-5
		post.addParameter("timeout", String.valueOf(entity.getTimeout()));       //0-7
		post.addParameter("increment", String.valueOf(entity.getIncrement()));        //0-1125
		return executePost(post);
	}
	//设置基站B频道保留1的数据链接管理
	public JSONObject testSetChBDataLinkForReservation1(DlmEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChBDataLinkForReservation1);
		post.addParameter("idCode", agreementId);
		post.addParameter("seqNumber", entity.getSeqNumber());     //1-40
		post.addParameter("ownership", entity.getOwnership());     //L R C
		post.addParameter("startSlot", String.valueOf(entity.getStartSlot()));   //0-2249
		post.addParameter("slotNumber", String.valueOf(entity.getSlotNumber()));      //0-5
		post.addParameter("timeout", String.valueOf(entity.getTimeout()));       //0-7
		post.addParameter("increment", String.valueOf(entity.getIncrement()));        //0-1125
		return executePost(post);
	}
	//设置基站B频道保留2的数据链接管理
	public JSONObject testSetChBDataLinkForReservation2(DlmEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChBDataLinkForReservation2);
		post.addParameter("idCode", agreementId);
		post.addParameter("seqNumber", entity.getSeqNumber());     //1-40
		post.addParameter("ownership", entity.getOwnership());     //L R C
		post.addParameter("startSlot", String.valueOf(entity.getStartSlot()));   //0-2249
		post.addParameter("slotNumber", String.valueOf(entity.getSlotNumber()));      //0-5
		post.addParameter("timeout", String.valueOf(entity.getTimeout()));       //0-7
		post.addParameter("increment", String.valueOf(entity.getIncrement()));        //0-1125
		return executePost(post);
	}
	//设置基站B频道保留3的数据链接管理
	public JSONObject testSetChBDataLinkForReservation3(DlmEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChBDataLinkForReservation3);
		post.addParameter("idCode", agreementId);
		post.addParameter("seqNumber", entity.getSeqNumber());     //1-40
		post.addParameter("ownership", entity.getOwnership());     //L R C
		post.addParameter("startSlot", String.valueOf(entity.getStartSlot()));   //0-2249
		post.addParameter("slotNumber", String.valueOf(entity.getSlotNumber()));      //0-5
		post.addParameter("timeout", String.valueOf(entity.getTimeout()));       //0-7
		post.addParameter("increment", String.valueOf(entity.getIncrement()));        //0-1125
		return executePost(post);
	}
	//设置基站B频道保留4的数据链接管理
	public JSONObject testSetChBDataLinkForReservation4(DlmEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChBDataLinkForReservation4);
		post.addParameter("idCode", agreementId);
		post.addParameter("seqNumber", entity.getSeqNumber());     //1-40
		post.addParameter("ownership", entity.getOwnership());     //L R C
		post.addParameter("startSlot", String.valueOf(entity.getStartSlot()));   //0-2249
		post.addParameter("slotNumber", String.valueOf(entity.getSlotNumber()));      //0-5
		post.addParameter("timeout", String.valueOf(entity.getTimeout()));       //0-7
		post.addParameter("increment", String.valueOf(entity.getIncrement()));        //0-1125
		return executePost(post);
	}
	
	//设置AIS基站播报16号报文
	@Test
	public void testSetFirstAisUnitMMSI() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceASN_setFirstAisUnitMMSI);
		post.addParameter("idCode", "00010401");
		post.addParameter("mmsiForAIS1", "1");     //0-6
		post.addParameter("reportRateForAIS1", "1");     //0-600 step 20
		post.addParameter("startSoltForAIS1", "2249");   //0-2249
		post.addParameter("incrementForAIS1", "0");      //0-6
		
		post.addParameter("mmsiForAIS2", "2");       //0-6
		post.addParameter("reportRateForAIS2", "200");        //0-600 step 20
		post.addParameter("startSoltForAIS2", "2248");       //0-2249
		post.addParameter("incrementForAIS2", "2");           //0-6
		
		post.addParameter("broadcastChannel", "2");       //0-2
		executePost(post);
	}
	
	//设置AIS基站播报23号报文
	@Test
	public void testSetAGA() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceAGA_setAGA);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		post.addParameter("moblileType", "1");     //0-15
		post.addParameter("shipCargoType", "3");   //0-255
		post.addParameter("nelat", "110.25");      //XXX.XX
		post.addParameter("nelatType", "N");       //N|S
		post.addParameter("nelon", "2088");        //XXXX.XX
		post.addParameter("nelonType", "E");       //E|W
		post.addParameter("swlat", "2");           //XXXX.XX
		post.addParameter("swlatType", "S");       //N|S
		post.addParameter("swlon", "2");           //XXXX.XX
		post.addParameter("swlonType", "W");       //E|W
		post.addParameter("reportingInterval", "1");       //0-15
		post.addParameter("trxMode", "1");       //0-3
		post.addParameter("quietTime", "2");       //0-15
		executePost(post);
	}
	
	//设置AIS基站报文的通道管理
	@Test
	public void testSetACM() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceACM_setACM);
		post.addParameter("idCode", "00010401");
		post.addParameter("firstAisMMSI", "111111111");
		post.addParameter("secondAisMMSI", "222222222");
		post.addParameter("channelA", "2087");     //1001-2087
		post.addParameter("bandWidthForChA", "1"); //0-1
		post.addParameter("channelB", "2088");     //1001-2087
		post.addParameter("bandWidthChB", "1");    //0-1
		post.addParameter("trxMode", "2");         //0-2
		post.addParameter("powerLevel", "1");      //0-1
		post.addParameter("broadcastChannel", "2");//0-3
		post.addParameter("transitionZone", "1");  //1-8
		executePost(post);
	}
	
	//设置VSI语句的输出  ceshi1-7
	@Test
	public JSONObject testSPOSetFull(OutputEntity outputEntity) throws HttpException, IOException {
		System.out.println(http+webServiceSPO_setFull);
		PostMethod post = new PostMethod(http + webServiceSPO_setFull);
		post.addParameter("idCode", outputEntity.getAgreementid()==null?"":outputEntity.getAgreementid());
		post.addParameter("uid", outputEntity.getId()==null?"":outputEntity.getId());
		post.addParameter("signalStrength", String.valueOf(outputEntity.getSignalStrength()==null?"":outputEntity.getSignalStrength()));     //0-2
		post.addParameter("channel", outputEntity.getChannel()==null?"":outputEntity.getChannel());         //A B E N
		post.addParameter("firstSlotNum", String.valueOf(outputEntity.getFirstSlotNum()==null?"":outputEntity.getFirstSlotNum()));  //0-2
		post.addParameter("msgArriveTime", String.valueOf(outputEntity.getMsgArriveTime()==null?"":outputEntity.getMsgArriveTime()));    //0-2
		post.addParameter("signalNoiseRatio", String.valueOf(outputEntity.getSignalNoiseRatio()==null?"":outputEntity.getSignalNoiseRatio()));   //0-2
		post.addParameter("channelLoad", String.valueOf(outputEntity.getChannelLoad()==null?"":outputEntity.getChannelLoad()));//0-2
		post.addParameter("badCRCMsgNum", String.valueOf(outputEntity.getBadCRCMsgNum()==null?"":outputEntity.getBadCRCMsgNum()));     //0-1
		post.addParameter("forecastChannelLoad",  String.valueOf(outputEntity.getForecastChannelLoad()==null?"":outputEntity.getForecastChannelLoad()));         //0-2
		post.addParameter("avarageNoiseLevel", String.valueOf(outputEntity.getAvarageNoiseLevel()==null?"":outputEntity.getAvarageNoiseLevel()));  //0-2
		post.addParameter("recievedSignalStrength", String.valueOf(outputEntity.getReceivedSignalStrength()==null?"":outputEntity.getReceivedSignalStrength()));    //0-2
		post.addParameter("vdmSentence", String.valueOf(outputEntity.getVdmSentence()==null?"":outputEntity.getVdmSentence()));   //0-1
		post.addParameter("vdoSentence", String.valueOf(outputEntity.getVdoSentence()==null?"":outputEntity.getVdoSentence()));//0-1
		post.addParameter("fsrSentenceOfAfterFrame", String.valueOf(outputEntity.getFsrSentenceOfAfterFrame()==null?"":outputEntity.getFsrSentenceOfAfterFrame()));     //0-1
		return executePost(post);
	}
	
	//设置VSI语句的输出
	@Test
	public void testSetFSROutput() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceSPO_setFSROutput);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		
		post.addParameter("channel", "B");         //A B E N
		post.addParameter("channelLoad", "1");  //0-2
		post.addParameter("badCRCMsgNum", "1");    //0-2
		post.addParameter("forecastChannelLoad", "1");   //0-2
		post.addParameter("avarageNoiseLevel", "2");//0-2

		post.addParameter("signalStrength", "0");     //0-2
		post.addParameter("fsrSentenceOfAfterFrame", "1");     //0-1
		
		executePost(post);
	}
	
	//设置VSI语句的输出
	@Test
	public void testSetVSIOutput() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceSPO_setVSIOutput);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		
		post.addParameter("channel", "B");         //A B E N
		post.addParameter("signalStrength", "1");  //0-2
		post.addParameter("firstSlotNum", "1");    //0-2
		post.addParameter("msgArriveTime", "1");   //0-2
		post.addParameter("signalNoiseRatio", "2");//0-2

		post.addParameter("vdmSentence", "0");     //0-2
		post.addParameter("vdoSentence", "2");     //0-2
		
		executePost(post);
	}
	
	//传输时隙禁用类总接口
	@Test
	public void testTSPSetFull() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceTSP_setFull);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqID", "00010401");    //0-99  channel
		
		post.addParameter("channel", "B");
		post.addParameter("slotUTC", "201135.35");  //HHMMSS.SS
		post.addParameter("slotReference", "1");
		post.addParameter("slotOffset1", "0");
		post.addParameter("slotConsecutiveTime1", "1");

		post.addParameter("slotOffset2", "0");
		post.addParameter("slotConsecutiveTime2", "3");
		
		post.addParameter("slotOffset3", "0");
		post.addParameter("slotConsecutiveTime3", "3");
		executePost(post);
	}
	
	//设置基站频道B传输时隙的禁用状态
	@Test
	public void testSetTSPForChB() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceTSP_setTSPForChB);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqID", "00010401");    //0-99
		post.addParameter("slotUTC", "201135.35");  //HHMMSS.SS
		post.addParameter("slotReference", "1");
		post.addParameter("slotOffset1", "0");
		post.addParameter("slotConsecutiveTime1", "1");

		post.addParameter("slotOffset2", "0");
		post.addParameter("slotConsecutiveTime2", "3");
		
		post.addParameter("slotOffset3", "0");
		post.addParameter("slotConsecutiveTime3", "3");
		executePost(post);
	}
	
	//设置基站频道A传输时隙的禁用状态
	@Test
	public void testSetTSPForChA() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceTSP_setTSPForChA);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqID", "00010401");    //0-99
		post.addParameter("slotUTC", "201135.35");  //HHMMSS.SS
		post.addParameter("slotReference", "1");
		post.addParameter("slotOffset1", "0");
		post.addParameter("slotConsecutiveTime1", "1");

		post.addParameter("slotOffset2", "0");
		post.addParameter("slotConsecutiveTime2", "3");
		
		post.addParameter("slotOffset3", "0");
		post.addParameter("slotConsecutiveTime3", "3");
		executePost(post);
	}
	
	//配置基站报文播报频率信息 
	@Test
	public void testWebServiceECB() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB);
		post.addParameter("idCode", "00010401");
		executePost(post);
	}
	
	//设置基站的MMSI
	@Test
	public void testSIDSetFull() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceSID_setFull);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "222222222222222");
		post.addParameter("newUID", "222222222222222");
		post.addParameter("mmsi", "111111111");
		post.addParameter("newMMSI", "222222222");
		executePost(post);
	}
	
	//设置基站的MMSI
	@Test
	public void testSetNewMMSI() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceSID_setNewMMSI);
		post.addParameter("idCode", "00010401");
		post.addParameter("currentUID", "222222222222222");
		post.addParameter("currentMMSI", "111111111");
		post.addParameter("newMMSI", "222222222");
		executePost(post);
	}
	
	//设置基站的唯一识别码
	@Test
	public void testSetNewUID() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceSID_setNewUID);
		post.addParameter("idCode", "00010401");
		post.addParameter("currentUID", "111111111111111");
		post.addParameter("newUID", "222222222222222");
		executePost(post);
	}
	
	//分配基站报文报告率类总接口    ceshi1-4
	public JSONObject testECBSetFull(ReportEntity reportEntity) throws HttpException, IOException {
		System.out.println(http + webServiceECB_setFull);
		PostMethod post = new PostMethod(http + webServiceECB_setFull);
		post.addParameter("idCode",reportEntity.getAgreementid());
		post.addParameter("uid", reportEntity.getId()==null?"":String.valueOf(reportEntity.getId()));
		post.addParameter("msgId", reportEntity.getReportRatesForMsgType()==null?"":String.valueOf(reportEntity.getReportRatesForMsgType()));   //4, 17, 20, 22, 23
		
		post.addParameter("chAutcMinute", String.valueOf(reportEntity.getChAutcMinute()==null?"":String.valueOf(reportEntity.getChAutcMinute())));  //0-59
		post.addParameter("chASlot", String.valueOf(reportEntity.getChASlot()==null?"":String.valueOf(reportEntity.getChASlot())));       //0-2249
		post.addParameter("chAIncrement",String.valueOf(reportEntity.getChAIncrement()==null?"":String.valueOf(reportEntity.getChAIncrement())));  //0 – 13500
		post.addParameter("chASlotsNum", String.valueOf(reportEntity.getChASlotsNum()==null?"":String.valueOf(reportEntity.getChASlotsNum())));   //1-4
		
		post.addParameter("chButcMinute", String.valueOf(reportEntity.getChButcMinute()==null?"":String.valueOf(reportEntity.getChButcMinute())));   //0-59
		post.addParameter("chBSlot", String.valueOf(reportEntity.getChBSlot()==null?"":String.valueOf(reportEntity.getChBSlot())));        //0-2249
		post.addParameter("chBIncrement", String.valueOf(reportEntity.getChBIncrement()==null?"":String.valueOf(reportEntity.getChBIncrement())));   //0 – 13500
		post.addParameter("chBSlotsNum", String.valueOf(reportEntity.getChBSlotsNum()==null?"":String.valueOf(reportEntity.getChBSlotsNum())));   //1-4
		return executePost(post);
	}
	
	//设置23号报文的播报频率
	public JSONObject testSetReprotingRatesForMsg23(ReportEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg23);
		post.addParameter("idCode", agreementId);
		post.addParameter("uid", entity.getUid());
		
		post.addParameter("chAutcMinute", String.valueOf(entity.getChAutcMinute()));  //0-59
		post.addParameter("chASlot", String.valueOf(entity.getChASlot()));        //0-2249
		post.addParameter("chAIncrement", String.valueOf(entity.getChAIncrement()));  //0 – 13500
		
		post.addParameter("chButcMinute", String.valueOf(entity.getChButcMinute()));   //0-59
		post.addParameter("chBSlot", String.valueOf(entity.getChBSlot()));        //0-2249
		post.addParameter("chBIncrement", String.valueOf(entity.getChBIncrement()));   //0 – 13500
		return executePost(post);
	}
	
	//设置22号报文的播报频率
	public JSONObject testSetReprotingRatesForMsg22(ReportEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg22);
		post.addParameter("idCode", agreementId);
		post.addParameter("uid", entity.getUid());
		
		post.addParameter("chAutcMinute", String.valueOf(entity.getChAutcMinute()));  //0-59
		post.addParameter("chASlot", String.valueOf(entity.getChASlot()));        //0-2249
		post.addParameter("chAIncrement", String.valueOf(entity.getChAIncrement()));  //0 – 13500
		
		post.addParameter("chButcMinute", String.valueOf(entity.getChButcMinute()));   //0-59
		post.addParameter("chBSlot", String.valueOf(entity.getChBSlot()));        //0-2249
		post.addParameter("chBIncrement", String.valueOf(entity.getChBIncrement()));   //0 – 13500
		return executePost(post);
	}
	
	//设置20号报文的播报频率
	public JSONObject testSetReprotingRatesForMsg20(ReportEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg20);
		post.addParameter("idCode", agreementId);
		post.addParameter("uid", entity.getUid());
		
		post.addParameter("chAutcMinute", String.valueOf(entity.getChAutcMinute()));  //0-59
		post.addParameter("chASlot", String.valueOf(entity.getChASlot()));        //0-2249
		post.addParameter("chAIncrement", String.valueOf(entity.getChASlot()));  //0 – 13500
		
		post.addParameter("chButcMinute", String.valueOf(entity.getChButcMinute()));   //0-59
		post.addParameter("chBSlot", String.valueOf(entity.getChBSlot()));        //0-2249
		post.addParameter("chBIncrement", String.valueOf(entity.getChBIncrement()));   //0 – 13500
		return executePost(post);
	}
	
	//设置17号报文的播报频率
	public JSONObject testSetReprotingRatesForMsg17(ReportEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg17);
		post.addParameter("idCode", agreementId);
		post.addParameter("uid", entity.getUid());
		
		post.addParameter("chAutcMinute", String.valueOf(entity.getChAutcMinute()));  //0-59
		post.addParameter("chASlot", String.valueOf(entity.getChASlot()));        //0-2249
		post.addParameter("chAIncrement", String.valueOf(entity.getChAIncrement()));  //0 – 13500
		post.addParameter("chASlotsNum", String.valueOf(entity.getChASlotsNum()));   //1-4
		
		post.addParameter("chButcMinute", String.valueOf(entity.getChButcMinute()));   //0-59
		post.addParameter("chBSlot", String.valueOf(entity.getChBSlot()));        //0-2249
		post.addParameter("chBIncrement", String.valueOf(entity.getChBIncrement()));   //0 – 13500
		post.addParameter("chBSlotsNum", String.valueOf(entity.getChBSlotsNum()));    //1-4
		return executePost(post);
	}
	
	//设置4号报文的播报频率
	public JSONObject testSetReprotingRatesForMsg4(ReportEntity entity, String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg4);
		post.addParameter("idCode", agreementId);
		post.addParameter("uid", entity.getUid());
		
		post.addParameter("chAutcMinute", String.valueOf(entity.getChAutcMinute()));  //0-59
		post.addParameter("chASlot", String.valueOf(entity.getChASlot()));        //0-2249
		post.addParameter("chAIncrement", String.valueOf(entity.getChASlot()));  //0 – 13500
		
		post.addParameter("chButcMinute", String.valueOf(entity.getChButcMinute()));   //0-59
		post.addParameter("chBSlot", String.valueOf(entity.getChBSlot()));        //0-2249
		post.addParameter("chBIncrement", String.valueOf(entity.getChBIncrement()));   //0 – 13500
		return executePost(post);
	}
	
	
	//控制AIS基站类总接口
	@Test
	public void testCABSetFull() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_setFull);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelAControl", "1");
		post.addParameter("channelBControl", "1");
		post.addParameter("startFlag", "1");
		post.addParameter("restoreFlag", "1");
		executePost(post);
	}
	
	//设置基站重置设置值
	@Test
	public void testRestoreBaseStation() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_restoreBaseStation);
		post.addParameter("idCode", "00010401");
		post.addParameter("restoreFlag", "1");  
		executePost(post);
	}
	
	//设置基站重启设置值
	@Test
	public void testSestartBaseStation() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_restartBaseStation);
		post.addParameter("idCode", "00010401");
		post.addParameter("startFlag", "1");  
		executePost(post);
	}
	
	//设置频道B开关值
	@Test
	public void testSetChannelBControl() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_setChannelBControl);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelBControl", "1");  //0-1
		executePost(post);
	}
	
	//设置频道A开关 
	@Test
	public void testSetChannelAControl() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_setChannelAControl);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelAControl", "0");  //0-1
		executePost(post);
	}
	
	//扩展通用基站类总接口
	@Test
	public void testBCESetFull() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE_setFull);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");
		post.addParameter("ratdmaControl", "1");  //0-1
		post.addParameter("utcSource", "E");  //E I X Y
		post.addParameter("adsInterval", "111");  //0-86400
		post.addParameter("requireCommentBlocks", "0");  //0-1
		executePost(post);
	}
	
	//设置ADS间隔 
	@Test
	public void testSetADSInterval() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE_setADSInterval);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");
		post.addParameter("adsInterval", "111");  //0-86400
		executePost(post);
	}
	
	//设置UTC资源
	@Test
	public void testSetUTCSource() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE_setUTCSource);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");
		post.addParameter("utcSource", "E");  //E I X Y
		executePost(post);
	}
	
	//设置RATDMA开关
	@Test
	public void testSetRATDMAontrol() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE_setRATDMAontrol);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");
		post.addParameter("ratdmaControl", "1");  //0-1
		executePost(post);
	}
	
	//查询扩展通用基站配置信息
	@Test
	public void testWebServiceBCE() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE);
		post.addParameter("idCode", "00010401");
		executePost(post);
	}
	
	//基站设置类总接口  ceshi1-1
	public JSONObject testBCFSetFull(SettingEntity entity, AisSiteInfo siteInfo) throws HttpException, IOException {
		System.out.println(http + webServiceBCF_setFull);
		PostMethod post = new PostMethod(http + webServiceBCF_setFull);
		post.addParameter("idCode", siteInfo.getAgreementId()==null?"":siteInfo.getAgreementId());
		post.addParameter("mmsi", entity.getMmsi()==null?"":entity.getMmsi());  //AB AL AS AD AR  9位
		post.addParameter("positionSource", String.valueOf(entity.getPositionSource()==null?"":entity.getPositionSource()));
		post.addParameter("lat", entity.getLat()==null?"":entity.getLat());
		post.addParameter("latType", entity.getLatType()==null?"":entity.getLatType());  //N|S
		post.addParameter("lon", entity.getLon()==null?"":entity.getLon());
		post.addParameter("lonType", entity.getLonType()==null?"":entity.getLonType());  //E|W
		post.addParameter("highAccuracy", String.valueOf(entity.getHighAccuracy()==null?"":entity.getHighAccuracy()));  //0-1
		post.addParameter("rxChannelA", String.valueOf(entity.getRxChannelA()==null?"":entity.getRxChannelA()));  //1001 - 2287
		post.addParameter("rxChannelB", String.valueOf(entity.getRxChannelB()==null?"":entity.getRxChannelB()));  //1001 - 2287
		post.addParameter("txChannelA", String.valueOf(entity.getTxChannelA()==null?"":entity.getTxChannelA()));  //1001 - 2287
		post.addParameter("txChannelB", String.valueOf(entity.getTxChannelB()==null?"":entity.getTxChannelB()));  //1001 - 2287
		post.addParameter("highPowerA", String.valueOf(entity.getHighPowerA()==null?"":entity.getHighPowerA()));  //0-1
		post.addParameter("highPowerB", String.valueOf(entity.getHighPowerB()==null?"":entity.getHighPowerB()));  //0-1
		post.addParameter("retriesNumber", String.valueOf(entity.getRetriesNumber()==null?"":entity.getRetriesNumber()));  //0-3
		post.addParameter("repeatIndicator", String.valueOf(entity.getRepeatIndicator()==null?"":entity.getRepeatIndicator()));  //0-3
		post.addParameter("talkerID", siteInfo.getTalkerID()==null?"":siteInfo.getTalkerID());  //AB AL AS AD AR
		 //executePost(post);
		return executePost(post);
	}
	
	//设置基站对话ID
	@Test
	public void testSetTalkerID() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setTalkerID);
		post.addParameter("idCode", "00010401");
		post.addParameter("talkerID", "AB");  //AB AL AS AD AR
		executePost(post);
	}
	
	//设置基站报文重复指示次数
	@Test
	public void testSetRepeatIndicator() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setRepeatIndicator);
		post.addParameter("idCode", "00010401");
		post.addParameter("indicatorNumber", "3");  //0-3
		executePost(post);
	}
	
	//设置基站报文重试次数
	@Test
	public void testSetMsgRetries() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setMsgRetries);
		post.addParameter("idCode", "00010401");
		post.addParameter("retriesNumber", "3");  //0-3
		executePost(post);
	}
	
	//设置基站B频道功率
	@Test
	public void testSetPowerLevelChannelB() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPowerLevelChannelB);
		post.addParameter("idCode", "00010401");
		post.addParameter("powerLevel", "1");  //0-1
		executePost(post);
	}
	
	//设置基站A频道功率
	@Test
	public void testSetPowerLevelChannelA() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPowerLevelChannelA);
		post.addParameter("idCode", "00010401");
		post.addParameter("powerLevel", "1");  //1001 - 2287
		executePost(post);
	}
	
	//设置基站Tx频道
	@Test
	public void testSetRadioTx() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setRadioTx);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelA", "2087");  //1001 - 2287
		post.addParameter("channelB", "2088");  //1001 - 2287
		executePost(post);
	}
	
	//设置基站Rx频道
	@Test
	public void testSetRadioRx() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setRadioRx);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelA", "2087");  //1001 - 2287
		post.addParameter("channelB", "2088");  //1001 - 2287
		executePost(post);
	}
	
	//设置基站位置精确度
	@Test
	public void testSetPositionAccuracy() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPositionAccuracy);
		post.addParameter("idCode", "00010401");
		post.addParameter("positionAccuracy", "2");  //0-1
		executePost(post);
	}
	
	//设置基站经纬度
	@Test
	public void testSetPosition() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPosition);
		post.addParameter("idCode", "00010401");
		post.addParameter("lat", "111");
		post.addParameter("latType", "N");  //N|S
		post.addParameter("lon", "222");
		post.addParameter("lonType", "E");  //E|W
		executePost(post);
	}
	
	//设置基站的位置源
	@Test
	public void testSetPositionSource() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPositionSource);
		post.addParameter("idCode", "00010401");
		post.addParameter("positionSource", "1");
		executePost(post);
	}
	
	//查询基站配置信息
	@Test
	public void testWebServiceBCF() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF);
		System.out.println(post.getRequestCharSet());
		post.addParameter("idCode", "00010401");
		executePost(post);
	}

	//DLM 2-4
	public JSONObject testDLMSetFul(DlmEntity entity) throws HttpException, IOException {
		System.out.println(http + webServiceDLM_sefFull);
		PostMethod post = new PostMethod(http + webServiceDLM_sefFull);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber","");
		post.addParameter("channel","");
		post.addParameter("ownership1","");
		post.addParameter("startSlot1","");
		post.addParameter("slotNumber1","");
		post.addParameter("timeout1","");
		post.addParameter("increment1","");
		post.addParameter("ownership2","");
		post.addParameter("startSlot2","");
		post.addParameter("slotNumber2","");
		post.addParameter("timeout2","");
		post.addParameter("increment2","");
		post.addParameter("ownership3","");
		post.addParameter("startSlot3","");
		post.addParameter("slotNumber3","");
		post.addParameter("timeout3","");
		post.addParameter("increment3","");
		post.addParameter("ownership4","");
		post.addParameter("startSlot4","");
		post.addParameter("slotNumber4","");
		post.addParameter("timeout4","");
		post.addParameter("increment4","");
		
		
		
	return executePost(post);
	}
	
	//====================================================================================
	//添加基站连接      ceshi4
	public JSONObject testAdd(AisSiteInfo entity) throws HttpException, IOException {
		System.out.println(http + webService_add);
		PostMethod post = new PostMethod(http + webService_add);
		//判断是单基站还是双基站 0=单基站  1=双基站
		String ip = entity.getIpAddressA();
		String port = entity.getPortA();
		if(entity.getSiteType().equals("1")) {
			ip = ip + "," + entity.getIpAddressB();
			port = port + "," + entity.getPortB();
		}
		String name = entity.getArea()+"-"+entity.getJurisdictions()+"-"+entity.getAddress();
		post.addParameter("idCode", entity.getAgreementId());
		post.addParameter("ip", ip);
		post.addParameter("port", port);
		post.addParameter("name", name);
		return executePost(post);
	}
	
	//修改基站连接信息
	@Test
	public void testUpdate(AisSiteInfo entity) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webService_update);
		//判断是单基站还是双基站 0=单基站  1=双基站
		String ip = entity.getIpAddressA();
		String port = entity.getPortA();
		if(entity.getSiteType().equals("1")) {
			ip = ip + "," + entity.getIpAddressB();
			port = port + "," + entity.getPortB();
		}
		post.addParameter("idCode", entity.getAgreementId());
		post.addParameter("ip", ip);
		post.addParameter("port", port);
		post.addParameter("name", entity.getSitename());
		executePost(post);
	}
	
	//删除基站连接
	public JSONObject testDelete(String agreementId) throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webService_delete);
		post.addParameter("idCode", agreementId);
		return executePost(post);
	}
	
	//执行post
	public JSONObject executePost(PostMethod post) {
		//修改编码格式
		HttpMethodParams params = post.getParams();
		params.setContentCharset("utf-8");
		//定义client
		HttpClient client = new HttpClient();
		JSONObject jsonObject = new JSONObject();
		int status;
		try {
			status = client.executeMethod(post);
			if(status!=200) {
				jsonObject.put("status", status);
			} else {
				String body = post.getResponseBodyAsString();
				jsonObject = JSONObject.fromObject(body);
				jsonObject.put("status", status);
			}
			System.out.println(jsonObject.toString());
		} catch (HttpException e) {
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			log.info(e.getMessage());
		}
		return jsonObject;
	}
}
