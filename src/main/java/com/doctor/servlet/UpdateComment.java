package com.doctor.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.AppointmentDAO;
import com.db.DBConnect;

@WebServlet("/comment")
public class UpdateComment extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Connection conn = null;
		try {
			int id = Integer.parseInt(req.getParameter("id"));
			int did = Integer.parseInt(req.getParameter("did"));
			String comm = req.getParameter("comm");
			
			conn = DBConnect.getConn();
			AppointmentDAO dao = new AppointmentDAO(conn);
			HttpSession session = req.getSession();
			
			if(dao.updateCommentStatus(id, did, comm)) {
				session.setAttribute("succMsg", "Comment Updated Successfully");
				resp.sendRedirect("doctor/patient.jsp");
			} else {
				session.setAttribute("errorMsg", "Something went wrong on server");
				resp.sendRedirect("doctor/patient.jsp");
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
