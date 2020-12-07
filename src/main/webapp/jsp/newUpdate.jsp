<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:useBean id="command" class="org.gan.model.Student" scope="request" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <meta charset="utf-8"> 
    <title>udpate Student</title>
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
		var studentmaps = new Map();
		$(document).ready(function() {
			$('#myAlert').hide();
			$.ajax({
  				type: 'get',
  				url: '/maven-ssm/newShow',
  				dataType: 'json',
  				contentType: 'application/json',
  				async: true,
  				success: function(data) {
  					var json = $.parseJSON(data);
  					if(json.code == 0) {
  						for(var per in json.stus) {
  							var sno = json.stus[per].sno;
  							$('#select').append($("<option>" + sno + "</option>"));
  							studentmaps.set(sno+'', json.stus[per]);
  						}
  						$('#sname').val(json.stus[0].sname);
  						$('#project').val(json.stus[0].project);
  						$('#score').val(json.stus[0].score);
  					}
  				}
  			});
			
			/* $("#myAlert").bind('closed.bs.alert', function () {
				$(':input','#form')  
				 .not(':button, :submit, :reset, :hidden')  
				 .val('')  
				 .removeAttr('checked')  
				 .removeAttr('selected');
			}); */
		});
	
		function reback() {
			history.back();
		}
		function updatesubmit() {
			$('#myAlert').hide();
			if($('#sname').val().trim() == '') {
				$('#msg').html('请填写姓名！');
				return;
			}
			var sno = $('#select').val();
			var params = {};
			params['sno'] = sno;
			var values = $('#form').serializeArray();
			$.each(values, function() {
				params[this.name] = this.value;
			});
			var oldstu = studentmaps.get(sno);
			if(oldstu.sname == params.sname && oldstu.project == params.project && oldstu.score == params.score) {
				$('#msg').html('未修改！');
				return;
			}
			$.ajax({
				type: 'post',
				url: '/maven-ssm/newUpdate',
				dataType: 'json',
				contentType: 'application/json',
				data: JSON.stringify(params),
				async: true,
				success: function(data) {
					var jsondata = $.parseJSON(data);
					if(jsondata.code == 1) {
						$('#msg').html('修改失败');
					}else {
						$('#sucmsg').html('已修改学号：'+ sno);
						studentmaps.set(sno, params);
						$('#myAlert').show();
					}
				}
			});
		}
		
		function clearmessage(){
			$('#msg').html('');
			$('#myAlert').hide();
		}
		
		function selectChange(){
			$('#myAlert').hide();
  			var v_sno=$('#select').val();
  			$('#msg').html('');
  			var stu = studentmaps.get(v_sno);
  			$('#sname').val(stu.sname);
			$('#project').val(stu.project);
			$('#score').val(stu.score);
  		}
	</script>
  </head>
  <body>
  
  	<div id="box" class="center-in-center">
  		<div class="panel panel-danger">
			<div class="panel-heading">
				<h3 class="panel-title">Student UPDATE</h3>
			</div>
			<div class="panel-body" style="height: 100%">
				<form id="form" class="form-horizontal" role="form" style="width:400px" >
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">学号</label>
				    <div class="col-sm-10">
				      <select id="select" class="form-control" onchange="selectChange()">
						<!-- <option>1</option>
						<option>2</option> -->
					 </select>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">姓名</label>
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
				      <button type="button" class="btn btn-defualt" onclick="updatesubmit()">提交</button>
				      <button type="button" class="btn btn-default" onclick="reback()">返回</button>
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
