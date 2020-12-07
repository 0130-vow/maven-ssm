package org.gan.test;
 
import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
 
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration    // enable WebApp Test Support  
@ContextConfiguration({"classpath:spring-mvc.xml","classpath:spring-mybatis.xml"})
public class BaseTest {
	
	Logger logger=Logger.getLogger(this.getClass());
	
	@Before
	public void init(){		
		//在运行测试之前的业务代码		
	}
	
	@After
	public void after(){
		//在测试完成值之后的业务代码
	}
}
