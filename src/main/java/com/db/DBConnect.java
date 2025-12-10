package com.db;

import java.sql.Connection;

public class DBConnect {
	private static Connection conn;

	public static Connection getConn() { 		//Use static method to get the connection using classname without creating object
		try {
			if (conn == null || conn.isClosed()) {
				Class.forName("com.mysql.cj.jdbc.Driver");	// Load MySQL JDBC Driver
				conn = java.sql.DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/hospital_management_system", "root", "root"); // Establish the connection
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
