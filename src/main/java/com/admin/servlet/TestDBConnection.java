package com.admin.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DBConnect;

@WebServlet("/testdb")
public class TestDBConnection extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		
		out.println("<html><body>");
		out.println("<h1>Database Connection Test</h1>");
		out.println("<hr>");
		
		// Display environment variables
		out.println("<h2>Environment Variables:</h2>");
		out.println("<p><b>DB_HOST:</b> " + com.util.DBConnect.DB_HOST + "</p>");
		out.println("<p><b>DB_PORT:</b> " + com.util.DBConnect.DB_PORT + "</p>");
		out.println("<p><b>DB_NAME:</b> " + com.util.DBConnect.DB_NAME + "</p>");
		out.println("<p><b>DB_USER:</b> " + com.util.DBConnect.DB_USER + "</p>");
		out.println("<p><b>DB_PASSWORD:</b> " + (com.util.DBConnect.DB_PASSWORD != null ? "****" + com.util.DBConnect.DB_PASSWORD.substring(Math.max(0, com.util.DBConnect.DB_PASSWORD.length()-3)) : "null") + "</p>");
		out.println("<p><b>DB_SSL:</b> " + com.util.DBConnect.DB_SSL + "</p>");
		out.println("<p><b>DB_URL:</b> " + com.util.DBConnect.DB_URL + "</p>");
		out.println("<hr>");
		
		// Test connection
		out.println("<h2>Connection Test:</h2>");
		Connection conn = null;
		try {
			conn = DBConnect.getConn();
			if (conn != null) {
				out.println("<p style='color:green;'><b>✓ SUCCESS:</b> Database connection established!</p>");
				out.println("<p><b>Connection class:</b> " + conn.getClass().getName() + "</p>");
				out.println("<p><b>Database catalog:</b> " + conn.getCatalog() + "</p>");
				out.println("<p><b>Is closed:</b> " + conn.isClosed() + "</p>");
				out.println("<p><b>Is valid:</b> " + conn.isValid(5) + "</p>");
			} else {
				out.println("<p style='color:red;'><b>✗ FAILED:</b> Connection is NULL</p>");
				out.println("<p>Check the server logs for detailed error messages.</p>");
			}
		} catch (Exception e) {
			out.println("<p style='color:red;'><b>✗ EXCEPTION:</b> " + e.getMessage() + "</p>");
			out.println("<pre>");
			e.printStackTrace(out);
			out.println("</pre>");
		} finally {
			if (conn != null) {
				try {
					conn.close();
					out.println("<p><b>Connection closed successfully.</b></p>");
				} catch (Exception e) {
					out.println("<p style='color:orange;'><b>Warning:</b> Error closing connection: " + e.getMessage() + "</p>");
				}
			}
		}
		
		out.println("</body></html>");
	}
}
