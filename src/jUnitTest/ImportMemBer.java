package jUnitTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

public class ImportMemBer {

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
	String SQL= "select * from tmember t where 1=1";
	ResultSet rs = stmt.executeQuery(SQL);
	int i = 0;
	while(rs.next()){
		
		String corp_name = rs.getString("tm_corp_name");
		String memNum = rs.getString("tm_memberid");
		Statement stmt2 = con.createStatement();
		stmt2.executeUpdate("update re_team_user_info r set r.mem_num='"+memNum+"' where r.corp_name='"+corp_name+"'");
		stmt2.close();
		System.out.println(i); 
		i++;
		
	}
	rs.close();
    stmt.close();
    con.close();
     System.out.println("1111");  
	}
}
