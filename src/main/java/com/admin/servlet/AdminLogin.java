package com.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.User;
import com.util.DBConnect;

@WebServlet("/adminLogin")
public class AdminLogin extends HttpServlet {

	// Get admin credentials from environment variables or use defaults
	private static final String ADMIN_EMAIL = DBConnect.getProperty("ADMIN_EMAIL", "admin@gmail.com");
	private static final String ADMIN_PASSWORD = DBConnect.getProperty("ADMIN_PASSWORD", "admin");

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			
			HttpSession session = req.getSession();
			
			System.out.println("Admin login attempt with email: " + email);
			System.out.println("Expected admin email: " + ADMIN_EMAIL);
			
			if(ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
				session.setAttribute("adminObj", new User());
				resp.sendRedirect("admin/index.jsp");
			} else {
				session.setAttribute("errorMsg", "Invalid email & password");
				resp.sendRedirect("admin_login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
