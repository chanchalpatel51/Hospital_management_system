package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

	// Load driver once during class loading
	static {
		try {
			Class.forName(com.util.DBConnect.DB_DRIVER);
			System.out.println("MySQL JDBC Driver loaded successfully");
		} catch (ClassNotFoundException e) {
			System.err.println("Failed to load MySQL JDBC Driver: " + e.getMessage());
			e.printStackTrace();
		}
	}

	public static Connection getConn() {
		Connection conn = null;
		try {
			System.out.println("Connecting to database: " + com.util.DBConnect.DB_HOST + ":" + com.util.DBConnect.DB_PORT + "/" + com.util.DBConnect.DB_NAME);
			System.out.println("SSL Enabled: " + com.util.DBConnect.DB_SSL);
			conn = DriverManager.getConnection(
					com.util.DBConnect.DB_URL, com.util.DBConnect.DB_USER, com.util.DBConnect.DB_PASSWORD);
			System.out.println("Database connection established successfully!");
		} catch (SQLException e) {
			System.err.println("Failed to connect to database: " + e.getMessage());
			System.err.println("SQL State: " + e.getSQLState());
			System.err.println("Error Code: " + e.getErrorCode());
			e.printStackTrace();
		}
		return conn;
	}
}
