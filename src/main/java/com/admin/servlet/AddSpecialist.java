package com.admin.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.SpecialistDao;
import com.db.DBConnect;

@WebServlet("/addSpecialist")
public class AddSpecialist extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String specName = req.getParameter("specName");
		
		Connection conn = null;
		HttpSession session = req.getSession();
		
		try {
			conn = DBConnect.getConn();
			SpecialistDao dao = new SpecialistDao(conn);
			boolean f = dao.addSpecialist(specName);
			
			if(f) {
				session.setAttribute("succMsg", "Specialist added");
				resp.sendRedirect("admin/index.jsp");
			} else {
				session.setAttribute("errorMsg", "Something wrong on server");
				resp.sendRedirect("admin/index.jsp");
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