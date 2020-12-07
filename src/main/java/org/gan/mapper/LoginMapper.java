package org.gan.mapper;

import org.apache.ibatis.annotations.Param;
import org.gan.model.Login;
import org.gan.model.Student;

public interface LoginMapper {
	
	public Student getStudentByLogin(@Param("account")String account, @Param("password")String password);

	public int changePassword(@Param("sno")String sno, @Param("password")String password, @Param("newpassword")String newpassword);
	
	public int insertLogin(Login login);
}
