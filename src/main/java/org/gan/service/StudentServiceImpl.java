package org.gan.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.gan.mapper.LoginMapper;
import org.gan.mapper.StudentMapper;
import org.gan.model.Login;
import org.gan.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StudentServiceImpl implements InterStudentService {

	@Autowired(required=true)
	private StudentMapper studentDao;
	
	@Autowired
	private LoginMapper loginDao;
	
	@Override
	public List<Student> showStudentList() {
		return studentDao.getAllStudent();
	}

	@Override
	public boolean checkID(int sno) {
		if(studentDao.getStudentByID(sno)!=null)
			return true;
		return false;
	}

	@Override
	public boolean addStudent(Student stu) {
		Login login = new Login();
		int sno = stu.getSno();
		login.setAccount(String.valueOf(stu.getSno()));
		login.setSno(stu.getSno());
		login.setPasswd(DigestUtils.md5Hex("e10adc3949ba59abbe56e057f20f883e" + sno));
		login.setRecordtime(new Date());
		if(studentDao.insertStudent(stu)!=0 && loginDao.insertLogin(login)!=0)
			return true;
		return false;
	}

	@Override
	public boolean deleteStudent(int sno) {
		if(studentDao.deleteStudent(sno)!=0)
			return true;
		return false;
	}

	@Override
	public boolean updateStudent(Student stu) {
		if(studentDao.updateStudent(stu)!=0)
			return true;
		return false;
	}

	@Override
	public List<Integer> getAllSno() {
		// TODO Auto-generated method stub
		return studentDao.selectAllSno();
	}

	@Override
	public Student getOneStudent(int sno) {
		// TODO Auto-generated method stub
		return studentDao.getStudentByID(sno);
	}

}
