package jUnitTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;


public class ImportPersonMember {
	public static String url = "jdbc:mysql://127.0.0.1/mm?useUnicode=true&characterEncoding=utf8" ;    
	public static String username = "root";   
	public static String password = "root";
	public static void main(String[] args) throws SQLException {
	try{   
		Class.forName("com.mysql.jdbc.Driver") ;   
	}catch(ClassNotFoundException e){   
		System.out.println("�޷�������");   
		e.printStackTrace();   
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
	String SQL= "SELECT  gm_login,dangpai from gmember where dangpai is not null";
	ResultSet rs = stmt.executeQuery(SQL);
	Long i = 1L;
	while(rs.next()){
		String login_name = rs.getString("gm_login");
		if(login_name==null || login_name.equals("null"))
		{
			continue;
		}
		String dangpai = rs.getString("dangpai");
		Statement stmt3 = con.createStatement() ; 
		ResultSet rs3 = stmt3.executeQuery("select code from t_user_account where loginname='"+login_name+"'");
		int j=0;
		while(rs3.next())
		{
			String id = rs3.getString("code");
			if(dangpai!=null)
			{
			String Sql4 = "update mm.re_personnal_user set party_group='"+dangpai+"' where user_id='"+id+"'";
			System.out.println(Sql4);
			Statement stmt4= con.createStatement() ; 
			stmt4.executeUpdate(Sql4);
			stmt4.close();
			}
			j++;
		}
		System.out.println(j);
		rs3.close();
		stmt3.close();
		//System.out.println(i); 
		i++;
	}
	System.out.println(i);
	rs.close();
    stmt.close();
    con.close();
    System.out.println("����ɣ���ִ��");  
  }
}
