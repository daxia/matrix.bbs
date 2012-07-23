<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>注册</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	margin: 0
}

.two {
	margin: 10px auto 0 auto;
	border: 1px solid red;
	width: 400px;
	height: 200px;
}

.font {
	font-size: 18;
}
</style>

</head>

<body>
	<!--  
	<% 
	/**
	ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			//new oracle.jdbc.driver.OracleDriver();
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "root");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from news");
			while(rs.next()) {
				out.println(rs.getString("title"));
				out.println(rs.getString("content"));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {
					rs.close();
					rs = null;
				}
				if(stmt != null) {
					stmt.close();
					stmt = null;
				}
				if(conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			*/
			%>
			-->
	<div class="two" align="center">
		<form class="font">
			<table>
				<tr>
					<td>用户名 ：</td>
					<td><input type="text" name="user"></input></td>
				</tr>
				<tr>
					<td>密码 ：</td>
					<td><input type="text" name="password"></input>
					</td>
				</tr>
				<tr>
					<td>确认密码 ：</td>
					<td><input type="text" name="confirmpwd"></input>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" value="提交"></input> <input
						type="button" value="取消"></input>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<br>
</body>
</html>
