<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	String strId = request.getParameter("id");
	int id = Integer.parseInt(strId);

	Class.forName("com.mysql.jdbc.Driver"); //Class中c要大写

	String url = "jdbc:mysql://localhost:3306/bbs";
	String user = "root";
	String password = "root";
	Connection conn = DriverManager.getConnection(url, user, password);

	Statement stmt = conn.createStatement();

	ResultSet rs = stmt
			.executeQuery("select * from article where id = " + id);
	String str = "";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (rs.next()) {
	%>
	<table border="1">
		<tr>
			<td>ID</td>
			<td><%=rs.getInt("id")%></td>
		</tr>
		<tr>
			<td>Title</td>
			<td><%=rs.getString("title")%></td>
		</tr>
		<tr>
			<td>Content</td>
			<td><%=rs.getString("cont")%></td>
		</tr>
	</table>
	<a
		href="Reply.jsp?id=<%=rs.getInt("id")%>&rootid=<%=rs.getInt("rootid")%>">回复</a>
	<a href="ShowArticleTree.jsp">返回主题首页</a>
	<%
		}
		rs.close();
		stmt.close();
		conn.close();
	%>
</body>
</html>