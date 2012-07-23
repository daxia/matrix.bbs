<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*" import="java.util.*"%>
<%
	//获取session,这个在判断用户的时候很有用
	String admin = (String) session.getAttribute("admin");
	if (admin != null && admin.equals("true")) {
		login = true;
	}
%>

<%!String str = "";
	boolean login = false;

	/**
	 *tree 对帖子的排列展示	树形结构的展示
	 *@id：
	 *@level:整个帖子的树的层次
	 */

	private void tree(Connection conn, int id, int level) {
		Statement stmt = null;
		ResultSet rs = null;
		String preStr = "";
		//对层次加 ----
		for (int i = 0; i < level; i++) {
			preStr += "----";
		}
		try {
			stmt = conn.createStatement();

			String sql = "select * from article where pid=" + id;
			rs = stmt.executeQuery(sql);

			String strlogin = "";
			while (rs.next()) {
				if (login) {
					strlogin = "<td><a href='DeletePost.jsp?id=" + rs.getInt("id") + "&pid="
							+ rs.getInt("pid") + "'>删除</a></td>";
				}

				str += "<tr><td>" + rs.getInt("id") + "</td><td>" + preStr
						+ "<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>"
						+ rs.getString("title") + "</a></td>" + strlogin + "</tr>";

				if (rs.getInt("isleaf") != 0) {
					tree(conn, rs.getInt("id"), level + 1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}%>

<%
	Class.forName("com.mysql.jdbc.Driver"); //Class中c要大写

	String url = "jdbc:mysql://localhost:3306/bbs";
	String user = "root";
	String password = "root";
	Connection conn = DriverManager.getConnection(url, user, password);

	Statement stmt = conn.createStatement();

	ResultSet rs = stmt.executeQuery("select * from article where pid = 0");
	String strlogin = "";
	while (rs.next()) {

		if (login) {
			strlogin = "<td><a href='DeletePost.jsp?id=" + rs.getInt("id") + "&pid="
					+ rs.getInt("pid") + "'>删除</a></td>";
		}

		str += "<tr><td>" + rs.getInt("id") + "</td><td>"
				+ "<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>"
				+ rs.getString("title") + "</a></td>" + strlogin + "</td></tr>";

		if (rs.getInt("isleaf") != 0) {
			tree(conn, rs.getInt("id"), 1);
		}
	} 
	
	rs.close();
	stmt.close();
	conn.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

.a1 {
	margin: 0 auto;
	width: 500px;
}

.a2 {
	text-align: right;
	width: 70%;
}

.a3 {
	text-align: left;
}

<%--
body {
	background-color: #ccc;
	text-align: center;
}
--%>
</style>

</head>
<body>
	<div class="a2">
		<a href="login.jsp">登陆</a>
	</div>

	<div class="a1">

		<div class="a3">
			<a href="AddPost.jsp">发表新帖</a>
		</div>

		<table border="1">
			<%=str%>
			<%
				str = "";
				login = false;
			%>
		</table>

	</div>
</body>

</html>