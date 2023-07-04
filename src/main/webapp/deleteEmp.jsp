<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<body>
	<%
	int empId = Integer.parseInt(request.getParameter("empId"));
	 String jdbcUrl = "jdbc:mysql://localhost:3306/my_db";
     String username = "root";
     String password = "admin";
	try {
		Class.forName("com.mysql.jdbc.Driver");  
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
		String sql = "delete from empskills where employeeId=?";
		String sql1 = "delete from employee where employeeId=?";

		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setInt(1, empId);
		ps.executeUpdate();
		PreparedStatement ps1 = connection.prepareStatement(sql1);
		ps1.setInt(1, empId);
		ps1.executeUpdate();
		response.sendRedirect("viewAll.jsp");
		connection.close();

	} catch (Exception e) {
		e.printStackTrace();
	} 
	%>


</body>
</html>