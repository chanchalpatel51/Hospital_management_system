package com.doctor.servlet;

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

@WebServlet("/doctorUpdateProfile")
public class EditProfile extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Connection conn = null;
		try {
			String fullname = req.getParameter("fullname");
			String dob = req.getParameter("dob");
			String qualification = req.getParameter("qualification");
			String spec = req.getParameter("spec");
			String email = req.getParameter("email");
			String mobno = req.getParameter("mobno");
			
			// Here you would typically create a Doctor object and use DoctorDao to save it to the database
			int id = Integer.parseInt(req.getParameter("id"));
			
			Doctor d = new Doctor(id, fullname, dob, qualification, spec, email, mobno, "", "");
			
			conn = DBConnect.getConn();
			DoctorDao dao = new DoctorDao(conn);
			HttpSession session = req.getSession();
			
			if(dao.editDoctorProfile(d)) {
				Doctor updateDoctor = dao.getDoctorById(id);
				session.setAttribute("succMsgd", "Doctor Update Successfully...");
				session.setAttribute("doctorObj", updateDoctor);
				resp.sendRedirect("doctor/edit_profile.jsp");
			} else {
				session.setAttribute("errorMsgd", "Something wrong on server");
				resp.sendRedirect("doctor/edit_profile.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
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
