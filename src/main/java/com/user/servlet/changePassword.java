package com.user.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDao;
import com.db.DBConnect;

@WebServlet("/userChangePassword")
public class changePassword extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		// Check if user is logged in
		if(session.getAttribute("userObj") == null) {
			resp.sendRedirect("user_login.jsp");
			return;
		}
		
		int uid = Integer.parseInt(req.getParameter("uid"));
		String oldPassword = req.getParameter("oldPassword");
		String newPassword = req.getParameter("newPassword");
		
		Connection conn = null;
		try {
			conn = DBConnect.getConn();
			UserDao dao = new UserDao(conn);
			
			if(dao.checkOldPassword(uid, oldPassword)) {
				
				if(dao.changePassword(uid, newPassword)) {
						session.setAttribute("succMsg", "Password Changed Successfully");
						resp.sendRedirect("change_password.jsp");
						
					} else {
						session.setAttribute("errorMsg", "Something went wrong");
						resp.sendRedirect("change_password.jsp");
					}
				
				} else {
					session.setAttribute("errorMsg", "Old Password Incorrect");
					resp.sendRedirect("change_password.jsp");
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