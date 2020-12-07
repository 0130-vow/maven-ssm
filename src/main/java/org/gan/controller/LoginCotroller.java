package org.gan.controller;

import java.util.Map;

import org.gan.model.Student;
import org.gan.service.InterLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;

@Controller
public class LoginCotroller {
	
	@Autowired(required=true)
	private InterLoginService loginService;
	
	@RequestMapping(value="/userLogin", method = RequestMethod.GET)
	@ResponseBody
	public String userLogin(@RequestParam("account")String account, @RequestParam("passwd")String passwd) {
		Student stu = loginService.checkStudentLogin(account, passwd);
		return JSONObject.toJSONString(stu);
	}
	
	@RequestMapping(value="/changePassword", method = RequestMethod.POST)
	@ResponseBody
	public String changePassword(@RequestBody Map<String, String> jsonmap) {
		return loginService.changePassword(jsonmap);
	}

}



















