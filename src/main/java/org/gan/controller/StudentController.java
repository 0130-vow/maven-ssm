package org.gan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.gan.model.Student;
import org.gan.service.InterStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;

@Controller
public class StudentController {

	@Autowired(required=true)
	private InterStudentService service;
	
	@RequestMapping(value="/test",method=RequestMethod.GET)
	@ResponseBody
	public String test(@RequestParam("sno")Integer sno) {
		Map<String, String> map = new HashMap<String, String>();
		if(sno == null) {
			map.put("code", "1");
			map.put("status", "請求失敗！");
			return JSONObject.toJSONString(map);
		}
		map.put("code", "0");
		map.put("status", "請求成功！");
		map.put("name", "test");
		map.put("age", "18");
		return JSONObject.toJSONString(map);
	}
	
	@RequestMapping(value="/test2",method=RequestMethod.GET)
	@ResponseBody
	public String test2(@RequestBody String name){
		return "your responseBody is "+ name;
	}
	
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String index(){
		return "index";
	}
	
	/*@RequestMapping(value="/add",method=RequestMethod.GET)
	public String addPage(){
		return "add";
	}*/
	/*@RequestMapping(value="/delete",method=RequestMethod.GET)
	public String deletePage(){
		return "delete";
	}*/
	/*@RequestMapping(value="/add",method=RequestMethod.GET)
	public ModelAndView addPage(){
		Student stu=new Student();
		ModelAndView modelAndView=new ModelAndView("add","command",stu);
		return modelAndView;
	}*/
	
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public String deletePage(Model model){
		Student student =new Student();
		Map<Integer,String> snoList=new HashMap<Integer,String>();
		List<Integer> list=service.getAllSno();
		for(int i=0;i<list.size();i++){
			snoList.put(list.get(i),list.get(i)+"");
		}
		model.addAttribute("stu", student);
		model.addAttribute("snoList",snoList);
		return "update";
	}
	
	
	/**
	 * @ newadd
	 * @return
	 */
	@RequestMapping(value="/newAdd",method=RequestMethod.POST)
	@ResponseBody
	public String newAdd(@RequestBody Student stu){		
		Map<String, Object> result = new HashMap<String, Object>();
		int code = 0;
		String status = "success";
		String message = "inserted student:" + stu.getSno();
		if(service.checkID(stu.getSno())){
			code = 1;
			status = "failure";
			message = stu.getSno()+" has already existed!";
		}else{
			service.addStudent(stu);
		}
		result.put("code", code);
		result.put("staus", status);
		result.put("message", message);
		result.put("stu", stu);
		return JSONObject.toJSONString(result);
	}
	
	/**
	 * @ add
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(@ModelAttribute("stu")Student stu,Model model){		
		if(service.checkID(stu.getSno())){
			model.addAttribute("message",stu.getSno()+"学号已有，添加失败！");
		}else{
			service.addStudent(stu);
			model.addAttribute("message",stu.getSno()+"添加成功！");
		}
		return "message";
	}

	/**
	 * @ update
	 * @return
	 */
	@RequestMapping(value="/updateDeal",method=RequestMethod.POST)
	public String update(@ModelAttribute("stu")Student stu,Model model){
		System.out.println(stu);
		if(service.updateStudent(stu))
			model.addAttribute("message",stu.getSno()+"修改成功！");
		else
			model.addAttribute("message",stu.getSno()+"修改失败！");
		return "message";
	}
	
	@RequestMapping(value="/newUpdate",method=RequestMethod.POST)
	@ResponseBody
	public String newUpdate(@RequestBody Student stu){
		Map<String, Object> result = new HashMap<String, Object>();
		if(service.updateStudent(stu)) {
			result.put("code", 0);
			result.put("status", "update sucess!");
			//model.addAttribute("message",stu.getSno()+"修改成功！");
		}else {
			result.put("code", 1);
			result.put("status", "update failure!");
			//model.addAttribute("message",stu.getSno()+"修改失败！");
		}
		return JSONObject.toJSONString(result);
	}
	
	/**
	 * @param delete
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String getOneStudent(@RequestParam("sno")int sno,Model model){
		if(service.checkID(sno)){
			service.deleteStudent(sno);
			model.addAttribute("message",sno+"删除成功！");
		}else{
			model.addAttribute("message",sno+"没有该学号，删除失败！");
		}
		return "message";
		
	}
	
	@RequestMapping(value="/newDelete",method=RequestMethod.DELETE)
	@ResponseBody
	public String newDelete(@RequestParam("sno")String sno){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("staus", "delete success!");
		Pattern pattern = Pattern.compile("[0-9]*"); 
        Matcher isNum = pattern.matcher(sno);
		if(isNum.matches()&& service.checkID(Integer.parseInt(sno))){
			service.deleteStudent(Integer.parseInt(sno));
			//model.addAttribute("message",sno+"删除成功！");
		}else{
			result.put("code", 1);
    		result.put("staus", "delete failure!");
			//model.addAttribute("message",sno+"没有该学号，删除失败！");
		}
		return JSONObject.toJSONString(result);
		
	}
	
	/*@ResponseBody   加这个返回 了String字符串到界面*/
	@RequestMapping(value="/show",method=RequestMethod.GET)
	public String getAllStudent(Model model){
		List<Student> stus=service.showStudentList();
		model.addAttribute("stus",stus);
		System.out.println(stus);
		return "show";
	}
	
	@RequestMapping(value="/newShow",method=RequestMethod.GET, produces="application/json;charset=utf-8")
	@ResponseBody
	public String newShow(){
		Map<String, Object> result = new HashMap<String, Object>();
		List<Student> stus=service.showStudentList();
		int code = 0;
		String status = "success";
		result.put("stus",stus);
		result.put("code", code);
		result.put("staus", status);
		System.out.println(stus);
		return JSONObject.toJSONString(result);
	}
	
	
	@RequestMapping(value="/studentSelect",method=RequestMethod.POST)
	@ResponseBody
	public Student selectStudent(@RequestParam("sno")int sno){
		Student student=service.getOneStudent(sno);
		System.out.println(student);
		return student;
	}
	
	/*@ModelAttribute("snoList")
	public Map<String,String> getAllSno(){
		Map<String,String> snoList=new HashMap<String,String>();
		List<Integer> list=service.getAllSno();
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i));
			snoList.put(String.valueOf(list.get(i)),list.get(i)+"1");
		}
		Set<String> set=snoList.keySet();
		Iterator<String> iterator=set.iterator();
		while (iterator.hasNext()) {
		String key = (String) iterator.next();
		System.out.println(key+" "+snoList.get(key));
		}
		return snoList;
	}*/
		
}





