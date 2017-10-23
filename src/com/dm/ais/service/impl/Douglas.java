package com.dm.ais.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.dm.ais.dto.ShipTrackInfo;

public class Douglas {
	/** 
     * 存储采样点数据的链表 
     */  
    public List<ShipTrackInfo> points = new ArrayList<ShipTrackInfo>();  
  
    /** 
     * 控制数据压缩精度的极差 
     */  
    private static double D = 1;  
  
   
    public void initPoint(List<ShipTrackInfo> ships,double depsilon){
    	points = ships;
    	D = depsilon;
    }
  
    /** 
     * 读取采样点 
     *//*  
    public void readPoint() {  
        Geometry g = buildGeo("LINESTRING (1 4,2 3,4 2,6 6,7 7,8 6,9 5,10 10)");  
        Coordinate[] coords = g.getCoordinates();  
        for (int i = 0; i < coords.length; i++) {  
            Point p = new Point(coords[i].x, coords[i].y, i);  
            points.add(p);  
        }  
    }  */
  
    /** 
     * 对矢量曲线进行压缩 
     *  
     * @param from 
     *            曲线的起始点 
     * @param to 
     *            曲线的终止点 
     */  
    public void compress(ShipTrackInfo from, ShipTrackInfo to) {  
  
        /** 
         * 压缩算法的开关量 
         */  
        boolean switchvalue = false;  
  
        /** 
         * 由起始点和终止点构成的直线方程一般式的系数 
         */  
        System.out.println(from.getY());  
        System.out.println(to.getY());  
        double A = (from.getY() - to.getY())  
                / Math.sqrt(Math.pow((from.getY() - to.getY()), 2)  
                        + Math.pow((from.getX() - to.getX()), 2));  
  
        /** 
         * 由起始点和终止点构成的直线方程一般式的系数 
         */  
        double B = (to.getX() - from.getX())  
                / Math.sqrt(Math.pow((from.getY() - to.getY()), 2)  
                        + Math.pow((from.getX() - to.getX()), 2));  
  
        /** 
         * 由起始点和终止点构成的直线方程一般式的系数 
         */  
        double C = (from.getX() * to.getY() - to.getX() * from.getY())  
                / Math.sqrt(Math.pow((from.getY() - to.getY()), 2)  
                        + Math.pow((from.getX() - to.getX()), 2));  
  
        double d = 0;  
        double dmax = 0; 
        int idx = 0;
        int m = points.indexOf(from);  
        int n = points.indexOf(to);  
        if (n == m + 1)  
            return;  
        ShipTrackInfo middle = null;  
        //List<Double> distance = new ArrayList<Double>();  
        for (int i = m + 1; i < n; i++) {  
            d = Math.abs(A * (points.get(i).getX()) + B  
                    * (points.get(i).getY()) + C)  
                    / Math.sqrt(Math.pow(A, 2) + Math.pow(B, 2));  
            //distance.add(d); 
            if (d > dmax)
            {
                idx = i;
                dmax = d;
            }            
        }  
       /* dmax = distance.get(0);  
        for (int j = 1; j < distance.size(); j++) {  
            if (distance.get(j) > dmax)  
                dmax = distance.get(j);  
        }  */
        if (dmax > D)  
            switchvalue = true;  
        else  
            switchvalue = false;  
        if (!switchvalue) {  
            // 删除Points(m,n)内的坐标  
            for (int i = n-1; i >m; i--) {  
                //points.get(i).setIndex(-1);  
                points.remove(i);
            }  
  
        } else {  
           /* for (int i = m + 1; i < n; i++) {  
                if ((Math.abs(A * (points.get(i).getX()) + B  
                        * (points.get(i).getY()) + C)  
                        / Math.sqrt(Math.pow(A, 2) + Math.pow(B, 2)) == dmax))  
                    middle = points.get(i);  
            }  */
        	middle = points.get(idx);
            compress(from, middle);  
            compress(middle, to);  
        }  
    }  
  
    public static void main(String[] args) {  
        Douglas d = new Douglas();  
        //d.readPoint();
        List<ShipTrackInfo> lstpoint = new ArrayList<ShipTrackInfo>();
        ShipTrackInfo pt = new ShipTrackInfo(1,4,0,"","","","","","","","");
        lstpoint.add(pt);
        
        pt = new ShipTrackInfo(2,3,1,"","","","","","","","");
        lstpoint.add(pt);
        
        pt = new ShipTrackInfo(4,2,2,"","","","","","","","");
        lstpoint.add(pt);
        
        pt = new ShipTrackInfo(6,6,3,"","","","","","","","");
        lstpoint.add(pt);
        
        pt = new ShipTrackInfo(7,7,4,"","","","","","","","");
        lstpoint.add(pt);
        
        pt = new ShipTrackInfo(8,6,5,"","","","","","","","");
        lstpoint.add(pt);
        
        pt = new ShipTrackInfo(9,5,6,"","","","","","","","");
        lstpoint.add(pt);
        
        pt = new ShipTrackInfo(10,10,7,"","","","","","","","");
        lstpoint.add(pt);
        
        d.initPoint(lstpoint,1);
        d.compress(d.points.get(0), d.points.get(d.points.size() - 1));  
        for (int i = 0; i < d.points.size(); i++) {  
            ShipTrackInfo p = d.points.get(i);  
            if (p.getIndex() > -1) {  
                System.out.print(p.getX() + " " + p.getY() + ",");  
            }  
        }  
    }  
}
