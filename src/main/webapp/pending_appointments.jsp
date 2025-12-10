<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pending Appointments - Medi Home</title>
<%@include file="component/allcss.jsp" %>
<link rel="stylesheet" href="CSS/style.css">
<style>
	.today-highlight {
		background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(5, 150, 105, 0.1)) !important;
		border-left: 4px solid var(--primary-color);
	}
	.section-title {
		font-weight: 700;
		background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	.stats-badge {
		padding: 8px 16px;
		border-radius: 20px;
		font-weight: 600;
	}
</style>
</head>
<body>
	<%@include file="component/navbar.jsp" %>
	
	<div class="container-fluid backImg p-5">
		<p class="text-center fs-2 text-white"></p>
	</div>
	
	<%
		AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
		DoctorDao dao2 = new DoctorDao(DBConnect.getConn());
		List<Appointment> todayPendingList = dao.getTodayPendingAppointments();
		List<Appointment> allPendingList = dao.getAllPendingAppointmentsSorted();
		String todayDate = LocalDate.now().toString();
	%>
	
	<div class="container p-4">
		<!-- Page Header -->
		<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
			<h2 class="section-title mb-0">
				<i class="fa-solid fa-calendar-check me-2" style="-webkit-text-fill-color: var(--primary-color);"></i>Pending Appointments
			</h2>
			<div class="d-flex gap-2 flex-wrap">
				<span class="stats-badge" style="background: rgba(139, 92, 246, 0.15); color: #8b5cf6;">
					<i class="fa-solid fa-calendar-day me-1"></i>Today: <%=todayPendingList.size() %>
				</span>
				<span class="stats-badge" style="background: rgba(249, 115, 22, 0.15); color: #f97316;">
					<i class="fa-solid fa-hourglass-half me-1"></i>Total Pending: <%=allPendingList.size() %>
				</span>
			</div>
		</div>
		
		<!-- Today's Pending Appointments Section -->
		<div class="card mb-4" style="border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); overflow: hidden;">
			<div class="card-header" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed); padding: 15px 20px;">
				<h5 class="mb-0 text-white">
					<i class="fa-solid fa-calendar-day me-2"></i>Today's Pending Appointments
					<span class="badge bg-white text-dark ms-2"><%=todayPendingList.size() %></span>
				</h5>
			</div>
			<div class="card-body" style="background: var(--card-bg);">
				<% if(todayPendingList.isEmpty()) { %>
					<div class="text-center py-4">
						<i class="fa-solid fa-calendar-check fa-3x mb-3" style="color: #8b5cf6; opacity: 0.5;"></i>
						<p class="text-muted mb-0">No pending appointments for today</p>
					</div>
				<% } else { %>
					<div class="table-responsive">
						<table class="table table-hover mb-0">
							<thead>
								<tr>
									<th>#</th>
									<th>Patient Name</th>
									<th>Doctor</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<% int todayCounter = 1; %>
								<% for(Appointment ap : todayPendingList) { 
									Doctor d = dao2.getDoctorById(ap.getDoctorId());
								%>
								<tr class="today-highlight">
									<td><%= todayCounter++ %></td>
									<td><i class="fa-solid fa-user me-2" style="color: #8b5cf6;"></i><%=ap.getFullName() %></td>
									<td><%= d != null ? d.getFullName() : "N/A" %></td>
									<td>
										<span class="badge" style="background-color: #ffc107; color: #000; padding: 6px 12px; border-radius: 20px;">
											<i class="fa-solid fa-clock me-1"></i><%=ap.getStatus() %>
										</span>
									</td>
								</tr>
								<% } %>
							</tbody>
						</table>
					</div>
				<% } %>
			</div>
		</div>
		
		<!-- All Pending Appointments Section -->
		<div class="card" style="border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); overflow: hidden;">
			<div class="card-header" style="background: linear-gradient(135deg, #f97316, #ea580c); padding: 15px 20px;">
				<h5 class="mb-0 text-white">
					<i class="fa-solid fa-hourglass-half me-2"></i>All Pending Appointments
					<span class="badge bg-white text-dark ms-2"><%=allPendingList.size() %></span>
				</h5>
			</div>
			<div class="card-body" style="background: var(--card-bg);">
				<% if(allPendingList.isEmpty()) { %>
					<div class="text-center py-4">
						<i class="fa-solid fa-check-circle fa-3x mb-3" style="color: #10b981; opacity: 0.5;"></i>
						<p class="text-muted mb-0">No pending appointments</p>
					</div>
				<% } else { %>
					<div class="table-responsive">
						<table class="table table-hover mb-0">
							<thead>
								<tr>
									<th>#</th>
									<th>Patient Name</th>
									<th>Doctor</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<% int allCounter = 1; %>
								<% for(Appointment ap : allPendingList) { 
									Doctor d = dao2.getDoctorById(ap.getDoctorId());
									boolean isToday = ap.getAppoinDate().equals(todayDate);
								%>
								<tr class="<%=isToday ? "today-highlight" : "" %>">
									<td><%= allCounter++ %></td>
									<td><i class="fa-solid fa-user me-2" style="color: var(--primary-color);"></i><%=ap.getFullName() %></td>
									<td><%= d != null ? d.getFullName() : "N/A" %></td>
									<td>
										<span class="badge" style="background-color: #ffc107; color: #000; padding: 6px 12px; border-radius: 20px;">
											<i class="fa-solid fa-clock me-1"></i><%=ap.getStatus() %>
										</span>
									</td>
								</tr>
								<% } %>
							</tbody>
						</table>
					</div>
				<% } %>
			</div>
		</div>
	</div>
	
	<%@include file="component/footer.jsp" %>
	<script src="JS/theme.js"></script>
</body>
</html>