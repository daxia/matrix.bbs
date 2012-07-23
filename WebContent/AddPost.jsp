<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	/* 发表新帖主题  */

	request.setCharacterEncoding("utf-8"); //数据提交过来的时候是按照iso-8859-1编码格式提交的，需要改为utf-8
	String action = request.getParameter("action");

	if (action != null && action.equals("post")) {

		//获取url的 传参title,content

		String title = request.getParameter("title");
		String content = request.getParameter("content");

		content = content.replaceAll("\n", "<br>");

		//链接数据库
		Class.forName("com.mysql.jdbc.Driver"); //Class中c要大写

		String url = "jdbc:mysql://localhost:3306/bbs";
		String user = "root";
		String password = "root";
		Connection conn = DriverManager.getConnection(url, user, password);

		//transaction
		conn.setAutoCommit(false);

		String sql = "insert into article values(null, 0, ?, ?, ?, now(), 0)"; //0是叶子结点
		//String sql = "insert into article values(null, 0, ?, ?, ?, now(), 0)";
		//插入数据
		PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		Statement stmt = conn.createStatement();

		ps.setInt(1, -1);
		ps.setString(2, title);
		ps.setString(3, content);
		ps.executeUpdate();

		// 算出rootid，并更新进数据库中 
		ResultSet rsKey = ps.getGeneratedKeys(); //获取执行生成的id Keys
		rsKey.next();
		int key = rsKey.getInt(1);
		rsKey.close();

		String keySql = "update article set rootid = " + key + " where id = " + key;

		out.println(keySql);
		stmt.executeUpdate(keySql);

		conn.commit();
		conn.setAutoCommit(true);

		stmt.close();
		ps.close();
		conn.close();

		response.sendRedirect("ShowArticleTree.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>新帖：</h3>
	<form action="AddPost.jsp" method="post">
		<input type="hidden" name="action" value="post">
		<table>
			<tr>
				<td>标题：</td>
				<td><input type="text" name="title"></input>
				</td>

			</tr>
			<tr>
				<td>内容：</td>
				<td><textarea rows="5" cols="20" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="提交" /> <input type="button"
					value="取消" /></td>

			</tr>
		</table>
	</form>

</body>
</html>