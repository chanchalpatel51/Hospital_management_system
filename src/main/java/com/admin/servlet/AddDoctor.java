package com.admin.servlet;

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

import com.dao.DoctorDao;
import com.db.DBConnect;
import com.entity.Doctor;

@WebServlet("/addDoctor")
@MultipartConfig
public class AddDoctor extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String fullname = req.getParameter("fullname");
			String dob = req.getParameter("dob");
			String qualification = req.getParameter("qualification");
			String spec = req.getParameter("spec");
			String email = req.getParameter("email");
			String mobno = req.getParameter("mobno");
			String password = req.getParameter("password");
			
			// Handle file upload
			Part part = req.getPart("photo");
			String photoName = part.getSubmittedFileName();
			
			// Generate unique filename to avoid conflicts
			String fileName = System.currentTimeMillis() + "_" + photoName;
			
			// Get the path to save the image
			String path = getServletContext().getRealPath("") + "doctor_img";
			File file = new File(path);
			if (!file.exists()) {
				file.mkdir();
			}
			
			// Save the file if photo is provided
			if (photoName != null && !photoName.isEmpty()) {
				part.write(path + File.separator + fileName);
			} else {
				fileName = "default.jpg"; // Default image if no photo uploaded
			}
			
			// Create Doctor object with photo
			Doctor d = new Doctor(fullname, dob, qualification, spec, email, mobno, password, fileName);
			
			DoctorDao dao = new DoctorDao(DBConnect.getConn());
			HttpSession session = req.getSession();
			
			if(dao.registerDoctor(d)) {
				session.setAttribute("succMsg", "Doctor Added Successfully...");
				resp.sendRedirect("admin/doctor.jsp");
			} else {
				session.setAttribute("errorMsg", "Something wrong on server");
				resp.sendRedirect("admin/doctor.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
