package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
	private static Connection conn;

	public static Connection getConn() { 		//Use static method to get the connection using classname without creating object
		try {
			if (conn == null || conn.isClosed()) {
				Class.forName(com.util.DBConnect.DB_DRIVER);	// Load MySQL JDBC Driver from properties
				System.out.println("Connecting to database: " + com.util.DBConnect.DB_HOST + ":" + com.util.DBConnect.DB_PORT + "/" + com.util.DBConnect.DB_NAME);
				System.out.println("SSL Enabled: " + com.util.DBConnect.DB_SSL);
				conn = DriverManager.getConnection(
						com.util.DBConnect.DB_URL, com.util.DBConnect.DB_USER, com.util.DBConnect.DB_PASSWORD); // Establish the connection using properties
				System.out.println("Database connection established successfully!");
			}
		} catch (Exception e) {
			System.err.println("Failed to connect to database: " + e.getMessage());
			e.printStackTrace();
		}
		return conn;
	}
}
