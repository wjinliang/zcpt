package jUnitTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

public class ImportToServer {

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
		String SQL= "SELECT * from gmember";
		ResultSet rs = stmt.executeQuery(SQL);
		Long i = 1L;
		while(rs.next()){
			 
			String userId = UUID.randomUUID().toString().replaceAll("-", "");
			Long id = i;
			String login_name = rs.getString("gm_login");
			String password = rs.getString("gm_pwd");
			String address = rs.getString("home_address");
			String birthday = rs.getString("birthday");
			String current_job = rs.getString("job");
			String education = rs.getString("xueli");
			String email = rs.getString("email");
			String enter_date = rs.getString("join_date");
			String fax = rs.getString("fax");
			String gender = rs.getString("sex");
			String isRetire = "否";
			String learned_langues = "英语";
			String name = rs.getString("real_name");
			String mobile = rs.getString("mobile");
			String nation=rs.getString("minzu");
			String organization = rs.getString("work_corp");
			String profession = rs.getString("prof");
			String  user_id = userId;
			System.out.println(login_name);
			Statement stmt3 = con.createStatement() ; 
			stmt3.executeUpdate("insert into re_personnal_user(id,address," +
					"birth_date,current_job,education,email," +
					"enter_date,fax,gender,isRetire,learned_langues,name,mobile,nation," +
					"organization,profession,user_id) " +
			"values ('"+id+"','"+address+"','"+birthday+"','"+current_job+"','"+education+"'" +
					",'"+email+"','"+enter_date+"','"+fax+"','"+gender+"','"+isRetire+"','"+learned_langues+"'" +
							",'"+name+"','"+mobile+"','"+nation+"','"+organization+"','"+profession+"','"+userId+"')");
			Statement stmt1 = con.createStatement() ; 
			stmt1.executeUpdate("insert into t_user_account(code,email,enabled,headpic,name,password,seq,loginname,mobilephone,usertype,lastlogintime,mobile,remoteipaddr,account_expired,locked,password_expired)"+
					" values('"+userId+"','"+email+"',1,'','"+name+"','7c4a8d09ca3762af61e59520943dc26494f8941b'"+",10,'"+login_name+"','"+mobile+"','','','','',1,0,1)");
			Statement stmt2 = con.createStatement() ; 
			stmt2.executeUpdate("insert into t_user_account_role(user_code,role_code)"+
					" values('"+userId+"','1431566502924')");
			stmt2.close();
			stmt3.close();
			System.out.println(i); 
			i++;
		}
		System.out.println(i);
		rs.close();
	    stmt.close();
	    con.close();
	     System.out.println("����ɣ���ִ��");  
	}
	
}
