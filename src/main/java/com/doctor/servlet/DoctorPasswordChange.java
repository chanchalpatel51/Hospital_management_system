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

@WebServlet("/doctChangePassword")
public class DoctorPasswordChange extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int uid = Integer.parseInt(req.getParameter("uid"));
		String oldPassword = req.getParameter("oldPassword");
		String newPassword = req.getParameter("newPassword");
		
		Connection conn = null;
		HttpSession session = req.getSession();
		
		try {
			conn = DBConnect.getConn();
			DoctorDao dao = new DoctorDao(conn);
			
			if(dao.checkOldPassword(uid, oldPassword)) {
				
				if(dao.changePassword(uid, newPassword)) {
						session.setAttribute("succMsg", "Password Changed Successfully");
						resp.sendRedirect("doctor/edit_profile.jsp");
						
					} else {
						session.setAttribute("errorMsg", "Something went wrong");
						resp.sendRedirect("doctor/edit_profile.jsp");
					}
				
				} else {
					session.setAttribute("errorMsg", "Old Password Incorrect");
					resp.sendRedirect("doctor/edit_profile.jsp");
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
