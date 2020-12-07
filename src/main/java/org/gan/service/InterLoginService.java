package org.gan.service;

import java.util.Map;

import org.gan.model.Student;

public interface InterLoginService {
	
	public Student checkStudentLogin(String account, String password);

	public String changePassword(Map<String, String> map);

}
