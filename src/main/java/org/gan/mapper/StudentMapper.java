package org.gan.mapper;

import java.util.List;

import org.gan.model.Student;

public interface StudentMapper {

	public List<Student> getAllStudent();
	
	public Student getStudentByID(int sno);
	
	public int insertStudent(Student stu);
	
	public int deleteStudent(int sno);
	
	public int updateStudent(Student stu);
	
	public List<Integer> selectAllSno();
}
