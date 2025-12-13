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
import com.entity.User;

@WebServlet("/userLogin")
public class UserLogin extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		HttpSession session = req.getSession();
		Connection conn = null;
		
		try {
			conn = DBConnect.getConn();
			UserDao dao = new UserDao(conn);
			User user = dao.login(email, password);
			
			if(user != null) { 
				session.setAttribute("userObj", user);
				resp.sendRedirect("index.jsp");
			} else {
				session.setAttribute("errorMsg", "Invalid email & password");
				resp.sendRedirect("user_login.jsp");
			}
		} finally {
			// Always close the connection to prevent connection leaks
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
