 
package com.dm.platform.aop;
/*    */ import javax.annotation.PostConstruct;

import org.springframework.beans.factory.InitializingBean;

import com.dm.platform.util.KeyRSA;

/*    */ 
public class initAction implements InitializingBean
   {
	
	boolean flag=true;
	boolean checked = true;
			
	 /*  @PostConstruct
		public void validate()
				{
			if(checked)
			{
				checked=false;
				flag = KeyRSA.getInstance().checkLicense();
				if(!flag)
				{
					System.out.println("检测到未授权");
					System.exit(0);
				}
			}
		}*/

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub
		if(checked)
		{
			checked=true;
			flag = true;//KeyRSA.getInstance().checkLicense();
			if(!flag)
			{
				System.out.println("检测到未授权");
				System.exit(0);
			}
		}
	}
 }


