package com.user.servlet;

import java.io.File;
import java.io.IOException;

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
		try {
			String fullname = req.getParameter("fullname");
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			
			// Handle photo upload
			Part part = req.getPart("photo");
			String fileName = part.getSubmittedFileName();
			
			// Create user_img folder path
			String path = getServletContext().getRealPath("") + "user_img";
			File file = new File(path);
			if (!file.exists()) {
				file.mkdir();
			}
			
			// Save the photo
			String filePath = path + File.separator + fileName;
			part.write(filePath);
			
			User u = new User(fullname, email, password, fileName);
			
			UserDao dao = new UserDao(DBConnect.getConn());
			boolean f = dao.register(u);
			
			HttpSession session = req.getSession();
			
			if(f) {
				session.setAttribute("succMsg", "Registration Successful! Please login to continue.");
				resp.sendRedirect("user_login.jsp");
			} else {
				session.setAttribute("errorMsg", "Something wrong on server");
				resp.sendRedirect("signup.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
