<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:useBean id="command" class="org.gan.model.Student" scope="request" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <meta charset="utf-8"> 
    <title>add Student</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
	<script src="../js/jquery-3.0.0.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<style type="text/css">
		* {	margin: 0, padding: 0;}
		#box {
			width: 500px;
			height: 350px;
		}
		.center-in-center {
			position: absolute;
			top: 40%;
			left: 50%;
			-webkit-transform: translate(-50%, -50%);
			-moz-transform: translate(-50%, -50%);
			-ms-transform: translate(-50%, -50%);
			-o-transform: translate(-50%, -50%);
			transform: translate(-50%, -50%);
		}
	</style>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('#myAlert').hide();			
			$("#myAlert").bind('closed.bs.alert', function () {
				$(':input','#form')  
				 .not(':button, :submit, :reset, :hidden')  
				 .val('')  
				 .removeAttr('checked')  
				 .removeAttr('selected');
			});
		});
	
		function reback() {
			history.back();
		}
		function addsubmit() {
			$('#myAlert').hide();
			if($('#sno').val().trim() == '' || $('#sname').val().trim() == '') {
				$('#msg').html('请填写必填项！');
				return;
			}
			var data = {}
			var values = $('#form').serializeArray();
			$.each(values, function() {
				data[this.name] = this.value;
			});
			//console.log(data);
			//console.log(JSON.stringify(data))
			$.ajax({
				type: 'post',
				url: '/maven-ssm/newAdd',
				dataType: 'json',
				contentType: 'application/json',
				data: JSON.stringify(data),
				async: true,
				success: function(data) {
					var jsondata = $.parseJSON(data);
					if(jsondata.code == 1) {
						$('#msg').html('该学号已有');
					}else {
						$('#sucmsg').html('已添加学号：'+ jsondata.stu.sno + ' 姓名：' + jsondata.stu.sname)
						$('#myAlert').show();
					}
				}
			});
		}
		
		function clearmessage(){
			$('#msg').html('');
			$('#myAlert').hide();
		}
	</script>
  </head>
  <body>
  
  	<div id="box" class="center-in-center">
  		<div class="panel panel-success">
			<div class="panel-heading">
				<h3 class="panel-title">Student ADD</h3>
			</div>
			<div class="panel-body" style="height: 100%">
				<form id="form" class="form-horizontal" role="form" style="width:400px" >
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label"><em style="color: red;">*&nbsp;&nbsp;</em>学号</label>
				    <div class="col-sm-10">
				      <input type="text" name="sno" class="form-control" onfocus="clearmessage()" id="sno" onkeyup="this.value=this.value.replace(/\D/g,'')">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label"><em style="color: red;">*&nbsp;&nbsp;</em>姓名</label>
				    <div class="col-sm-10">
				      <input type="text" name="sname" class="form-control" onfocus="clearmessage()" id="sname" >
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">科目</label>
				    <div class="col-sm-10">
				      <input type="text" name="project" class="form-control" onfocus="clearmessage()" id="project" >
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">分数</label>
				    <div class="col-sm-10">
				      <input type="text" name="score" class="form-control" onfocus="clearmessage()" id="score" onkeyup="value=value.replace(/[^\d.]/g,'')">
				    </div>
				  </div>
				  <div id="myAlert" class="alert alert-success">
						<a href="#" class="close" data-dismiss="alert">&times;</a>
						<strong>成功！</strong><span id="sucmsg"></span>
				  </div>
				  
				  <div class="form-group has-error">
				    <div class="col-sm-offset-2 col-sm-12">
				      <span id="msg" class="help-block"></span>
				      <button type="button" class="btn btn-defualt" onclick="addsubmit()">提交</button>
				      <button type="reset" class="btn btn-default">清空</button>
				      <button type="button" class="btn btn-default" onclick="reback()">返回</button>
				      <!-- <a href="javascript:history.back()" class="col-sm-offset-5">返回 </a> -->
				    </div>
				  </div>
				</form>
			</div>
		</div>
  	</div>
  
  
  
  
  
  
    <%-- <form:form action="/maven-ssm/add" method="post">
    	<table>
    		<tr>
    			<caption>Student ADD</caption>
    		</tr>
    		<tr>
    			<td><form:label path="sno">学号</form:label></td>
    			<td><form:input path="sno"/></td>
    		</tr>
    		<tr>
    			<td><form:label path="sname">姓名</form:label></td>
    			<td><form:input path="sname"/></td>
    		</tr>
    		<tr>
    			<td><form:label path="project">科目</form:label></td>
    			<td><form:input path="project"/></td>
    		</tr>
    		<tr>
    			<td><form:label path="score">分数</form:label></td>
    			<td><form:input path="score"/></td>
    		</tr>
    		<tr>
    			<td><input type="reset" value="reset"/></td>
    			<td><input type="submit" value="submit"/></td>
    		</tr>
    	</table>
    </form:form>
    <a href="javascript:history.back()"> 返回 </a> --%>
  </body>
</html>
