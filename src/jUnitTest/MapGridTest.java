package jUnitTest;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dm.ais.schedule.SiteInfoMonitor;
import com.dm.ais.util.CacheUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapGridTest {

	@Ignore
	@Test
	public void grid(){
	for(double x=-180;x<180;x=x+2.5)
	  {  
	  for(double y=90;y>-90;y=y-2.5)
	  	{ 
     	 //y-1.25 ,x+1.25  
	  	}
	  }
	}
	
	@Ignore
	@Test
	public void cacheTest()
	{
		CacheUtil cacheUtil = new CacheUtil();
		cacheUtil.put();
	}
	
	@Ignore
	@Test
	public void gridLoad()
	{
		SiteInfoMonitor siteInfoMonitor = new SiteInfoMonitor();
		siteInfoMonitor.gridLoad();
	}
}