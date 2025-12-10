<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- Check if admin is logged in BEFORE any HTML output --%>
<%
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("../admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- Bootstrap CSS Include from component --%>
<%@include file="../component/allcss.jsp"%>
<%-- Own CSS file --%>
<link rel="stylesheet" href="../CSS/style.css">
</head>
<body>
	<%@include file="navbar.jsp"%>
	<div class="container-fluid p-5">
		<div class="card paint-card">
		    <div class="card-body">
        		<p class="text-center fs-3">Patient Details</p>
        			<table class="table">
            			<thead>
                			<tr>
			                    <th scope="col">Full Name</th>
			                   	<th scope="col">Gender</th>
			                   	<th scope="col">Age</th>
			                   	<th scope="col">Appointment</th>
			                   	<th scope="col">Email</th>
			                   	<th scope="col">Mob No</th>
			                   	<th scope="col">Diseases</th>
                    			<th scope="col">Doctor Name</th>
                    			<th scope="col">Address</th>
                    			<th scope="col">Status</th>
                    		</tr>
                    	</thead>
                    	<tbody>
                    		<%
                    			AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
                    			DoctorDao dao2 = new DoctorDao(DBConnect.getConn());
                    		    List<Appointment> list = dao.getAllAppointment();
                    		    for(Appointment ap : list) {
                    		    	Doctor d = dao2.getDoctorById(ap.getDoctorId());
                    		    %>
                    		    	<tr>
		                    			<th><%=ap.getFullName() %></th>
		                    			<td><%=ap.getGender() %></td>
		                    			<td><%=ap.getAge() %></td>
		                    			<td><%=ap.getAppoinDate() %></td>
		                    			<td><%=ap.getEmail() %></td>
		                    			<td><%=ap.getPhNo() %></td>
		                    			<td><%=ap.getDiseases() %></td>
		                    			<td><%=d.getFullName() %></td>
		                    			<td><%=ap.getAddress() %></td>
		                    			<td>
		                    				<% if("Pending".equals(ap.getStatus())) { %>
		                    					<span class="badge" style="background-color: #ffc107; color: #000; padding: 8px 12px; border-radius: 20px;"><%=ap.getStatus() %></span>
		                    				<% } else { %>
		                    					<span class="badge" style="background-color: #28a745; color: #fff; padding: 8px 12px; border-radius: 20px;"><%=ap.getStatus() %></span>
		                    				<% } %>
		                    			</td>
		                    		</tr>
                    		    <%
                    		    }
                    			%>
                    		
                    	</tbody>
             		</table>
      	</div>
  		</div>
	</div>
	<script src="../JS/theme.js"></script>
</body>
</html>