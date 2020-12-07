<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>SSM crud</title>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<script type="text/javascript" src="js/jquery-3.0.0.min.js"></script>
	<script type="text/javascript" src="js/jquery.md5.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('#profile').html(sessionStorage.getItem('sname'))
			console.log(sessionStorage.getItem('sname'))
			
			$('#myModal').modal('hide');
			$('#myModal').on('hide.bs.modal', function () {
				resetPassword();
				clearMessage();
			});
			
			$('#resetpw').bind("click", function(){
				document.getElementById('password').innerHtml = 'sdsd'
			});
			
			/* 鼠标悬停事件 */
			$('.inbox').hover(function() {
				$(this).css({"width":"120%","height":"350px","font-size":"300%"});
			});
			/* 鼠标离开事件 */
			$('.inbox').mouseleave(function() {
				$(this).css({"width":"100%","height":"300px","font-size":"100%"});
			});
			/* 鼠标点击事件 */
			/* $('.box').click(function() {
				$(this).removeClass("")
			}); */
			
		}); 
		
		function add() {
			window.location.href = '/maven-ssm/jsp/add.jsp';
		}
		
		function del() {
			window.location.href = '/maven-ssm/jsp/delete.jsp';
		}
		
		function update() {
			//window.location.href = '/maven-ssm/update'
			window.location.href = '/maven-ssm/jsp/newUpdate.jsp'
		}
		
		function show() {
			window.location.href = '/maven-ssm/show';
		}
		
		function pwsubmit() {
			var password = $('#password').val();
			var newpassword = $('#newpassword').val();
			var renewpassword = $('#renewpassword').val();
			if(password.trim() == '' || newpassword.trim() == '' || renewpassword.trim() == '') {
				$('#msg').html('输入不能为空！');
				return;
			}
			if(newpassword != renewpassword) {
				$('#msg').html('两次输入密码不一致！');
				return;
			}
			
			var data = {
				"sno": sessionStorage.getItem("sno"),
				"password": $.md5(password),
				"newpassword": $.md5(newpassword),
			}

			$.ajax({
				headers: {
					'Accept': 'application/json',
					'Content-Type': 'application/json'
				},
				type: 'post',
				url: '/maven-ssm/changePassword',
				dataType: 'json',
				contentTyle: 'application/json; charset=UTF-8',
				data: JSON.stringify(data),
				async: true,
				success: function(data) {
					if(data == '0') {
						$('#msg').html('修改失败，密码错误！');
					}else if(data == '1') {
						alert('修改成功');
						$('#myModal').modal('hide');
						window.location.href = '/maven-ssm';
					}
				}
			});
		}
		
		function resetPassword() {
			$('input').val('');
		}
		
		function clearMessage() {
			$('#msg').html('');
		}
		
		function getPersonInfo() {
			var sno = sessionStorage.getItem('sno');
			$.ajax({
				type: 'post',
				url: '/maven-ssm/studentSelect?sno='+sno,
				dataType: 'json',
				contentType: 'application/json',
				async: true,
				success: function(jsondata) {
					$('#myInfoBody').children().remove();
					var sname = jsondata.sname == undefined?'': jsondata.sname;
					var project = jsondata.project == undefined?'': jsondata.project;
					var score = jsondata.score == undefined?'': jsondata.score;
					$('#myInfoBody').append($("<span class='list-group-item'>学号："+ sno +"</span>"+
							"<span class='list-group-item'>姓名："+ sname +"</span>"+
							"<span class='list-group-item'>科目："+ project +"</span>"+
							"<span class='list-group-item'>分数："+ score +"</span>"));
				}
			});
		}
		
		//document.getElementById('msg').innerHtml = sessionStorage.getItem('account')
	</script>
	
	<style>
		.box{
			width: 20%;
			float: left;
			margin: 2.5%;
		}
		.inbox{
			/* width:80%; */
			height:300px;
			line-height:300px;
			text-align:center;
		}
	</style>
	
