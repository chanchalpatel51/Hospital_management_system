package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
	private static Connection conn;

	public static Connection getConn() { 		//Use static method to get the connection using classname without creating object
		try {
			if (conn == null || conn.isClosed()) {
				Class.forName(com.util.DBConnect.DB_DRIVER);	// Load MySQL JDBC Driver from properties
				conn = DriverManager.getConnection(
						com.util.DBConnect.DB_URL, com.util.DBConnect.DB_USER, com.util.DBConnect.DB_PASSWORD); // Establish the connection using properties
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
