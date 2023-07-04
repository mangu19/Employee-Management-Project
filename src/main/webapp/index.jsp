<%@page import="java.util.List"%>
<%@page import="Skills.ViewSkills"%>
<%@page import="Skills.Skills"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Form</title>
</head>
<body>
    <h1>Employee Form</h1>

    <form action="insert.jsp" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
        
        <br><br>

        <label for="birthDate">Birth Date:</label>
       	<input type="date" id="birthDate" name="birthdate" >
	<br><br>
        <label for="address">Address:</label>
        <textarea id="address" name="address" rows="4" cols="50" maxlength="150" required></textarea>
        <br><br>

        <label>Gender:</label>
        <input type="radio" id="male" name="gender" value="0" checked>
        <label for="male">Male</label>
        <input type="radio" id="female" name="gender" value="1">
        <label for="female">Female</label>
        <br><br>

        <label>Skill Id:</label><br>
        <%-- Retrieve skills from skill master table dynamically --%>
        <%
            List<Skills> skills = ViewSkills.getAllSkills(); 
            for (Skills skill : skills) {
        %>
                <input type="checkbox" name="skills" value="<%= skill.getSkillId() %>">
                <%= skill.getSkill() %><br>
        <% } %>
       
        <br><br>

        <label for="salary">Salary:</label>
        <input type="number" id="salary" name="salary" min="0" max="99999" step="0.01" required>
       
        <br><br>

        <input type="submit" value="Submit">
    </form>
    <a class="btn btn-success" href="viewAll.jsp">View All Records</a>
</body>
</html>
