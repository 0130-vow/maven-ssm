<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.naming.*"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>My first DB</title>
</head>

<body>

	<h1>
		<%
			try {
				//加载驱动
				Class.forName("com.mysql.jdbc.Driver");
				//建立连接 注：下面的test为数据库名字，root为mysql用户名 123456 为root的密码
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "loral", "loral123");
				//创建状态
				Statement state = con.createStatement();
				//插入
				//String sql="insert into student values('id','age'),('2','20')";
				//state.executeUpdate(sql);
				//更新
				//String sql1="update student set id='001' where name='liu'";
				// state.executeUpdate(sql1);
				//修改
				//String sql3="update student set name='liu' where id='2'";
				//state.executeUpdate(sql3);
				//查询
				//String sql2="select id,name from student where id='1'";

				String sql2 = "select * from student";
				ResultSet rs = state.executeQuery(sql2);
				while (rs.next()) {
					String id = rs.getString("id");
					String name = rs.getString("name");

					out.println("id:" + id + " " + "name:" + name + "<br>");
				}
				out.println("success..." + "<br>");
				state.close();
				con.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		%>

	</h1>

</body>

</html>