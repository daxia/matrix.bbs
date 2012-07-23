<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8"); //数据提交过来的时候是按照iso-8859-1编码格式提交的，需要改为utf-8
	
	//获取url的 传参id, rootid,title,content
	int id = Integer.parseInt(request.getParameter("id"));
	int rootid = Integer.parseInt(request.getParameter("rootid"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	content = content.replaceAll("\n", "<br>");

	Class.forName("com.mysql.jdbc.Driver"); //Class中c要大写

	String url = "jdbc:mysql://localhost:3306/bbs";
	String user = "root";
	String password = "root";
	Connection conn = DriverManager.getConnection(url, user, password);

	//transaction
	conn.setAutoCommit(false);

	String sql = "insert into article value(null, ?, ?, ?, ?, now(), 0)"; //0是叶子结点

	//插入数据
	PreparedStatement ps = conn.prepareStatement(sql);
	Statement stmt = conn.createStatement();

	ps.setInt(1, id);
	ps.setInt(2, rootid);
	ps.setString(3, title);
	ps.setString(4, content);
	ps.executeUpdate();

	stmt.executeUpdate("update article set isleaf = 1 where id=" + id);

	conn.commit();
	conn.setAutoCommit(true);
	response.sendRedirect("ShowArticleTree.jsp");

	stmt.close();
	ps.close();
	conn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ReplyOk</title>
</head>
<body>
	<font color="red" size="7"> OK!</font>
</body>
</html>