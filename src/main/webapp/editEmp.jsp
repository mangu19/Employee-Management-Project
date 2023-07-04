<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="Skills.ViewSkills"%>
<%@page import="Skills.Skills"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Record</title>


</head>
<body style="background-color: #8cc5ff;">
	<%
	int empId = Integer.parseInt(request.getParameter("empId"));
	String jdbcUrl = "jdbc:mysql://localhost:3306/my_db";
    String username = "root";
    String password = "admin";
	try {
		Class.forName("com.mysql.jdbc.Driver");  
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
		String sql = "select * from Employee where employeeId=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setInt(1, empId);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
	%>
	<%
	List<Skills> list = ViewSkills.getAllSkills();
	List<Integer> skillId = ViewSkills.getAllChecked(empId);
	%>
	
	<h1>Employee Form</h1>

    <form action="updateEmp.jsp" method="post">
        <label for="empId">EmployeeId:</label>
        <input type="text" id="empId" name="empId" value="<%=rs.getInt("employeeId")%>" readonly="readonly">
        
        <br><br>
		<label for="name">Name:</label>
        <input type="text" id="name" name="name" value="<%=rs.getString("name")%>" required>
         <br><br>
      
        <label for="address">Address:</label>
        <textarea id="address" name="address" rows="4" cols="50" maxlength="150" required><%=rs.getString("address")%></textarea>
        <br><br>

        <label>Gender:</label>
        <input type="radio" id="male" name="gender" value="0" checked>
        <label for="male">Male</label>
        <input type="radio" id="female" name="gender" value="1">
        <label for="female">Female</label>
        <br><br>

        <label>Skill Id:</label><br>
        <%
				String selected = "";
				for(int i=0;i<list.size();i++){
					Skills s=list.get(i);
					selected=ViewSkills.isSelected(s.getSkillId());
					%>
				<div class="form-check "
					style="display: inline-flex; margin-left: 10px">
					<input class="form-check-input " type="checkbox" id="gridCheck"
						value="<%=s.getSkillId() %>" name="skills" <%=selected %>> <label
						class="form-check-label mx-1" for="gridCheck"> <%=s.getSkill() %>
					</label>
				</div>

				<% 
					}
					%>
        
        <br><br>

        <label for="salary">Salary:</label>
        <input type="number" id="salary" name="salary" min="0" max="999999999" step="0.01" value="<%=rs.getDouble("salary")%>" required>
        
        <br><br>

        <input type="submit" value="Submit">
    </form>
    <%
			}connection.close();
			} catch (Exception exception) {
			exception.printStackTrace();
			}
			
			%>
			</body>
			</html>