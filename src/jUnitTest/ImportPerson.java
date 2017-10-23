package jUnitTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

public class ImportPerson {


	public static String url = "jdbc:mysql://127.0.0.1/mm?useUnicode=true&characterEncoding=utf8" ;    
	public static String username = "root" ;   
	public static String password = "root" ;
	
	
	
	public static void main(String[] args) throws SQLException {
		try{   
			Class.forName("com.mysql.jdbc.Driver") ;   
		}catch(ClassNotFoundException e){   
			System.out.println("�޷�������");   
			e.printStackTrace() ;   
	    }   
		Connection con = null;
		try{
		    con = DriverManager.getConnection(url,username,password);
		    System.out.println("������ݿ�ɹ�����");
	    }catch(SQLException se){   
		    System.out.println("�޷�������ݿ�");   
		    se.printStackTrace() ;   
		} 
		
		Statement stmt = con.createStatement() ;   
		String SQL= "SELECT gm_login FROM mm.gmember t  group by gm_login having count(gm_login) >1 order by gm_login";
		ResultSet rs = stmt.executeQuery(SQL);
		int i = 0;
		while(rs.next()){
			 
			String loginName = rs.getString("gm_login");
			Statement stmt3 = con.createStatement() ; 
			System.out.println(loginName);
			String sqln = "select gm_id from mm.gmember t where t.gm_login='"+loginName+"'";
			ResultSet rs1 = stmt3.executeQuery(sqln);
			int j=1;
			while(rs1.next())
			{
				Statement stmt2 = con.createStatement() ; 
				String Sql2 = "update mm.gmember set gm_login='"+loginName+j+"'"+"where gm_id='"+rs1.getString("gm_id")+"'";
				stmt2.executeUpdate(Sql2);
				stmt2.close();
				j++;
			}
			System.out.println(j);
			stmt3.close();
			i++;
			if(i>1000)
			{
			  break;	
			}
		}
		System.out.println(i);
		rs.close();
	    stmt.close();
	    con.close();
	     System.out.println("����ɣ���ִ��");  
	}
	
}
