package jUnitTest;


import java.sql.ResultSet;
import java.sql.SQLException;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.ApplyEntity;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.ApplyService;
import com.dm.platform.util.CommonStatics;

public class JdbcTemplateJTest {
	private static JdbcTemplate jdbcTemplate; 
	@BeforeClass
    public static void setUpClass() {  
        String url = "jdbc:mysql://localhost:3306/dm?useUnicode=true&amp;characterEncoding=utf-8";  
        String username = "root";  
        String password = "root";  
        DriverManagerDataSource dataSource = new DriverManagerDataSource(url, username, password);  
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");  
        jdbcTemplate = new JdbcTemplate(dataSource);  
    }  
	@Test
	public void test() {  
        //1.声明SQL  
        String sql = "select * from t_org";  
        jdbcTemplate.query(sql, new RowCallbackHandler() {  
            @Override  
            public void processRow(ResultSet rs) throws SQLException {  
                //2.处理结果集  
                String value = rs.getString("NAME");  
                System.out.println("Column NAME:" + value);  
            }  
        });  
    } 
	@Test
	public void test2() {  
		ApplicationContext ct = new ClassPathXmlApplicationContext(
				"applicationContext.xml");
		ApplyService applyService = (ApplyService) ct.getBean("applyServiceImpl");
		System.out.println(applyService.getApplyResult("1"));
		ApplyEntity entity = new ApplyEntity();
		String applyId = String.valueOf(System.currentTimeMillis());
		entity.setApplyId(applyId);
		entity.setApplyContent("测试");
		entity.setApplyStatus("0");
		entity.setApplyUserId("1411999238349");
		entity.setApplyObjType(CommonStatics.USER_REG);
		entity.setApplyObjId("123");
		applyService.newApply(entity);
		applyService.sendApply(applyId, "1", CommonStatics.NEED_APPROVE, 1);
	}
	@Test
	public void test3() { 
		ApplicationContext ct = new ClassPathXmlApplicationContext(
				"applicationContext.xml");
		CommonDAO commonDAO = (CommonDAO) ct.getBean("commonDAOImpl");
		UserAccount user = commonDAO.findOne(UserAccount.class, "1");
		System.out.print(user.getPassword());
	} 

}
