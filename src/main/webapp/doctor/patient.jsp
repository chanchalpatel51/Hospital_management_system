<%@page import="java.util.List"%>
<%@page import="com.entity.Appointment"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.entity.Doctor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../component/allcss.jsp" %>
<%-- Own CSS file --%>
<link rel="stylesheet" href="../CSS/style.css">
</head>
<body>
	<c:if test="${empty doctorObj}">
        <c:redirect url="../doctor_login.jsp"></c:redirect>
     </c:if>
     
	<%@include file="navbar.jsp" %>
	
	<div class="container p-3">
		<div class="row">
			<div class="col-md-12">
				<div class="card paint-card">
					<div class="card-body">
						<p class="fs-3 text-center">Patient Details</p>
				<c:if test="${not empty errorMsg}">
					<div class="alert-msg alert-danger"><i class="fa-solid fa-circle-exclamation"></i> ${errorMsg}</div>
					<c:remove var="errorMsg" scope="session" />
				</c:if>
				
				<c:if test="${not empty succMsg}">
					<div class="alert-msg alert-success"><i class="fa-solid fa-circle-check"></i> ${succMsg}</div>
					<c:remove var="succMsg" scope="session" />
				</c:if>
				
				<table class="table">
					<thead>
						<tr>
							<th scope="col">Full Name</th>
							<th scope="col">Gender</th>
							<th scope="col">Age</th>
							<th scope="col">Appointment Date</th>
							<th scope="col">Email</th>
							<th scope="col">Mob No</th>
							<th scope="col">Diseases</th>
							<th scope="col">Status</th>
							<th scope="col">Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						Doctor d = (Doctor)session.getAttribute("doctorObj");
						AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
						List<Appointment> list = dao.getAllAppointmentByDoctorLogin(d.getId());
						for (Appointment ap : list) {
						%>
						<tr>
							<th><%=ap.getFullName() %></th>
							<td><%=ap.getGender() %></td>
							<td><%=ap.getAge() %></td>
							<td><%=ap.getAppoinDate() %></td>
							<td><%=ap.getEmail() %></td>
							<td><%=ap.getPhNo() %></td>
							<td><%=ap.getDiseases() %></td>
							<td><%=ap.getStatus() %></td>
							<td>
							
							<%
							if("Pending".equals(ap.getStatus()))
							{%>
								<a href="comment.jsp?id=<%=ap.getId() %>" class="btn btn-sm text-white" style="background: var(--navbar-bg);">Comment</a> <%} else {%>
								<a href="#" class="btn btn-sm text-white disabled" style="background: var(--navbar-bg);">Comment</a>
							<%}
							%>
							
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
		</div>
	</div>
	<script src="../JS/theme.js"></script>
</body>
</html>