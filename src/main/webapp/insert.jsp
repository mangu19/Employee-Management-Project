<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@page import="Skills.ViewSkills"%>
<%@page import="Skills.Skills"%>
<%@page import="java.sql.*"%>

<body>
	<%
		String name=request.getParameter("name");
		String address=request.getParameter("address");
		Date birthdate=Date.valueOf(request.getParameter("birthdate"));
		byte gender=Byte.parseByte(request.getParameter("gender"));
		double salary=Double.parseDouble(request.getParameter("salary"));
		String [] skills=request.getParameterValues("skills");
		int[]arr=new int[skills.length];
		for(int i=0;i<skills.length;i++){
			arr[i]=Integer.parseInt(skills[i]);
		}
		  
		   PreparedStatement ps=null;
		   PreparedStatement ps1=null;
		   String jdbcUrl = "jdbc:mysql://localhost:3306/my_db";
	        String username = "root";
	        String password = "admin";
		   try{
			   Class.forName("com.mysql.jdbc.Driver");  
	            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
	            System.out.println("connected");
      			String sql1 ="insert into employee(name,address,gender,salary,birthDate) values(?,?,?,?,?)";
      			ps=connection.prepareStatement(sql1,Statement.RETURN_GENERATED_KEYS);
      			ps.setString(1,name);
      			ps.setString(2,address);
      			ps.setByte(3,gender);
      			ps.setDouble(4, salary);
      			ps.setDate(5,birthdate);
      			System.out.println("connected1");
      			int i=ps.executeUpdate();
      			System.out.println("connected2");
      			ResultSet rs=ps.getGeneratedKeys();
      			int empId=0;
      			if(rs.next())
      			 empId=rs.getInt(1);
      			System.out.println("EMP ID============"+empId);
      			String sql2 ="insert into empskills(employeeId,skillMasterId) values(?,?)";
      			ps1=connection.prepareStatement(sql2);
      			for(int n=0;n<arr.length;n++){
      				ps1.setInt(1,empId);
      				ps1.setInt(2,arr[n]);
      				ps1.executeUpdate();
      			}
      			if(i==1){
      			response.sendRedirect("index.jsp");
      			}
      			connection.close();
		   }catch(Exception e){
			   e.printStackTrace();
		   }
		   

 %>
	<script>
		
			function submitForm(){
				alert("Data Inserted successfully!")
			}
			
		</script>
</body>

</html>