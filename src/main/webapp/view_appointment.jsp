<%@page import="com.entity.Doctor"%>
<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Appointments - Medi Home</title>
<%@include file="component/allcss.jsp" %>
<link rel="stylesheet" href="CSS/style.css">
</head>
<body>
	<%@include file="component/navbar.jsp" %>
	
	<c:if test="${empty userObj}">
        <c:redirect url="user_login.jsp"></c:redirect>
    </c:if>
	
	<div class="container-fluid backImg p-5">
		<p class="text-center fs-2 text-white"></p>
	</div>
	
	<div class="container p-4">
		<!-- Success/Error Messages -->
		<c:if test="${not empty succMsg}">
			<div class="alert alert-success alert-dismissible fade show" role="alert">
				<i class="fa-solid fa-check-circle me-2"></i>${succMsg}
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
			<c:remove var="succMsg" scope="session" />
		</c:if>
		<c:if test="${not empty errorMsg}">
			<div class="alert alert-danger alert-dismissible fade show" role="alert">
				<i class="fa-solid fa-exclamation-circle me-2"></i>${errorMsg}
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
			<c:remove var="errorMsg" scope="session" />
		</c:if>
		
		<!-- Patient Profile Section -->
		<div class="card paint-card mb-4">
			<div class="card-body">
				<div class="d-flex align-items-center gap-4 flex-wrap">
					<c:choose>
						<c:when test="${not empty userObj.photo}">
							<img src="user_img/${userObj.photo}" alt="Profile Photo" 
								style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 3px solid var(--primary-color); box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);">
						</c:when>
						<c:otherwise>
							<div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);">
								<i class="fa-solid fa-user fa-2x text-white"></i>
							</div>
						</c:otherwise>
					</c:choose>
					<div>
						<h4 class="mb-1" style="color: var(--text-color);">${userObj.fullname}</h4>
						<p class="mb-0 text-muted"><i class="fa-solid fa-envelope me-2"></i>${userObj.email}</p>
					</div>
					<div class="ms-auto">
						<a href="user_appointment.jsp" class="btn text-white" style="background: var(--navbar-bg); border-radius: 10px;">
							<i class="fa-solid fa-plus me-2"></i>Book New Appointment
						</a>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Appointments Header -->
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h3 style="color: var(--text-color);"><i class="fa-solid fa-calendar-check me-2" style="color: var(--primary-color);"></i>My Appointments</h3>
			<% 
			User user = (User) session.getAttribute("userObj");
			AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
			List<Appointment> list = dao.getAllAppointmentByLoginUser(user.getId());
			%>
			<span class="badge" style="background: var(--primary-color); font-size: 1rem; padding: 10px 20px; border-radius: 20px;">
				Total: <%=list.size() %>
			</span>
		</div>
		
		<!-- Appointment Cards -->
		<% 
		if(list.isEmpty()) {
		%>
			<div class="card paint-card">
				<div class="card-body text-center p-5">
					<i class="fa-solid fa-calendar-xmark fa-4x mb-3" style="color: var(--primary-color); opacity: 0.5;"></i>
					<h4 style="color: var(--text-color);">No Appointments Yet</h4>
					<p class="text-muted">You haven't booked any appointments yet.</p>
					<a href="user_appointment.jsp" class="btn text-white mt-3" style="background: var(--navbar-bg); border-radius: 10px;">
						<i class="fa-solid fa-plus me-2"></i>Book Your First Appointment
					</a>
				</div>
			</div>
		<%
		} else {
			DoctorDao dao2 = new DoctorDao(DBConnect.getConn());
		%>
		<div class="row">
			<%
			for(Appointment ap : list) {
				Doctor d = dao2.getDoctorById(ap.getDoctorId());
				String statusClass = "";
				String statusIcon = "";
				if("Pending".equals(ap.getStatus())) {
					statusClass = "background: rgba(245, 158, 11, 0.15); color: #f59e0b;";
					statusIcon = "fa-clock";
				} else if("Completed".equals(ap.getStatus())) {
					statusClass = "background: rgba(16, 185, 129, 0.15); color: #10b981;";
					statusIcon = "fa-check-circle";
				} else {
					statusClass = "background: rgba(239, 68, 68, 0.15); color: #ef4444;";
					statusIcon = "fa-times-circle";
				}
			%>
			<div class="col-md-6 col-lg-4 mb-4">
				<div class="card paint-card h-100">
					<div class="card-body">
						<!-- Status Badge -->
						<div class="d-flex justify-content-between align-items-start mb-3">
							<span class="badge" style="<%=statusClass %> padding: 8px 15px; border-radius: 20px; font-weight: 600;">
								<i class="fa-solid <%=statusIcon %> me-1"></i><%=ap.getStatus() %>
							</span>
							<span class="text-muted" style="font-size: 0.85rem;">
								<i class="fa-solid fa-calendar me-1"></i><%=ap.getAppoinDate() %>
							</span>
						</div>
						
						<!-- Doctor Info -->
						<div class="d-flex align-items-center gap-3 mb-3 pb-3" style="border-bottom: 1px dashed var(--border-color);">
							<div style="width: 50px; height: 50px; border-radius: 50%; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); display: flex; align-items: center; justify-content: center;">
								<i class="fa-solid fa-user-doctor text-white"></i>
							</div>
							<div>
								<p class="mb-0 fw-semibold" style="color: var(--text-color);">Dr. <%=d.getFullName() %></p>
								<small class="text-muted"><%=d.getSpecialist() %></small>
							</div>
						</div>
						
						<!-- Appointment Details -->
						<div class="mb-2">
							<small class="text-muted"><i class="fa-solid fa-disease me-2"></i>Disease/Symptoms</small>
							<p class="mb-0 fw-semibold" style="color: var(--text-color);"><%=ap.getDiseases() %></p>
						</div>
						
						<div class="row mt-3">
							<div class="col-6">
								<small class="text-muted"><i class="fa-solid fa-venus-mars me-2"></i>Gender</small>
								<p class="mb-0" style="color: var(--text-color);"><%=ap.getGender() %></p>
							</div>
							<div class="col-6">
								<small class="text-muted"><i class="fa-solid fa-cake-candles me-2"></i>Age</small>
								<p class="mb-0" style="color: var(--text-color);"><%=ap.getAge() %> years</p>
							</div>
						</div>
						
						<% if(ap.getStatus() != null && !ap.getStatus().isEmpty() && !"Pending".equals(ap.getStatus())) { %>
						<div class="mt-3 pt-3" style="border-top: 1px dashed var(--border-color);">
							<small class="text-muted"><i class="fa-solid fa-comment-medical me-2"></i>Doctor's Comment</small>
							<p class="mb-0" style="color: var(--text-color);"><%=ap.getStatus() %></p>
						</div>
						<% } %>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<%
		}
		%>
	</div>
	
	<script src="JS/theme.js"></script>
</body>
</html>