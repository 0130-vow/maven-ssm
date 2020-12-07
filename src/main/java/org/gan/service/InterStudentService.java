package org.gan.service;

import java.util.List;

import org.gan.model.Student;

public interface InterStudentService {

	public List<Student> showStudentList();
	
	public boolean checkID(int sno);
	
	public Student getOneStudent(int sno);
	
	public boolean addStudent(Student stu);
	
	public boolean deleteStudent(int sno);
	
	public boolean updateStudent(Student stu);
	
	public List<Integer> getAllSno();
}
