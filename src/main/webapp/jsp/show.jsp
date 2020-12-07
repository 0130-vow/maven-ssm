<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>show</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
	<script src="js/jquery-3.0.0.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

  </head>
  <style type="text/css">
		* {	margin: 0, padding: 0;}
		#box {
			width: 1000px;
			height: 200px;
		}
		.center-in-center {
			position: absolute;
			top: 20%;
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
  			$.ajax({
  				type: 'get',
  				url: '/maven-ssm/newShow',
  				dataType: 'json',
  				contentType: 'application/json',
  				async: true,
  				success: function(data) {
  					var json = $.parseJSON(data);
  					if(json.code == 0) {
  						//console.log(json.stus);
  						for(var per in json.stus) {
  							var stu = json.stus[per];
  							var sname = stu.sname? stu.sname: '';
  							var project = stu.project? stu.project: '';
  							var score = stu.score? stu.score: '';
  							var trs = $("<tr>" + 
  				  					"<td>" + stu.sno + "</td>" +
  				  					"<td>" + sname + "</td>" +
  				  					"<td>" + project + "</td>" +
  				  					"<td>" + score + "</td>" +
  				  					"</tr>")
  				  			$('#table').append(trs);
  						}
  					}
  				}
  			});
  		});
  		
  		function reback() {
			history.back();
		}
  </script>
  
  <!-- <style>
  	td{
  		width:100px;
  	}
  	table{text-align:center}
  </style> -->
  <body>
  
  	<div id="box" class="center-in-center">
  		<div class="panel panel-warning">
			<div class="panel-heading">
				<h3 class="panel-title">Student SHOW</h3>
			</div>
			<div class="panel-body">
				<table id="table" class="table table-condensed">
					<thead>
						<tr>
							<th>学号</th>
							<th>姓名</th>
							<th>科目</th>
							<th>分数</th>
						</tr>
					</thead>
					<tbody>
						<!-- <tr>
							<td>Tanmay</td>
							<td>Bangalore</td>
							<td>560001</td>
							<td>560001</td>
						</tr> -->
					</tbody>
				</table>
				<button type="button" class="btn btn-default pull-right" onclick="reback()">返回</button>
				<!-- <a href="#" class="pull-right">返回</a> -->
			</div>
		</div>
  	</div>
  
  
  <%-- <h2>Student Info</h2>
  <table border="1">
  	<tr>
  		<td>sno</td>
  		<td>sname</td>
  		<td>score</td>
  		<td>project</td>
  	</tr>
    <c:forEach items="${stus}" var="stu">
    	<tr>
    		<td>${stu.sno}</td>
    		<td>${stu.sname}</td>
    		<td>${stu.score}</td>
    		<td>${stu.project}</td>
    	</tr>
    </c:forEach>
  </table>
  <a href="javascript:history.back()"> 返回 </a> --%>
  </body>
</html>
