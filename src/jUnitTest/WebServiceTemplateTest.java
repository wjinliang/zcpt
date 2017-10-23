package jUnitTest;

import java.io.IOException;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.junit.Ignore;
import org.junit.Test;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.util.AisPropertiesUtil;

public class WebServiceTemplateTest {

	public final static String http = "http://192.168.51.190:9003";
	
	public final static String AIS_Monitor_http = "http://111.160.243.126:12345";
	public final static String webService_AIS_Monitor_DeptInfo = "/ReformData/AIS_Monitor?cmd=DeptInfo";
	
	//一、AIS系统管理设置电文
	//1.基站设置类接口
	public final static String webServiceBCF_setPositionSource = "/bcf/setPositionSource";
	public final static String webServiceBCF_setPosition = "/bcf/setPosition";
	public final static String webServiceBCF_setPositionAccuracy = "/bcf/setPositionAccuracy";
	public final static String webServiceBCF_setRadioRx = "/bcf/setRadioRx";
	public final static String webServiceBCF_setRadioTx = "/bcf/setRadioTx";
	public final static String webServiceBCF_setPowerLevelChannelA = "/bcf/setPowerLevelChannelA";
	public final static String webServiceBCF_setPowerLevelChannelB = "/bcf/setPowerLevelChannelB";
	public final static String webServiceBCF_setMsgRetries = "/bcf/setMsgRetries";
	public final static String webServiceBCF_setRepeatIndicator = "/bcf/setRepeatIndicator";
	public final static String webServiceBCF_setTalkerID = "/bcf/setTalkerID";
	public final static String webServiceBCF_setFull = "/bcf/setFull";
	//2.扩展通用基站类接口
	public final static String webServiceBCE_setRATDMAontrol = "/bce/setRATDMAontrol";
	public final static String webServiceBCE_setUTCSource = "/bce/setUTCSource";
	public final static String webServiceBCE_setADSInterval = "/bce/setADSInterval";
	public final static String webServiceBCE_setFull = "/bce/setFull";
	//3.控制AIS基站类接口 /cab/setChannelAControl
	public final static String webServiceCAB_setChannelAControl = "/cab/setChannelAControl";
	public final static String webServiceCAB_setChannelBControl = "/cab/setChannelBControl";
	public final static String webServiceCAB_restartBaseStation = "/cab/restartBaseStation";
	public final static String webServiceCAB_restoreBaseStation = "/cab/restoreBaseStation";
	public final static String webServiceCAB_setFull = "/cab/setFull";
	//4.分配基站报文报告率类接口
	public final static String webServiceECB_setReprotingRatesForMsg4="/ecb/setReprotingRatesForMsg4";
	public final static String webServiceECB_setReprotingRatesForMsg17="/ecb/setReprotingRatesForMsg17";
	public final static String webServiceECB_setReprotingRatesForMsg20="/ecb/setReprotingRatesForMsg20";
	public final static String webServiceECB_setReprotingRatesForMsg22="/ecb/setReprotingRatesForMsg22";
	public final static String webServiceECB_setReprotingRatesForMsg23="/ecb/setReprotingRatesForMsg23";
	public final static String webServiceECB_setFull="/ecb/setFull";
	//5.站点识别安装类接口
	public final static String webServiceSID_setNewUID="/sid/setNewUID";
	public final static String webServiceSID_setNewMMSI="/sid/setNewMMSI";
	public final static String webServiceSID_setFull="/sid/setFull";
	//6.传输时隙禁用类接口
	public final static String webServiceTSP_setTSPForChA="/tsp/setTSPForChA";
	public final static String webServiceTSP_setTSPForChB="/tsp/setTSPForChB";
	public final static String webServiceTSP_setFull="/tsp/setFull";
	//7.选择AIS设备的处理和输出类接口
	public final static String webServiceSPO_setVSIOutput="/spo/setVSIOutput";
	public final static String webServiceSPO_setFSROutput="/spo/setFSROutput";
	public final static String webServiceSPO_setFull="/spo/setFull";
	
