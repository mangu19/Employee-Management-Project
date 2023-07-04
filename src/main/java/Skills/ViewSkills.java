package Skills;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

public class ViewSkills {
	
	static List<Integer>skillId=new ArrayList<>();
	
	
	public static List<Skills> getAllSkills(){
		List <Skills>skills=new ArrayList<Skills>();
		 String jdbcUrl = "jdbc:mysql://localhost:3306/my_db";
	        String username = "root";
	        String password = "admin";
	        
	        try {
	        	Class.forName("com.mysql.jdbc.Driver");  
	            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
	            System.err.println("Connected to the database!");
	            String sql ="select * from skillMaster";
				PreparedStatement ps=connection.prepareStatement(sql);
				ResultSet rs=ps.executeQuery();

				while(rs.next()){
					Skills skill=new Skills();
					skill.setSkillId(rs.getInt(1));
					skill.setSkill(rs.getString(2));
					skills.add(skill);

				}

	            connection.close();
	            System.out.println("Connection closed.");
	        } catch (Exception e) {
	            System.err.println("Connection failed. Error: " + e.getMessage());
	        }

		return skills;
		
	}
	
	public static List<Integer>getAllChecked(int empId){
		String jdbcUrl = "jdbc:mysql://localhost:3306/my_db";
        String username = "root";
        String password = "admin";
		try{
			Class.forName("com.mysql.jdbc.Driver");  
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
			String sql ="select skillMasterId from empskills where employeeId=?";
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setInt(1, empId);
			ResultSet rs=ps.executeQuery();
			skillId.clear();
			while(rs.next()){

				skillId.add(rs.getInt("skillMasterId"));

			}
			connection.close();
		}catch(Exception exception){
			exception.printStackTrace();
		}
		return skillId;
	}

	public static String isSelected(int skillid) {
		String employee = "";
		//System.err.println("isSelected=====caLL ");
		if (skillId.contains(skillid)) {
			employee = "CHECKED";
		} else {
			employee = "";
		}
		return employee;
	}

}
