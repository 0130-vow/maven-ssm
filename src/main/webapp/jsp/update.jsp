<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%-- <jsp:useBean id="command" class="com.gan.model.Student" scope="request" /> --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>   
    <title>add Student</title>
  </head>
  <script src="/maven-ssm/js/jquery-3.0.0.min.js"></script>
  <script src="/maven-ssm/js/bootstrap.min.js"></script>
  <script>
  	$(function(){
  	
  	var value=$("#studentSelect").val()
  	getValue(value)
  	

  		$("#studentSelect").change(function(){
  			var v_sno=$(this).val()
  			getValue(v_sno)
  		})
  	})
  	
  	function getValue(stuNo){
  		$.post("studentSelect",
  			 {
  			 	sno:stuNo
  			 },
  			 function(data){
  			 	$("#name").val(data.sname)
  			 	$("#project").val(data.project)
  			 	$("#marks").val(data.score)  			 	
  			 })
  	}
  	
  </script>
  <body>
    <form:form action="/maven-ssm/updateDeal" modelAttribute="stu" method="post">
    	<table>
    		<tr>
    			<caption>Student Update</caption>
    		</tr>
    		<tr>
    			<td><form:label path="sno">学号</form:label></td>
    			<td>
					<form:select path="sno" id="studentSelect">
						<form:options path="sno" items="${snoList}"/>
					</form:select>
				</td>
    		</tr>
    		<tr>
    			<td><form:label path="sname">姓名</form:label></td>
    			<td><form:input path="sname" id="name"/></td>
    		</tr>
    		<tr>
    			<td><form:label path="project">科目</form:label></td>
    			<td><form:input path="project" id="project"/></td>
    		</tr>
    		<tr>
    			<td><form:label path="score">分数</form:label></td>
    			<td><form:input path="score" id="marks"/></td>
    		</tr>
    		<tr>
    			<td><input type="reset" value="reset"/></td>
    			<td><input type="submit" value="submit"/></td>
    		</tr>
    	</table>
    </form:form>
    <a href="javascript:history.back()"> 返回 </a>
  </body>
</html>
