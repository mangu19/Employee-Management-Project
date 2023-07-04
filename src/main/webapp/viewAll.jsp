<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>All Employees</title>
<style type="text/css">
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
  padding: 4px;
}</style>
<script>
        function showPage(pageNum) {
            var rows = document.getElementsByTagName("tr");
            var startIndex = (pageNum - 1) * 5 + 1;
            var endIndex = pageNum * 5;
   			for (var i = 1; i < rows.length; i++) {
                if (i >= startIndex && i <= endIndex) {
                    table.rows[i].style.display = "table-row";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }

    </script>
    
</head>
<body style="background-color: #ecf5ff;" onload="showPage(1)">
	<div
		class="container shadow p-3 mb-5 bg-body-tertiary rounded my-4 bg-#8cc5ff">
		<center>
			<h2>All Records</h2>
		
		
		<hr>
		<table  id="table">
			<thead >
				<tr>
					<th>Sr.No.</th>
					<th>Employee Name</th>
					<th>Address</th>
					<th>Gender</th>
					<th>Salary</th>
					<th>Birthdate</th>
					<th>Actions</th>
					<th></th>

				</tr>
			</thead>
			<%
			 String jdbcUrl = "jdbc:mysql://localhost:3306/my_db";
	        String username = "root";
	        String password = "admin";
			 
			int rows = 0;
			try {
				Class.forName("com.mysql.jdbc.Driver");  
	            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
				String sql = "select * from employee";
				PreparedStatement ps = connection.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();

				while (rs.next()) {
					rows = rs.getRow();
			%>
			<tbody>
				<tr>
					<td><%=rs.getRow()%></td>
					<td ><%=rs.getString("name")%></td>
					<td><%=rs.getString("address")%></td>
					<td><%=(rs.getInt("gender") == 0) ? "Male" : "Female"%></td>
					<td><%=rs.getDouble("salary")%></td>
					<td><%=rs.getDate("birthdate")%></td>
					<td><form action="editEmp.jsp" method="post">
							<input type="hidden" value="<%=rs.getInt("employeeId")%>"
								name="empId">
							<button class="btn btn-primary" type="submit">Update</button>
						</form></td>
					<td>
						<form action="deleteEmp.jsp" method="post"
							onsubmit="return confirm('Are you sure want to delete employee?')">
							<input type="hidden" value="<%=rs.getInt("employeeId")%>"
								name="empId">
							<button class="btn btn-primary" type="submit">Delete</button>
						</form>
					</td>
				</tr>
			</tbody>
			<%
			}
				connection.close();
			} catch (Exception exception) {
			exception.printStackTrace();
			} 
			%>
		</table><br><br>
		<%
		int currPage=1;
		int pageCount = (int) Math.ceil(rows / 5.0);
		for (int i = 1; i <= pageCount; i++) {
		%>
		<a href="#" class="btn btn-outline-primary my-4 mx-2 "
			onclick="showPage(<%=i%>)">Page <%=i%></a>
		<%
		}
		%>
		<p  style="display: inline">
			Total Records:
			<%=rows%></p>
			<br><br>
			<a class="btn btn-success" href="index.jsp">Insert Record</a>
	</center>
	</div>


</body>
</html>