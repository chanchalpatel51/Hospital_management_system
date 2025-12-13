package com.user.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.dao.UserDao;
import com.db.DBConnect;
import com.entity.User;

@WebServlet("/user_register")
@MultipartConfig
public class UserRegister extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Connection conn = null;
		try {
			System.out.println("========== USER REGISTRATION ATTEMPT ==========");
			
			String fullname = req.getParameter("fullname");
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			
			System.out.println("Fullname: " + fullname);
			System.out.println("Email: " + email);
			System.out.println("Password length: " + (password != null ? password.length() : "null"));
			
			// Handle photo upload
			Part part = req.getPart("photo");
			String fileName = part.getSubmittedFileName();
			System.out.println("Photo filename: " + fileName);
			
			// Create user_img folder path
			String path = getServletContext().getRealPath("") + "user_img";
			System.out.println("Upload path: " + path);
			
			File file = new File(path);
			if (!file.exists()) {
				file.mkdir();
				System.out.println("Created directory: " + path);
			}
			
			// Save the photo
			String filePath = path + File.separator + fileName;
			part.write(filePath);
			System.out.println("Photo saved to: " + filePath);
			
			User u = new User(fullname, email, password, fileName);
			
			System.out.println("Getting database connection...");
			conn = DBConnect.getConn();
			
			if (conn == null) {
				System.err.println("ERROR: Database connection is NULL!");
				HttpSession session = req.getSession();
				session.setAttribute("errorMsg", "Database connection failed");
				resp.sendRedirect("signup.jsp");
				return;
			}
			
			System.out.println("Database connection successful!");
			
			UserDao dao = new UserDao(conn);
			boolean f = dao.register(u);
			
			HttpSession session = req.getSession();
			
			if(f) {
				System.out.println("REGISTRATION SUCCESS for: " + email);
				session.setAttribute("succMsg", "Registration Successful! Please login to continue.");
				resp.sendRedirect("user_login.jsp");
			} else {
				System.out.println("REGISTRATION FAILED for: " + email);
				session.setAttribute("errorMsg", "Something wrong on server");
				resp.sendRedirect("signup.jsp");
			}
		} catch (Exception e) {
			System.err.println("========== EXCEPTION IN USER REGISTRATION ==========");
			System.err.println("Exception type: " + e.getClass().getName());
			System.err.println("Exception message: " + e.getMessage());
			e.printStackTrace();
			
			HttpSession session = req.getSession();
			session.setAttribute("errorMsg", "Error: " + e.getMessage());
			resp.sendRedirect("signup.jsp");
		} finally {
			if (conn != null) {
				try {
					conn.close();
					System.out.println("Database connection closed.");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			System.out.println("========== END USER REGISTRATION ==========\n");
		}
	}
}
