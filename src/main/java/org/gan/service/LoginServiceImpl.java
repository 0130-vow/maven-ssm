package org.gan.service;

import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;
import org.gan.mapper.LoginMapper;
import org.gan.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LoginServiceImpl implements InterLoginService {
	
	@Autowired(required=true)
	private LoginMapper loginDao;

	@Override
	public Student checkStudentLogin(String account, String password) {
		return loginDao.getStudentByLogin(account, DigestUtils.md5Hex(password + account));
	}

	@Override
	public String changePassword(Map<String, String> map) {
		String sno = map.get("sno");
		String password = DigestUtils.md5Hex(map.get("password") + sno);
		String newpassword = DigestUtils.md5Hex(map.get("newpassword") + sno);
		//md5(#{newpassword}+'token') where sno=#{sno} and passwd=md5(#{password}+'token')
		return String.valueOf(loginDao.changePassword(sno, password, newpassword));
	}

}
