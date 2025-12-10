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

@WebServlet("/updateDoctor")
@MultipartConfig
public class UpdateDoctor extends HttpServlet {

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
			String oldPhoto = req.getParameter("oldPhoto");
			
			int id = Integer.parseInt(req.getParameter("id"));
			
			// Handle file upload
			Part part = req.getPart("photo");
			String photoName = part.getSubmittedFileName();
			String fileName;
			
			// Get the path to save the image
			String path = getServletContext().getRealPath("") + "doctor_img";
			File file = new File(path);
			if (!file.exists()) {
				file.mkdir();
			}
			
			// If new photo is uploaded, use it; otherwise keep the old photo
			if (photoName != null && !photoName.isEmpty()) {
				fileName = System.currentTimeMillis() + "_" + photoName;
				part.write(path + File.separator + fileName);
			} else {
				fileName = oldPhoto; // Keep the old photo
			}
			
			Doctor d = new Doctor(id, fullname, dob, qualification, spec, email, mobno, password, fileName);
			
			DoctorDao dao = new DoctorDao(DBConnect.getConn());
			HttpSession session = req.getSession();
			
			if(dao.updateDoctor(d)) {
				session.setAttribute("succMsg", "Doctor Update Successfully...");
				resp.sendRedirect("admin/view_doctor.jsp");
			} else {
				session.setAttribute("errorMsg", "Something wrong on server");
				resp.sendRedirect("admin/view_doctor.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
}