</head>
<body>
	
	<nav class="navbar navbar-default" role="navigation" style="width:80%; margin: 0px auto;">
		<div class="container-fluid"> 
	    <div class="navbar-header">
	        <span class="navbar-brand">Student CRUD</span>
	    </div>
	    <div>
	        <!--向右对齐-->
	        <ul class="nav navbar-nav navbar-right">
	            <li class="dropdown">
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                     <span id="profile"></span> <b class="caret"></b>
	                </a>
	                <ul class="dropdown-menu">
	                    <li><a data-toggle="modal" data-target="#myInfo" onclick="getPersonInfo()">个人信息</a></li>
	                    <li><a data-toggle="modal" data-target="#myModal">修改密码</a></li>
	                    <li class="divider"></li>
	                    <li><a href="<%=path %>">登出 login put</a></li>
	                </ul>
	            </li>
	        </ul>
	        <form class="navbar-form navbar-right" role="search">
	            <!-- <button type="submit" class="btn btn-default">
	                	向右对齐-提交按钮
	            </button> -->
	        </form>
	        <p class="navbar-text navbar-right">Welcome!</p>
	    </div>
		</div>
	</nav>

	<div style="width:95%; height:400px; margin:3% auto; background:white">
		<div class="panel panel-success box">
			
			<div class="panel-heading inbox" onclick="add()">
				ADD
			</div>
			
		</div>
		<div class="panel panel-info box">
			<div class="panel-heading inbox" onclick="del()">
				DELETE
			</div>
		</div>
		<div class="panel panel-danger box">
			<div class="panel-heading inbox" onclick="update()">
				UPDATE
			</div>
		</div>
		<div class="panel panel-warning box">
			<div class="panel-heading inbox" onclick="show()">
				SHOW
			</div>
		</div>
	</div>
	
	<div  style="width:100%; height:80px; position:fixed;bottom:0; background:#eee; line-height:80px; text-align:center;">
	  <p>Copyright ® 2020</p>
	</div>
	
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
					</button>
					<h4 class="modal-title" id="myModalLabel">
						修改密码
					</h4>
				</div>
				<div class="modal-body">
					<form id="form" class="form-horizontal" role="form" style="width:90%">
					  <div class="form-group">
					    <label class="col-sm-2 control-label">原始密码</label>
					    <div class="col-sm-10">
					      <input type="password" id="password" onfocus="clearMessage()" name="passwd" class="form-control" placeholder="请输入原始密码">
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label">新密码</label>
					    <div class="col-sm-10">
					      <input type="password" id="newpassword" onfocus="clearMessage()" name="newpasswd" class="form-control" placeholder="请输入新密码">
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label">再次输入</label>
					    <div class="col-sm-10">
					      <input type="password" id="renewpassword" onfocus="clearMessage()" name="renewpasswd" class="form-control" placeholder="请再次输入新密码">
					    </div>
					  </div>
					  <div class="form-group has-error">
					  	<label class="col-sm-2 control-label">&nbsp;</label>
					  	<div class="col-sm-10">
					  		<span id="msg" class="help-block"></span>
					  		<!-- <div id="myAlert" class="alert alert-success">
								<a href="#" class="close">&times;</a>
								<strong>成功！</strong>结果是成功的。
							</div> -->
					    </div>
					  </div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						关闭
					</button>
					<button id="resetpw" type="button" class="btn btn-primary" onclick="resetPassword()">
						清空
					</button>
					<button type="button" class="btn btn-primary" onclick="pwsubmit()">
						提交更改
					</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
					</button>
					<h4 class="modal-title" id="myModalLabel">
						我的信息
					</h4>
				</div>
				<div class="modal-body" id="myInfoBody">
					<!-- <span class="list-group-item">ss:&emsp;bb</span> -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						关闭
					</button>
				</div>
			</div>
		</div>
	</div>

	
</body>
</html>