	//二、AIS广播电文
	//1.ACM-准备及启动AIS基站处理报文管理模式类接口
	public final static String webServiceACM_setACM="/acm/setACM";
	//2.AGA-AIS基站准备开始播报一组报文类接口
	public final static String webServiceAGA_setAGA="/aga/setAGA";
	//3.ASN-AIS基站准备开始播报VDL报文类接口
	public final static String webServiceASN_setFirstAisUnitMMSI="/asn/setFirstAisUnitMMSI";
	//4.DLM-在基站中用数据链接管理时隙分配类接口
	public final static String webServiceDLM_setChADataLinkForReservation1="/dlm/setChADataLinkForReservation1";
	public final static String webServiceDLM_setChADataLinkForReservation2="/dlm/setChADataLinkForReservation2";
	public final static String webServiceDLM_setChADataLinkForReservation3="/dlm/setChADataLinkForReservation3";
	public final static String webServiceDLM_setChADataLinkForReservation4="/dlm/setChADataLinkForReservation4";
	public final static String webServiceDLM_setChBDataLinkForReservation1="/dlm/setChBDataLinkForReservation1";
	public final static String webServiceDLM_setChBDataLinkForReservation2="/dlm/setChBDataLinkForReservation2";
	public final static String webServiceDLM_setChBDataLinkForReservation3="/dlm/setChBDataLinkForReservation3";
	public final static String webServiceDLM_setChBDataLinkForReservation4="/dlm/setChBDataLinkForReservation4";
	public final static String webServiceDLM_sefFull=AisPropertiesUtil.getInstance().getProperty("webServiceDLM_setFull");
	//5.TSA-传输时隙分配类接口
	public final static String webServiceTSA_setTSAForChA="/tsa/setTSAForChA";
	public final static String webServiceTSA_setTSAForChB="/tsa/setTSAForChB";
	//6.ABM-AIS寻址二进制及寻址安全相关报文类接口
	public final static String webServiceABM_setABMForMessage6IMF0="/abm/setABMForMessage6IMF0"; 
	public final static String webServiceABM_setABMForMessage6IMF3="/abm/setABMForMessage6IMF3"; 
	public final static String webServiceABM_setABMForMessage6IMF4="/abm/setABMForMessage6IMF4"; 
	//7.BBM-AIS二进制广播报文类接口
	public final static String webServiceBBM_setBBMForMessage8="/bbm/setBBMForMessage8"; 
	public final static String webServiceBBM_setBBMForMessage14="/bbm/setBBMForMessage14"; 
	//8.AIR-AIS询问类接口
	public final static String webServiceAIR_setAIR="/air/setAIR"; 
	//9.ACA-AIS信道指配报文类接口
	public final static String webServiceACA_setACA="/aca/setACA";
	//10.ACS-AIS信道管理信息源类接口
	public final static String webServiceACS_setACS="/acs/setACS";
	//11.CBR- AIS基站广播频率设置报文命令类接口
	public final static String webServiceCBR_setCBR="/cbr/setCBR";
	//12.LRI-AIS长距离类接口
	public final static String webServiceLRI_setLRI="/lri/setLRI";
	//13.LRF-AIS长距离功能类接口
	public final static String webServiceLRF_setLRF="/lrf/setLRF";
	//14.MEB-广播命令的报文输入类接口
	public final static String webServiceMEB_setMebForMessage6IFM0="/meb/setMebForMessage6IFM0";
	public final static String webServiceMEB_setMebForMessage8="/meb/setMebForMessage8";
	public final static String webServiceMEB_setMebForMessage12="/meb/setMebForMessage12";
	public final static String webServiceMEB_setMebForMessage14="/meb/setMebForMessage14";
	
	//三、AIS系统管理查看电文
	public final static String webServiceBCF = "/query/BCF";
	public final static String webServiceBCE = "/query/BCE";
	public final static String webServiceCAB = "/query/CAB";
	public final static String webServiceECB = "/query/ECB";
	
	//四、基站连接信息维护
	public final static String webService_add = "/site/add";
	public final static String webService_update = "/site/update";
	public final static String webService_delete = "/site/delete";
	
