package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.User;

public class UserDao {
	private Connection conn;

	public UserDao(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public boolean register(User u) {
			boolean f = false;
			
			try {
				System.out.println("========== UserDao.register() ==========");
				System.out.println("Registering user: " + u.getFullname());
				System.out.println("Email: " + u.getEmail());
				
				if (conn == null) {
					System.err.println("ERROR: Database connection is NULL!");
					return false;
				}
				
				if (conn.isClosed()) {
					System.err.println("ERROR: Database connection is CLOSED!");
					return false;
				}
				
				PreparedStatement ps = conn.prepareStatement("insert into user_dtls(full_name,email,password,photo) values(?,?,?,?)");
				ps.setString(1, u.getFullname());
				ps.setString(2, u.getEmail());
				ps.setString(3, u.getPassword());
				ps.setString(4, u.getPhoto());
				
				System.out.println("Executing insert query...");
				int i=ps.executeUpdate();
				System.out.println("Rows affected: " + i);
				
				if(i==1) {
					f=true;
					System.out.println("SUCCESS: User registered successfully!");
				} else {
					System.out.println("FAILED: No rows inserted");
				}
				
				ps.close();
			} catch (Exception e) {
				System.err.println("========== EXCEPTION IN UserDao.register() ==========");
				System.err.println("Exception type: " + e.getClass().getName());
				System.err.println("Exception message: " + e.getMessage());
				e.printStackTrace();
			}
			
			System.out.println("========== END UserDao.register() ==========");
			return f;
	}
	
	public User login(String em, String psw) {
		User u = null;
		
		try {
			System.out.println("========== UserDao.login() ==========");
			System.out.println("Input email: " + em);
			System.out.println("Input password length: " + (psw != null ? psw.length() : "null"));
			
			if (conn == null) {
				System.err.println("ERROR: Connection is NULL in UserDao!");
				return null;
			}
			
			if (conn.isClosed()) {
				System.err.println("ERROR: Connection is CLOSED in UserDao!");
				return null;
			}
			
			System.out.println("Connection is valid, preparing query...");
			
			String sql = "select * from user_dtls where email=? and password=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, em);
			ps.setString(2, psw);
			
			System.out.println("Executing query: " + sql);
			System.out.println("Parameter 1 (email): " + em);
			System.out.println("Parameter 2 (password): ****");
			
			ResultSet rs = ps.executeQuery();
			
			int rowCount = 0;
			while(rs.next()) {
				rowCount++;
				u = new User();
				u.setId(rs.getInt(1));
				u.setFullname(rs.getString(2));
				u.setEmail(rs.getString(3));
				u.setPassword(rs.getString(4));
				u.setPhoto(rs.getString(5));
				System.out.println("Found user - ID: " + u.getId() + ", Name: " + u.getFullname() + ", Email: " + u.getEmail());
			}
			
			System.out.println("Total rows found: " + rowCount);
			
			if (u == null) {
				System.out.println("NO USER FOUND with email: " + em);
				System.out.println("Possible reasons:");
				System.out.println("  1. User not registered in production database");
				System.out.println("  2. Wrong email or password");
				System.out.println("  3. Database table 'user_dtls' is empty");
			}
			
			rs.close();
			ps.close();
			
		} catch (Exception e) {
			System.err.println("========== EXCEPTION IN UserDao.login() ==========");
			System.err.println("Exception type: " + e.getClass().getName());
			System.err.println("Exception message: " + e.getMessage());
			e.printStackTrace();
		}
		
		System.out.println("========== END UserDao.login() ==========");
		return u;
	}
	
	public boolean checkOldPassword(int userid, String oldPassword) {
		boolean f = false;
		
		try {
			String sql = "select * from user_dtls where id=? and password=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setString(2, oldPassword);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				f=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	public boolean changePassword(int userid, String newPassword) {
		boolean f = false;
		
		try {
			String sql = "update user_dtls set password=? where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, newPassword);
			ps.setInt(2, userid);
			
			int i = ps.executeUpdate();
			if(i==1) {
				f=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	public boolean updatePhoto(int userId, String photo) {
		boolean f = false;
		
		try {
			String sql = "update user_dtls set photo=? where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, photo);
			ps.setInt(2, userId);
			
			int i = ps.executeUpdate();
			if(i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	public User getUserById(int id) {
		User u = null;
		
		try {
			String sql = "select * from user_dtls where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				u = new User();
				u.setId(rs.getInt(1));
				u.setFullname(rs.getString(2));
				u.setEmail(rs.getString(3));
				u.setPassword(rs.getString(4));
				u.setPhoto(rs.getString(5));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return u;
	}
}
