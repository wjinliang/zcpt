package com.dm.ais.util;

public class Formula {
	public static int ExcelFormula(double AOM5,double AON5,double AOM6,double AON6){
		int AOM12 = 30;
		int AOM13 = 6;
		int AOM17 = 120;
		int AOM19 = 3;
		double AOM9 = AOM5+AON5/60;    //处理后的纬度
		double AOM10 = AOM6+AON6/60;  //处理后的经度
		int AOM21 = (int) Math.floor(Math.abs(AOM9)/AOM19);
		double AOM23 =  (AOM21+0.5)*AOM19;
		int AOM25 = (int)Math.floor((Math.cos(AOM23*Math.PI/180)*AOM17));
		int AOM22 = (int)Math.floor(Math.abs(AOM10)/360*AOM25);
		double AOM27 = 360/(double)AOM13/(double)AOM25;
		int AOM29 = (int) Math.floor(((Math.abs(AOM9)*60)/AOM12)-AOM13*AOM21);
		int AOM31;
		if (AOM9 > 0) {
			AOM31 = AOM13-AOM29-1;
		}else {
			AOM31 = AOM29;
		}
		int AOM33 = (int) Math.floor(Math.abs(AOM10)/AOM27);
		int AOM35 = AOM33-((int)Math.floor(AOM33/6))*6;
		int AOM37; 
		if (AOM10<0) {
			AOM37 = (AOM13-1)-AOM35;
		}else {
			AOM37 = AOM35;
		}
		int AOM39 = AOM31*AOM13+AOM37+1;
		System.out.println("AOM9="+AOM9);
		System.out.println("AOM10="+AOM10);
		System.out.println("AOM21="+AOM21);
		System.out.println("AOM22="+AOM22);
		System.out.println("AOM23="+AOM23);
		System.out.println("AOM25="+AOM25);
		System.out.println("AOM27="+AOM27);
		System.out.println("AOM29="+AOM29);
		System.out.println("AOM31="+AOM31);
		System.out.println("AOM33="+AOM33);
		System.out.println("AOM35="+AOM35);
		System.out.println("AOM37="+AOM37);
		System.out.println("AOM39="+AOM39);
		
		
		return AOM39;
	}
	
	public static void main(String[] args) {
		double AOM5 = 36;   //纬度
		double AON5 = 22.3047;
		double AOM6 = 120;  //经度
		double AON6 = 51.2463;
		//int hehe = ExcelFormula(AOM5,AON5,AOM6,AON6);  //第一组 nvdao
		//int hehe2 = ExcelFormula(36,53.837,122,30.8598);  //第二组 moyedao
		int hehe3 = ExcelFormula(37,41.1423,120,13.571);  //第三组 qimudao
		//System.out.println("hehe="+hehe);
	}
}
