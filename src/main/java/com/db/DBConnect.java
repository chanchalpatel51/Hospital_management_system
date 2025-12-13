package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

	// Load driver once during class loading
	static {
		try {
			System.out.println("========== LOADING JDBC DRIVER ==========");
			System.out.println("Driver class: " + com.util.DBConnect.DB_DRIVER);
			Class.forName(com.util.DBConnect.DB_DRIVER);
			System.out.println("MySQL JDBC Driver loaded successfully!");
		} catch (ClassNotFoundException e) {
			System.err.println("CRITICAL ERROR: Failed to load MySQL JDBC Driver!");
			System.err.println("Driver class: " + com.util.DBConnect.DB_DRIVER);
			System.err.println("Error: " + e.getMessage());
			e.printStackTrace();
		}
	}

	public static Connection getConn() {
		Connection conn = null;
		try {
			System.out.println("========== DATABASE CONNECTION ATTEMPT ==========");
			System.out.println("DB_HOST: " + com.util.DBConnect.DB_HOST);
			System.out.println("DB_PORT: " + com.util.DBConnect.DB_PORT);
			System.out.println("DB_NAME: " + com.util.DBConnect.DB_NAME);
			System.out.println("DB_USER: " + com.util.DBConnect.DB_USER);
			System.out.println("DB_PASSWORD: " + (com.util.DBConnect.DB_PASSWORD != null ? "****" + com.util.DBConnect.DB_PASSWORD.substring(Math.max(0, com.util.DBConnect.DB_PASSWORD.length()-3)) : "null"));
			System.out.println("DB_SSL: " + com.util.DBConnect.DB_SSL);
			System.out.println("DB_URL: " + com.util.DBConnect.DB_URL);
			
			conn = DriverManager.getConnection(
					com.util.DBConnect.DB_URL, com.util.DBConnect.DB_USER, com.util.DBConnect.DB_PASSWORD);
			
			System.out.println("SUCCESS: Database connection established!");
			System.out.println("Connection class: " + conn.getClass().getName());
			System.out.println("Catalog: " + conn.getCatalog());
		} catch (SQLException e) {
			System.err.println("========== DATABASE CONNECTION FAILED ==========");
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("ErrorCode: " + e.getErrorCode());
			System.err.println("DB_URL was: " + com.util.DBConnect.DB_URL);
			e.printStackTrace();
		} catch (Exception e) {
			System.err.println("========== UNEXPECTED ERROR ==========");
			System.err.println("Exception type: " + e.getClass().getName());
			System.err.println("Message: " + e.getMessage());
			e.printStackTrace();
		}
		return conn;
	}
}