	//广播6号报文
	@Ignore
	@Test
	public void testSetMebForMessage6IFM0() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceMEB_setMebForMessage6IFM0);
		post.addParameter("idCode", "1");
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
	@Ignore
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
	@Ignore
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
		post.addParameter("text", "1");  //6位ASCII码 小于6968
		executePost(post);  
	}
	//广播14号报文
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
	@Test
	public void testSetChADataLinkForReservation1() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChADataLinkForReservation1);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "1");     //1-40
		post.addParameter("ownership", "L");     //L R C
		post.addParameter("startSlot", "2249");   //0-2249
		post.addParameter("slotNumber", "0");      //0-5
		post.addParameter("timeout", "2");       //0-7
		post.addParameter("increment", "200");        //0-1125
		executePost(post);
	}
	//设置基站A频道保留2的数据链接管理
	@Ignore
	@Test
	public void testSetChADataLinkForReservation2() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChADataLinkForReservation2);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "2");     //1-40
		post.addParameter("ownership", "L");     //L R C
		post.addParameter("startSlot", "2249");   //0-2249
		post.addParameter("slotNumber", "0");      //0-5
		post.addParameter("timeout", "2");       //0-7
		post.addParameter("increment", "200");        //0-1125
		executePost(post);
	}
	//设置基站A频道保留3的数据链接管理
	@Ignore
	@Test
	public void testSetChADataLinkForReservation3() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChADataLinkForReservation3);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "3");     //1-40
		post.addParameter("ownership", "L");     //L R C
		post.addParameter("startSlot", "2249");   //0-2249
		post.addParameter("slotNumber", "0");      //0-5
		post.addParameter("timeout", "2");       //0-7
		post.addParameter("increment", "200");        //0-1125
		executePost(post);
	}
	//设置基站A频道保留4的数据链接管理
	@Ignore
	@Test
	public void testSetChADataLinkForReservation4() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChADataLinkForReservation4);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "4");     //1-40
		post.addParameter("ownership", "L");     //L R C
		post.addParameter("startSlot", "2249");   //0-2249
		post.addParameter("slotNumber", "0");      //0-5
		post.addParameter("timeout", "2");       //0-7
		post.addParameter("increment", "200");        //0-1125
		executePost(post);
	}
	//设置基站B频道保留1的数据链接管理
	@Ignore
	@Test
	public void testSetChBDataLinkForReservation1() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChBDataLinkForReservation1);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "1");     //1-40
		post.addParameter("ownership", "L");     //L R C
		post.addParameter("startSlot", "2249");   //0-2249
		post.addParameter("slotNumber", "0");      //0-5
		post.addParameter("timeout", "2");       //0-7
		post.addParameter("increment", "200");        //0-1125
		executePost(post);
	}
	//设置基站B频道保留2的数据链接管理
	@Ignore
	@Test
	public void testSetChBDataLinkForReservation2() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChBDataLinkForReservation2);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "2");     //1-40
		post.addParameter("ownership", "L");     //L R C
		post.addParameter("startSlot", "2249");   //0-2249
		post.addParameter("slotNumber", "0");      //0-5
		post.addParameter("timeout", "2");       //0-7
		post.addParameter("increment", "200");        //0-1125
		executePost(post);
	}
	//设置基站B频道保留3的数据链接管理
	@Ignore
	@Test
	public void testSetChBDataLinkForReservation3() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChBDataLinkForReservation3);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "3");     //1-40
		post.addParameter("ownership", "L");     //L R C
		post.addParameter("startSlot", "2249");   //0-2249
		post.addParameter("slotNumber", "0");      //0-5
		post.addParameter("timeout", "2");       //0-7
		post.addParameter("increment", "200");        //0-1125
		executePost(post);
	}
	//设置基站B频道保留4的数据链接管理
	@Ignore
	@Test
	public void testSetChBDataLinkForReservation4() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceDLM_setChBDataLinkForReservation4);
		post.addParameter("idCode", "00010401");
		post.addParameter("seqNumber", "3");     //1-40
		post.addParameter("ownership", "L");     //L R C
		post.addParameter("startSlot", "2249");   //0-2249
		post.addParameter("slotNumber", "0");      //0-5
		post.addParameter("timeout", "2");       //0-7
		post.addParameter("increment", "200");        //0-1125
		executePost(post);
	}
	
	//设置AIS基站播报16号报文
	@Ignore
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
	@Ignore
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
	@Ignore
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
	
	//设置VSI语句的输出
	@Ignore
	@Test
	public void testSPOSetFull() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceSPO_setFull);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		
		post.addParameter("signalStrength", "0");     //0-2
		post.addParameter("channel", "B");         //A B E N
		post.addParameter("firstSlotNum", "1");  //0-2
		post.addParameter("msgArriveTime", "1");    //0-2
		post.addParameter("signalNoiseRatio", "1");   //0-2
		post.addParameter("channelLoad", "2");//0-2
		post.addParameter("badCRCMsgNum", "1");     //0-1
		post.addParameter("forecastChannelLoad", "2");         //0-2
		post.addParameter("avarageNoiseLevel", "1");  //0-2
		post.addParameter("recievedSignalStrength", "1");    //0-2
		post.addParameter("vdmSentence", "1");   //0-1
		post.addParameter("vdoSentence", "1");//0-1
		post.addParameter("fsrSentenceOfAfterFrame", "1");     //0-1
		executePost(post);
	}
	
	//设置VSI语句的输出
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
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
	@Ignore
	@Test
	public void testWebServiceECB() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB);
		post.addParameter("idCode", "00010401");
		executePost(post);
	}
	
	//设置基站的MMSI
	@Ignore
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
	@Ignore
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
	@Ignore
	@Test
	public void testSetNewUID() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceSID_setNewUID);
		post.addParameter("idCode", "00010401");
		post.addParameter("currentUID", "111111111111111");
		post.addParameter("newUID", "222222222222222");
		executePost(post);
	}
	
	//分配基站报文报告率类总接口 1-4
	@Ignore
	@Test
	public void testECBSetFull() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setFull);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		
		post.addParameter("msgId", "20");   //4, 17, 20, 22, 23
		
		post.addParameter("chAutcMinute", "1");  //0-59
		post.addParameter("chASlot", "2");       //0-2249
		post.addParameter("chAIncrement", "3");  //0 – 13500
		post.addParameter("chASlotsNum", "3");   //1-4
		
		post.addParameter("chButcMinute", "5");   //0-59
		post.addParameter("chBSlot", "6");        //0-2249
		post.addParameter("chBIncrement", "7");   //0 – 13500
		post.addParameter("chBSlotsNum", "8");   //1-4
		executePost(post);
	}
	
	//设置23号报文的播报频率
	@Ignore
	@Test
	public void testSetReprotingRatesForMsg23() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg23);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		
		post.addParameter("chAutcMinute", "1");  //0-59
		post.addParameter("chASlot", "2");        //0-2249
		post.addParameter("chAIncrement", "3");  //0 – 13500
		
		post.addParameter("chButcMinute", "5");   //0-59
		post.addParameter("chBSlot", "6");        //0-2249
		post.addParameter("chBIncrement", "7");   //0 – 13500
		executePost(post);
	}
	
	//设置22号报文的播报频率
	@Ignore
	@Test
	public void testSetReprotingRatesForMsg22() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg22);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		
		post.addParameter("chAutcMinute", "1");  //0-59
		post.addParameter("chASlot", "2");        //0-2249
		post.addParameter("chAIncrement", "3");  //0 – 13500
		
		post.addParameter("chButcMinute", "5");   //0-59
		post.addParameter("chBSlot", "6");        //0-2249
		post.addParameter("chBIncrement", "7");   //0 – 13500
		executePost(post);
	}
	
	//设置20号报文的播报频率
	@Ignore
	@Test
	public void testSetReprotingRatesForMsg20() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg20);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		
		post.addParameter("chAutcMinute", "1");  //0-59
		post.addParameter("chASlot", "2");        //0-2249
		post.addParameter("chAIncrement", "3");  //0 – 13500
		
		post.addParameter("chButcMinute", "5");   //0-59
		post.addParameter("chBSlot", "6");        //0-2249
		post.addParameter("chBIncrement", "7");   //0 – 13500
		executePost(post);
	}
	
	//设置17号报文的播报频率
	@Ignore
	@Test
	public void testSetReprotingRatesForMsg17() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg17);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		
		post.addParameter("chAutcMinute", "1");  //0-59
		post.addParameter("chASlot", "2");        //0-2249
		post.addParameter("chAIncrement", "3");  //0 – 13500
		post.addParameter("chASlotsNum", "4");   //1-4
		
		post.addParameter("chButcMinute", "5");   //0-59
		post.addParameter("chBSlot", "6");        //0-2249
		post.addParameter("chBIncrement", "7");   //0 – 13500
		post.addParameter("chBSlotsNum", "8");    //1-4
		executePost(post);
	}
	
	//设置4号报文的播报频率
	@Ignore
	@Test
	public void testSetReprotingRatesForMsg4() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceECB_setReprotingRatesForMsg4);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "111111111111111");
		post.addParameter("chASlot", "666");   //-1-749
		executePost(post);
	}
	
	
	//控制AIS基站类总接口
	@Ignore
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
	@Ignore
	@Test
	public void testRestoreBaseStation() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_restoreBaseStation);
		post.addParameter("idCode", "00010401");
		post.addParameter("restoreFlag", "1");  
		executePost(post);
	}
	
	//设置基站重启设置值
	@Ignore
	@Test
	public void testSestartBaseStation() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_restartBaseStation);
		post.addParameter("idCode", "00010401");
		post.addParameter("startFlag", "1");  
		executePost(post);
	}
	
	//设置频道B开关值
	@Ignore
	@Test
	public void testSetChannelBControl() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_setChannelBControl);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelBControl", "1");  //0-1
		executePost(post);
	}
	
	//设置频道A开关 
	@Ignore
	@Test
	public void testSetChannelAControl() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceCAB_setChannelAControl);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelAControl", "0");  //0-1
		executePost(post);
	}
	
	//扩展通用基站类总接口
	@Ignore
	@Test
	public void testBCESetFull() throws HttpException, IOException {
		System.out.println(http + webServiceBCE_setFull);
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
	@Ignore
	@Test
	public void testSetADSInterval() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE_setADSInterval);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");
		post.addParameter("adsInterval", "111");  //0-86400
		executePost(post);
	}
	
	//设置UTC资源
	@Ignore
	@Test
	public void testSetUTCSource() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE_setUTCSource);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");
		post.addParameter("utcSource", "E");  //E I X Y
		executePost(post);
	}
	
	//设置RATDMA开关
	@Ignore
	@Test
	public void testSetRATDMAontrol() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE_setRATDMAontrol);
		post.addParameter("idCode", "00010401");
		post.addParameter("uid", "11111111111111");
		post.addParameter("ratdmaControl", "1");  //0-1
		executePost(post);
	}
	
	//查询扩展通用基站配置信息
	@Ignore
	@Test
	public void testWebServiceBCE() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCE);
		post.addParameter("idCode", "00010401");
		executePost(post);
	}
	
	//基站设置类总接口  ceshi1-1
	@Ignore
	@Test
	public void testBCFSetFull() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setFull);
		post.addParameter("idCode", "00010401");
		post.addParameter("mmsi", "999999999");  //AB AL AS AD AR
		post.addParameter("positionSource", "1");
		post.addParameter("lat", "111");
		post.addParameter("latType", "N");  //N|S
		post.addParameter("lon", "222");
		post.addParameter("lonType", "E");  //E|W
		post.addParameter("highAccuracy", "2");  //0-1
		post.addParameter("rxChannelA", "2087");  //1001 - 2287
		post.addParameter("rxChannelB", "2088");  //1001 - 2287
		post.addParameter("txChannelA", "2087");  //1001 - 2287
		post.addParameter("txChannelB", "2088");  //1001 - 2287
		post.addParameter("highPowerA", "1");  //0-1
		post.addParameter("highPowerB", "1");  //0-1
		post.addParameter("retriesNumber", "3");  //0-3
		post.addParameter("repeatIndicator", "3");  //0-3
		post.addParameter("talkerID", "AB");  //AB AL AS AD AR
		executePost(post);
	}
	
	//设置基站对话ID
	@Ignore
	@Test
	public void testSetTalkerID() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setTalkerID);
		post.addParameter("idCode", "00010401");
		post.addParameter("talkerID", "AB");  //AB AL AS AD AR
		executePost(post);
	}
	
	//设置基站报文重复指示次数
	@Ignore
	@Test
	public void testSetRepeatIndicator() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setRepeatIndicator);
		post.addParameter("idCode", "00010401");
		post.addParameter("indicatorNumber", "3");  //0-3
		executePost(post);
	}
	
	//设置基站报文重试次数
	@Ignore
	@Test
	public void testSetMsgRetries() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setMsgRetries);
		post.addParameter("idCode", "00010401");
		post.addParameter("retriesNumber", "3");  //0-3
		executePost(post);
	}
	
	//设置基站B频道功率
	@Ignore
	@Test
	public void testSetPowerLevelChannelB() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPowerLevelChannelB);
		post.addParameter("idCode", "00010401");
		post.addParameter("powerLevel", "1");  //0-1
		executePost(post);
	}
	
	//设置基站A频道功率
	@Ignore
	@Test
	public void testSetPowerLevelChannelA() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPowerLevelChannelA);
		post.addParameter("idCode", "00010401");
		post.addParameter("powerLevel", "1");  //1001 - 2287
		executePost(post);
	}
	
	//设置基站Tx频道
	@Ignore
	@Test
	public void testSetRadioTx() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setRadioTx);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelA", "2087");  //1001 - 2287
		post.addParameter("channelB", "2088");  //1001 - 2287
		executePost(post);
	}
	
	//设置基站Rx频道
	@Ignore
	@Test
	public void testSetRadioRx() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setRadioRx);
		post.addParameter("idCode", "00010401");
		post.addParameter("channelA", "2087");  //1001 - 2287
		post.addParameter("channelB", "2088");  //1001 - 2287
		executePost(post);
	}
	
	//设置基站位置精确度
	@Ignore
	@Test
	public void testSetPositionAccuracy() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPositionAccuracy);
		post.addParameter("idCode", "00010401");
		post.addParameter("positionAccuracy", "2");  //0-1
		executePost(post);
	}
	
	//设置基站经纬度
	@Ignore
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
	@Ignore
	@Test
	public void testSetPositionSource() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webServiceBCF_setPositionSource);
		post.addParameter("idCode", "00010401");
		post.addParameter("positionSource", "1");
		executePost(post);
	}
	
	//查询基站配置信息
	//@Ignore
	@Test
	public void testWebServiceBCF() throws HttpException, IOException {
		System.out.println(http + webServiceBCF);
		PostMethod post = new PostMethod(http + webServiceBCF);
		System.out.println(post.getRequestCharSet());
		post.addParameter("idCode", "00010405");
		executePost(post);
	}
	
	//DLM 2-4
	@Ignore
	@Test
	public void testDLMSetFull( ) throws HttpException, IOException {
		System.out.println(http + webServiceDLM_sefFull);
		PostMethod post = new PostMethod(http + webServiceDLM_sefFull);
		post.addParameter("idCode", "00010401");
		
		executePost(post);
	}
	
	//====================================================================================
	//添加基站连接  ceshi4
	//@Ignore
	@Test
	public void testAdd() throws HttpException, IOException {
		System.out.println(http+webService_add);
		PostMethod post = new PostMethod(http + webService_add);
		post.addParameter("idCode", "00010410");
		post.addParameter("ip", "192.168.64.24");
		post.addParameter("port", "8021");
		post.addParameter("name", new String("caofeidian2".getBytes("UTF-8"), "UTF-8"));
		executePost(post);
	}
	
	//修改基站连接信息
	@Ignore
	@Test
	public void testUpdate() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webService_update);
		post.addParameter("idCode", "00010404");
		post.addParameter("ip", "127.0.0.1");
		post.addParameter("port", "8021");
		post.addParameter("name", new String("北方海区-天津-绥中".getBytes(), "ISO-8859-1"));
		executePost(post);
	}
	
	//删除基站连接
	//@Ignore
	@Test
	public void testDelete() throws HttpException, IOException {
		PostMethod post = new PostMethod(http + webService_delete);
		post.addParameter("idCode", "00010406");
		executePost(post);
	}
	
	//执行post
	public void executePost(PostMethod post) throws HttpException, IOException {
		HttpClient client = new HttpClient();
		HttpMethodParams params = post.getParams();
		params.setContentCharset("utf-8");
		JSONObject jsonObject = new JSONObject();
		int status = client.executeMethod(post);
		if(status!=200) {
			jsonObject.put("status", status);
		} else {
			String body = post.getResponseBodyAsString();
			System.out.println(body);
			jsonObject = JSONObject.fromObject(body);
			jsonObject.put("status", status);
			System.out.println(jsonObject);
		}
		
	}
	
	
}
