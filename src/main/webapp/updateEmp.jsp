<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="Skills.ViewSkills"%>
<%@page import="Skills.Skills"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<body>

	<%
	int empId = Integer.parseInt(request.getParameter("empId"));
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	double salary = Double.parseDouble(request.getParameter("salary"));
	String[] skills = request.getParameterValues("skills");
	int[] arr = new int[skills.length];
	for (int i = 0; i < skills.length; i++) {
		arr[i] = Integer.parseInt(skills[i]);
	}
	 String jdbcUrl = "jdbc:mysql://localhost:3306/my_db";
     String username = "root";
     String password = "admin";
	PreparedStatement ps = null;
	PreparedStatement ps1 = null;
	PreparedStatement ps2 = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");  
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
		String sql1 = "update employee set name=?,address=?,salary=? where employeeId=?";
		ps = connection.prepareStatement(sql1);
		ps.setString(1, name);
		ps.setString(2, address);
		ps.setDouble(3, salary);
		ps.setInt(4, empId);

		int i = ps.executeUpdate();
		String sql3 = "delete from empskills where employeeId=?";
		ps2 = connection.prepareStatement(sql3);
		ps2.setInt(1, empId);
		ps2.executeUpdate();
		String sql2 = "insert into empskills values(?,?)";
		ps1 = connection.prepareStatement(sql2);
		for (int n = 0; n < arr.length; n++) {
			ps1.setInt(1, empId);
			ps1.setInt(2, arr[n]);
			ps1.executeUpdate();
		}
		if (i == 1)
			response.sendRedirect("viewAll.jsp");
	connection.close();
	} catch (Exception e) {
		e.printStackTrace();
	} 
	%>

</body>
</html>