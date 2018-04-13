package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Validate {
	
	public static boolean validate() {
		boolean found = false;
		try {
			String query = "SELECT * FROM DEVELOPER_DETAILS WHERE EMP_ID = ? AND PASSWORD = ?";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aniruddha_db?autoReconnect=true&useSSL=false", "root","root");
			PreparedStatement user = con.prepareStatement(query);
			
			ResultSet rs = user.executeQuery();
			found = rs.next();
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return found;
	}

}
