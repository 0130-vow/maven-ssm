package org.gan.test;

import javax.annotation.Resource;

import org.gan.service.InterStudentService;
import org.junit.Test;

public class GetAllStudentTest extends BaseTest{
	
	@Resource
	private InterStudentService service;
	
	@Test
	public void test() {
		
		/*System.out.println(service.showStudentList());
		System.out.println(service.getOneStudent(1000));*/

		logger.info(service.showStudentList());
		logger.info(service.getOneStudent(1000));
	}

}
