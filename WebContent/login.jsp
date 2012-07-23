<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 简单的管理员登陆，没有连接数据库 -->
<%
	String action = request.getParameter("action");
	if (action != null && action.equals("login")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
%>
<div align="center">
	<font color="red"> <%
 	if (username == null || !username.equals("admin")) {
 			out.println("username not correct");
 		}
 		//return;
 		else if (username == null || !password.equals("admin")) {
 			out.println("password not correct");
 		}
 		//return;
 		else {
 		session.setAttribute("admin", "true");
 		response.sendRedirect("ShowArticleTree.jsp");
// 			out.println("Welcome ! admin");
 		}
 	}
 %> </font>
</div>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2 align="center">后台登陆</h2>
	<form action="login.jsp" method="post">
		<input type="hidden" name="action" value="login" />
		<table align="center">
			<tr>
				<td>用户名</td>
				<td><input type="text" name="username" /></td>
			</tr>
			<tr>
				<td>密码</td>
				<td><input type="text" name="password" />
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="登陆" />
			</tr>
		</table>
	</form>
</body>
</html>