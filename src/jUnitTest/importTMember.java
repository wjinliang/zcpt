package jUnitTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;


public class importTMember {
	
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
			 
			
			String id = UUID.randomUUID().toString().replaceAll("-", "");
			String password = rs.getString("tm_pwd");
			String corp_name = rs.getString("tm_corp_name");
			String link_person = rs.getString("tm_link");
			String tel_person = rs.getString("tm_tel");
			String mobile_person = rs.getString("tm_mobile");
			String fax = rs.getString("tm_fax");
			String turl = rs.getString("tm_turl");
			String email = rs.getString("tm_email");
			String org_nature = rs.getString("tm_industry");
			String corp_eco = rs.getString("tm_corp_eco");
			String employee_num = rs.getString("tm_employee_num");
			String tech_num = rs.getString("tm_tech_num");
			String zc_num = rs.getString("tm_zc_num");
			String zc_money = rs.getString("tm_zc_money");
			String total_capital = rs.getString("tm_total_capital");
			String department = rs.getString("tm_department");
			String address = rs.getString("tm_address");
			String zip = rs.getString("tm_zip");
			String company_survey = rs.getString("tm_company_survey");
			String business = rs.getString("tm_business");
			String aptitude = rs.getString("tm_zizhi");
			String comment = rs.getString("tm_corp_desc");
			String create_time = rs.getString("tm_add_date");
			String login_name = rs.getString("tm_login");
			Statement stmt3 = con.createStatement() ; 
			stmt3.executeUpdate("insert into re_team_user_info(id,password," +
					"corp_name,link_person,tel_person,mobile_person," +
					"fax,turl,email,org_nature,corp_eco,employee_num,tech_num,zc_num," +
					"zc_money,total_capital,department,address,zip,company_survey," +
					"business,aptitude,comment,s_email,s_link_Person,s_mobile_Person," +
					"s_tel_Person,is_checked,is_payed,create_time,login_name) " +
			"values ('"+id+"','7c4a8d09ca3762af61e59520943dc26494f8941b','"+corp_name+"','"+link_person+"','"+tel_person+"','"+mobile_person+"'" +
					",'"+fax+"','"+turl+"','"+email+"','"+org_nature+"','"+corp_eco+"','"+employee_num+"'" +
							",'"+tech_num+"','"+zc_num+"','"+zc_money+"','"+total_capital+"','"+department+"'" +
									",'"+address+"','"+zip+"','"+company_survey+"','"+business+"','"+aptitude+"'" +
											",'"+comment+"','','','','','0','0','"+create_time+"','"+login_name+"')");
			Statement stmt1 = con.createStatement() ; 
			stmt1.executeUpdate("insert into t_user_account(code,email,enabled,headpic,name,password,seq,loginname,mobilephone,usertype,lastlogintime,mobile,remoteipaddr,account_expired,locked,password_expired)"+
					" values('"+id+"','"+email+"',1,'','"+corp_name+"','7c4a8d09ca3762af61e59520943dc26494f8941b'"+",10,'"+corp_name+"','"+mobile_person+"','','','','',1,0,1)");
			Statement stmt2 = con.createStatement() ; 
			stmt2.executeUpdate("insert into t_user_account_role(user_code,role_code)"+
					" values('"+id+"','1431566502924')");
			System.out.println(i); 
			i++;
			
		}
		rs.close();
	    stmt.close();
	    con.close();
	     System.out.println("����ɣ���ִ��");  
	}

}
