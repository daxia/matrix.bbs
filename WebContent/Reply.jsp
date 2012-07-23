<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	//获取url的 传参id, rootid
	int id = Integer.parseInt(request.getParameter("id"));
	int rootid = Integer.parseInt(request.getParameter("rootid"));

	//链接数据库
	Class.forName("com.mysql.jdbc.Driver"); //Class中c要大写

	String url = "jdbc:mysql://localhost:3306/bbs";
	String user = "root";
	String password = "root";
	Connection conn = DriverManager.getConnection(url, user, password);

	Statement stmt = conn.createStatement();

	ResultSet rs = stmt
			.executeQuery("select * from article where id = " + id
					+ " and rootid = " + rootid);
	String str = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>
		回帖：(主题：
		<%-- <%=rs.getString("title") %> --%>
		)
	</h3>
	<form action="ReplyOK.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>" /> 
		<input type="hidden" name="rootid" value="<%=rootid%>" />
		<table>
			<tr>
				<td>标题：</td>
				<td><input type="text" name="title"></input></td>

			</tr>
			<tr>
				<td>内容：</td>
				<td><textarea rows="5" cols="20" name="content"></textarea></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" value="提交" /> 
					<input type="button" value="取消" />
				</td>
			</tr>
		</table>
	</form>

</body>
</html>