<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>


<%!/** 
	 *采用 递归方法删除帖子
	 *删除帖子功能!!!
	 *
	 */
	private void delete(Connection conn, int id) {

		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			stmt = conn.createStatement();
			sql = "select * from article where pid=" + id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				delete(conn, rs.getInt("id"));
			}
			stmt.executeUpdate("delete from article where id = " + id);
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
	request.setCharacterEncoding("utf-8"); //数据提交过来的时候是按照iso-8859-1编码格式提交的，需要改为utf-8

	//获取url的 传参id, pid
	int id = Integer.parseInt(request.getParameter("id"));
	int pid = Integer.parseInt(request.getParameter("pid"));

	/*连接mysql  */
	Class.forName("com.mysql.jdbc.Driver"); //Class中c要大写

	String url = "jdbc:mysql://localhost:3306/bbs";
	String user = "root";
	String password = "root";
	Connection conn = DriverManager.getConnection(url, user, password);

	//transaction
	conn.setAutoCommit(false);

	delete(conn, id);

	Statement stmt = conn.createStatement();
	/*再删除帖子后，父帖子 下是否还有字帖（与删除的帖子同级的）    */
	ResultSet rs = stmt
			.executeQuery("select count(*) from article where pid = "
					+ pid);
	rs.next();
	int count = rs.getInt(1); /* 删除帖子后，被删除帖子的父帖子下还存在的子节点的数量 */
	rs.close();
	if (count <= 0) {

		Statement stmtUpdate = conn.createStatement();
		String updateSql = "update article set isleaf = 0 where id = "
				+ pid;

		stmtUpdate.executeUpdate(updateSql);
		stmtUpdate.close();

	}

	conn.commit();
	conn.setAutoCommit(true);
	conn.close();

	response.sendRedirect("ShowArticleTree.jsp");
%>
