package com.user.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDao;
import com.db.DBConnect;
import com.entity.User;

@WebServlet("/userLogin")
public class UserLogin extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		System.out.println("========== USER LOGIN ATTEMPT ==========");
		System.out.println("Email: " + email);
		System.out.println("Password length: " + (password != null ? password.length() : "null"));
		
		HttpSession session = req.getSession();
		Connection conn = null;
		
		try {
			System.out.println("Attempting to get database connection...");
			conn = DBConnect.getConn();
			
			if (conn == null) {
				System.err.println("ERROR: Database connection is NULL!");
				session.setAttribute("errorMsg", "Database connection failed. Please try again later.");
				resp.sendRedirect("user_login.jsp");
				return;
			}
			
			System.out.println("Database connection successful!");
			System.out.println("Connection valid: " + !conn.isClosed());
			
			UserDao dao = new UserDao(conn);
			System.out.println("Calling UserDao.login()...");
			User user = dao.login(email, password);
			
			if(user != null) {
				System.out.println("LOGIN SUCCESS for user: " + user.getFullname());
				session.setAttribute("userObj", user);
				resp.sendRedirect("index.jsp");
			} else {
				System.out.println("LOGIN FAILED - No user found with provided credentials");
				session.setAttribute("errorMsg", "Invalid email & password");
				resp.sendRedirect("user_login.jsp");
			}
		} catch (Exception e) {
			System.err.println("========== EXCEPTION IN USER LOGIN ==========");
			System.err.println("Exception type: " + e.getClass().getName());
			System.err.println("Exception message: " + e.getMessage());
			e.printStackTrace();
			session.setAttribute("errorMsg", "Something went wrong: " + e.getMessage());
			resp.sendRedirect("user_login.jsp");
		} finally {
			if (conn != null) {
				try {
					conn.close();
					System.out.println("Database connection closed.");
				} catch (Exception e) {
					System.err.println("Error closing connection: " + e.getMessage());
				}
			}
			System.out.println("========== END USER LOGIN ==========\n");
		}
	}
}
