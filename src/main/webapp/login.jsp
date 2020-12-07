<%@ page language = "java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
	<head>
		<title>login</title>
		<link rel="stylesheet" href="css/bootstrap.min.css">
		<script type="text/javascript" src="js/jquery-3.0.0.min.js"></script>
		<script type="text/javascript" src="js/jquery.md5.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript">
		
			$(document).ready(function() {
				console.log(sessionStorage)
				account = sessionStorage.getItem('account');
				//password = sessionStorage.getItem('password');
				if(account != null) {
					$('#account').val(account);
				}
				/* if(password != null) {
					$('#password').val(password);
				} */
			});
		
			function login() {
				var account = $('#account').val();
				var password = $('#password').val();
				if(account.trim() == '' || password.trim() == '') {
					$('#msg').html('账户或密码不能为空！');
					return;
				}
				$.ajax({
					type: 'get',
					url: '/maven-ssm/userLogin?account='+account+'&passwd='+$.md5(password),
					dataType: 'json',
					async: true,
					success: function(data) {
						if(data == 'null') {
							$('#msg').html('账户或密码错误！');
						}else {
							var student = JSON.parse(data)
							console.log(student);
							sessionStorage.setItem('account', account);
							//sessionStorage.setItem('password', password);
							sessionStorage.setItem('sname', student.sname);
							sessionStorage.setItem('sno', student.sno);
							window.location.href = '/maven-ssm/index';
						}
					}
				});
			}
			
			function clearmessage() {
				$('#msg').html('');
			}
			
			function forgetPw() {
				alert('please contact Administrator!')
			}
			
			function checkpasswd() {
				if($('#password').val().trim() == '') {
					$('#password').val('')
				} 
			}
			
			/* function checkForm() {
				var form = document.getElementById('form');
				var account = document.getElementById('inputAccount').value;
				alert(account)
				var password = document.getElementById('inputPassword').value;
				alert(account)
				var xmlhttp;
				if(window.XMLHttpRequest) {
					//code for IE7+, Firefox, Chrome, Opera, Safari
				  	xmlhttp=new XMLHttpRequest();
				}
				xmlhttp.onreadystatechage = function() {
					console.log(xmlhttp.readyState)
					console.log(xmlhttp.status)
					if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						var result = xmlhttp.responseText
						document.getElementById("myDiv").innerHTML="sdsdsdsdsdsds";
					}
				}
				xmlhttp.open("GET","/maven-ssm/userLogin?account="+account+"&passwd="+password, false);
				xmlhttp.send();
			} */
	</script>
	</head>
	
	<body>
		<div class="container" style="margin:50 auto">
		   <div class="jumbotron">
		        <h1>欢迎登陆Student CURD</h1>
		        <p>This is just a student crud test. Please login</p>
		        <p>
		        	<form:form id="form" class="form-horizontal" role="form" style="width:400px" >
					  <div class="form-group">
					    <label class="col-sm-2 control-label">账户</label>
					    <div class="col-sm-10">
					      <input type="account" name="account" class="form-control" onfocus="clearmessage()" id="account" placeholder="请输入账户">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="inputPassword" class="col-sm-2 control-label">密码</label>
					    <div class="col-sm-10">
					      <input type="password" name="passwd" class="form-control" onkeyup="checkpasswd()" onfocus="clearmessage()" id="password" placeholder="请输入密码">
					    </div>
					  </div>
					  <div class="form-group has-error">
					    <div class="col-sm-offset-2 col-sm-12">
					      <span id="msg" class="help-block"></span>
					      <button type="button" class="btn btn-primary" onclick="login()">登录</button>
					      <button type="reset" class="btn btn-default">重置</button>
					      <a href="javascript:forgetPw()" class="col-sm-offset-4">忘记密码</a>
					    </div>
					  </div>
					</form:form>
		        </p>
		   </div>
		</div>
	</body>
	
</html>





