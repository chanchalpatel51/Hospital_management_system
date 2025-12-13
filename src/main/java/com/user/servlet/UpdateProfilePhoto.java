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

@WebServlet("/updateProfilePhoto")
@MultipartConfig
public class UpdateProfilePhoto extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("userObj");
		
		if(user == null) {
			resp.sendRedirect("user_login.jsp");
			return;
		}
		
		Connection conn = null;
		try {
			Part part = req.getPart("photo");
			String fileName = part.getSubmittedFileName();
			
			if(fileName != null && !fileName.isEmpty()) {
				// Generate unique filename
				String newFileName = System.currentTimeMillis() + "_" + fileName;
				
				// Get the path for saving the file
				String path = req.getServletContext().getRealPath("/") + "user_img";
				File file = new File(path);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				// Save the file
				String filePath = path + File.separator + newFileName;
				part.write(filePath);
				
				// Update database
				conn = DBConnect.getConn();
				UserDao dao = new UserDao(conn);
				boolean updated = dao.updatePhoto(user.getId(), newFileName);
				
				if(updated) {
					// Update session with new user data
					User updatedUser = dao.getUserById(user.getId());
					session.setAttribute("userObj", updatedUser);
					session.setAttribute("succMsg", "Profile photo updated successfully!");
					resp.sendRedirect("view_appointment.jsp");
					return;
				} else {
					session.setAttribute("errorMsg", "Failed to update profile photo!");
					resp.sendRedirect("edit_profile.jsp");
					return;
				}
			} else {
				session.setAttribute("errorMsg", "Please select a photo to upload!");
				resp.sendRedirect("edit_profile.jsp");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Something went wrong: " + e.getMessage());
			resp.sendRedirect("edit_profile.jsp");
			return;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
