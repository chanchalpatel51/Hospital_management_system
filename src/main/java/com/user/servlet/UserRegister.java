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
		String savedFilePath = null;
		String savedFileName = null;
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
			
			// Generate unique filename and save the photo
			if (fileName != null && !fileName.isEmpty()) {
				savedFileName = System.currentTimeMillis() + "_" + fileName;
				savedFilePath = path + File.separator + savedFileName;
				part.write(savedFilePath);
				System.out.println("Photo saved to: " + savedFilePath);
			} else {
				savedFileName = "default.jpg";
			}
			
			User u = new User(fullname, email, password, savedFileName);
			
			System.out.println("Getting database connection...");
			conn = DBConnect.getConn();
			
			if (conn == null) {
				System.err.println("ERROR: Database connection is NULL!");
				System.err.println("Please check:");
				System.err.println("1. Database server is running and accessible");
				System.err.println("2. Environment variables are set correctly on Render");
				System.err.println("3. Database credentials are correct");
				System.err.println("4. Network allows connection to database (firewall/security groups)");
				// Delete uploaded file since registration failed
				deleteUploadedFile(savedFilePath);
				HttpSession session = req.getSession();
				session.setAttribute("errorMsg", "Database connection failed. Please contact administrator or visit /testdb to see connection details.");
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
				// Delete uploaded file since registration failed
				deleteUploadedFile(savedFilePath);
				session.setAttribute("errorMsg", "Something wrong on server");
				resp.sendRedirect("signup.jsp");
			}
		} catch (Exception e) {
			System.err.println("========== EXCEPTION IN USER REGISTRATION ==========");
			System.err.println("Exception type: " + e.getClass().getName());
			System.err.println("Exception message: " + e.getMessage());
			e.printStackTrace();
			
			// Delete uploaded file since registration failed
			deleteUploadedFile(savedFilePath);
			
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
	
	private void deleteUploadedFile(String filePath) {
		if (filePath != null && !filePath.contains("default.jpg")) {
			File uploadedFile = new File(filePath);
			if (uploadedFile.exists()) {
				boolean deleted = uploadedFile.delete();
				System.out.println("Deleted uploaded file due to failure: " + deleted + " - " + filePath);
			}
		}
	}
}
