<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>My JSP 'index.jsp' starting page</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
	<script src="../js/jquery-3.0.0.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
  </head>
  <style type="text/css">
		* {	margin: 0, padding: 0;}
		#box {
			width: 1000px;
			height: 200px;
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
   	   $(function() {
   		$('#myAlert').hide();
   		$("#myAlert").bind('closed.bs.alert', function () {
   			$('#sno').val('');
		});
   	   })
   	
	   function reback() {
			history.back();
		}
	   
	   function deletesubmit() {
		   $('#myAlert').hide();
		   var sno = $('#sno').val();
		   if(sno == '') {
			   $('#msg').html('请先填写要删除学号！');
			   return;
		   }
		   $.ajax({
			   type: 'delete',
			   url: '/maven-ssm/newDelete?sno=' + sno,
			   dataType: 'json',
			   contentType: 'application/json',
			   async: true,
			   success: function(data) {
				   var json = $.parseJSON(data);
				   if(json.code == 0) {
					  $('#sucmsg').html('学号' + sno + '已删除！')
					  $('#myAlert').show();
				   }else {
					   $('#msg').html('删除失败！未找到学号 ' + sno);
				   }
			   }
		   });
	   }
	   
	   function clearmessage(){
			$('#msg').html('');
			$('#myAlert').hide();
		}
   </script>
  
  <body>
  
  	<div id="box" class="center-in-center">
  		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Student DELETE</h3>
			</div>
			<div class="panel-body" style="height: 100%">
				<form id="form" class="form-horizontal" role="form" style="width:400px" >
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label"><em style="color: red;">*&nbsp;&nbsp;</em>学号</label>
				    <div class="col-sm-10">
				      <input type="text" name="sno" class="form-control" onfocus="clearmessage()" id="sno" onkeyup="this.value=this.value.replace(/\D/g,'')">
				    </div>
				  </div>
				  <div id="myAlert" class="alert alert-info">
						<a href="#" class="close" data-dismiss="alert">&times;</a>
						<strong>成功！</strong><span id="sucmsg">删除成功</span>
				  </div>
				  
				  <div class="form-group has-error">
				    <div class="col-sm-offset-2 col-sm-12">
				      <span id="msg" class="help-block"></span>
				      <button type="button" class="btn btn-primary" onclick="deletesubmit()">提交</button>
				      <button type="reset" class="btn btn-default">清空</button>
				      <button type="button" class="btn btn-default" onclick="reback()">返回</button>
				    </div>
				  </div>
				</form>
			</div>
		</div>
  	</div>
  	
  
  
  
  
    <%-- <form:form action="/maven-ssm/delete" method="post">
    	<label>请输入学号</label>
    	<input name="sno"/>
    	<input type="submit" value="submit"/>
    </form:form>
    <a href="javascript:history.back()"> 返回 </a> --%>
  </body>
</html>
