package com.admin.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DoctorDao;
import com.db.DBConnect;
import com.entity.Doctor;

@WebServlet("/deleteDoctor")
public class DeleteDoctor extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));
		
		Connection conn = null;
		HttpSession session = req.getSession();
		
		try {
			conn = DBConnect.getConn();
			DoctorDao dao = new DoctorDao(conn);
			
			// Get doctor details to delete the photo file
			Doctor doctor = dao.getDoctorById(id);
			String oldPhoto = null;
			if (doctor != null) {
				oldPhoto = doctor.getPhoto();
			}
			
			if(dao.deleteDoctor(id)) {
				// Delete the photo file from server if it exists and is not default
				if (oldPhoto != null && !oldPhoto.isEmpty() && !oldPhoto.equals("default.jpg")) {
					String path = getServletContext().getRealPath("") + "doctor_img" + File.separator + oldPhoto;
					File photoFile = new File(path);
					if (photoFile.exists()) {
						boolean deleted = photoFile.delete();
						System.out.println("Doctor photo deleted: " + deleted + " - " + path);
					}
				}
				
				session.setAttribute("succMsg", "Doctor Delete Successfully...");
				resp.sendRedirect("admin/view_doctor.jsp");
			} else {
				session.setAttribute("errorMsg", "Something wrong on server");
				resp.sendRedirect("admin/view_doctor.jsp");
			}
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
