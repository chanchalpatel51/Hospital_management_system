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
<title>Generate Report - Medi Home</title>
<%@include file="component/allcss.jsp" %>
<link rel="stylesheet" href="CSS/style.css">
<style>
	@media print {
		.no-print {
			display: none !important;
		}
		body {
			background: white !important;
		}
		.print-section {
			box-shadow: none !important;
			border: 1px solid #ddd !important;
		}
		.navbar, .theme-toggle {
			display: none !important;
		}
	}
	.report-header {
		background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
		color: white;
		padding: 30px;
		border-radius: 15px 15px 0 0;
	}
	.report-table th {
		background: rgba(16, 185, 129, 0.1);
		color: var(--text-color);
	}
	.report-table td, .report-table th {
		padding: 12px 15px;
		border-bottom: 1px solid var(--border-color);
	}
	.status-badge {
		padding: 5px 12px;
		border-radius: 15px;
		font-size: 0.8rem;
		font-weight: 600;
	}
	.status-pending {
		background: rgba(245, 158, 11, 0.15);
		color: #f59e0b;
	}
	.status-completed {
		background: rgba(16, 185, 129, 0.15);
		color: #10b981;
	}
	.status-cancelled {
		background: rgba(239, 68, 68, 0.15);
		color: #ef4444;
	}
</style>
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
		<!-- Action Buttons -->
		<div class="d-flex justify-content-between align-items-center mb-4 no-print">
			<h3 style="color: var(--text-color);"><i class="fa-solid fa-file-medical me-2" style="color: var(--primary-color);"></i>Generate Report</h3>
			<div class="d-flex gap-2">
				<button onclick="downloadReport()" class="btn text-white" style="background: #3b82f6; border-radius: 10px;">
					<i class="fa-solid fa-download me-2"></i>Download PDF
				</button>
				<button onclick="window.print()" class="btn text-white" style="background: var(--navbar-bg); border-radius: 10px;">
					<i class="fa-solid fa-print me-2"></i>Print Report
				</button>
				<a href="view_appointment.jsp" class="btn btn-outline-success" style="border-radius: 10px;">
					<i class="fa-solid fa-arrow-left me-2"></i>Back
				</a>
			</div>
		</div>
		
		<!-- Report Section -->
		<div class="card paint-card print-section">
			<!-- Report Header -->
			<div class="report-header">
				<div class="d-flex justify-content-between align-items-center flex-wrap">
					<div>
						<h2 class="mb-1"><i class="fa-solid fa-hospital me-2"></i>Medi Home Hospital</h2>
						<p class="mb-0 opacity-75">Patient Appointment Report</p>
					</div>
					<div class="text-end">
						<p class="mb-0"><i class="fa-solid fa-calendar me-2"></i>Generated on: <%= new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a").format(new java.util.Date()) %></p>
					</div>
				</div>
			</div>
			
			<div class="card-body">
				<!-- Patient Information -->
				<div class="row mb-4 pb-4" style="border-bottom: 2px solid var(--border-color);">
					<div class="col-md-6">
						<h5 style="color: var(--primary-color);"><i class="fa-solid fa-user me-2"></i>Patient Information</h5>
						<table class="mt-3">
							<tr>
								<td style="padding: 5px 15px 5px 0; color: var(--text-color);"><strong>Name:</strong></td>
								<td style="color: var(--text-color);">${userObj.fullname}</td>
							</tr>
							<tr>
								<td style="padding: 5px 15px 5px 0; color: var(--text-color);"><strong>Email:</strong></td>
								<td style="color: var(--text-color);">${userObj.email}</td>
							</tr>
							<tr>
								<td style="padding: 5px 15px 5px 0; color: var(--text-color);"><strong>Patient ID:</strong></td>
								<td style="color: var(--text-color);">MRD${1000 + userObj.id}</td>
							</tr>
						</table>
					</div>
					<div class="col-md-6 text-md-end">
						<c:choose>
							<c:when test="${not empty userObj.photo}">
								<img src="user_img/${userObj.photo}" alt="Profile Photo" 
									style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 3px solid var(--primary-color);">
							</c:when>
							<c:otherwise>
								<div style="width: 100px; height: 100px; border-radius: 50%; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); display: flex; align-items: center; justify-content: center; margin-left: auto;">
									<i class="fa-solid fa-user fa-3x text-white"></i>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<!-- Appointment Summary -->
				<%
				User user = (User) session.getAttribute("userObj");
				AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
				DoctorDao dao2 = new DoctorDao(DBConnect.getConn());
				List<Appointment> list = dao.getAllAppointmentByLoginUser(user.getId());
				
				int totalAppointments = list.size();
				int pendingCount = 0;
				int completedCount = 0;
				int cancelledCount = 0;
				
				for(Appointment ap : list) {
					if("Pending".equals(ap.getStatus())) pendingCount++;
					else if("Completed".equals(ap.getStatus())) completedCount++;
					else cancelledCount++;
				}
				%>
				
				<div class="row mb-4">
					<div class="col-md-3 col-6 mb-3">
						<div class="p-3 text-center" style="background: rgba(59, 130, 246, 0.1); border-radius: 10px;">
							<h3 style="color: #3b82f6;"><%= totalAppointments %></h3>
							<small style="color: var(--text-color);">Total Appointments</small>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-3">
						<div class="p-3 text-center" style="background: rgba(245, 158, 11, 0.1); border-radius: 10px;">
							<h3 style="color: #f59e0b;"><%= pendingCount %></h3>
							<small style="color: var(--text-color);">Pending</small>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-3">
						<div class="p-3 text-center" style="background: rgba(16, 185, 129, 0.1); border-radius: 10px;">
							<h3 style="color: #10b981;"><%= completedCount %></h3>
							<small style="color: var(--text-color);">Completed</small>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-3">
						<div class="p-3 text-center" style="background: rgba(239, 68, 68, 0.1); border-radius: 10px;">
							<h3 style="color: #ef4444;"><%= cancelledCount %></h3>
							<small style="color: var(--text-color);">Cancelled</small>
						</div>
					</div>
				</div>
				
				<!-- Appointments Table -->
				<h5 style="color: var(--primary-color);"><i class="fa-solid fa-list me-2"></i>Appointment Details</h5>
				
				<% if(list.isEmpty()) { %>
					<div class="text-center p-5">
						<i class="fa-solid fa-calendar-xmark fa-3x mb-3" style="color: var(--primary-color); opacity: 0.5;"></i>
						<p style="color: var(--text-color);">No appointments found.</p>
					</div>
				<% } else { %>
				<div class="table-responsive mt-3">
					<table class="table report-table">
						<thead>
							<tr>
								<th>#</th>
								<th>Date</th>
								<th>Doctor</th>
								<th>Specialization</th>
								<th>Disease/Symptoms</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<%
							int count = 1;
							for(Appointment ap : list) {
								Doctor d = dao2.getDoctorById(ap.getDoctorId());
								String statusClass = "status-pending";
								if("Completed".equals(ap.getStatus())) statusClass = "status-completed";
								else if(!"Pending".equals(ap.getStatus())) statusClass = "status-cancelled";
							%>
							<tr>
								<td style="color: var(--text-color);"><%= count++ %></td>
								<td style="color: var(--text-color);"><%= ap.getAppoinDate() %></td>
								<td style="color: var(--text-color);">Dr. <%= d.getFullName() %></td>
								<td style="color: var(--text-color);"><%= d.getSpecialist() %></td>
								<td style="color: var(--text-color);"><%= ap.getDiseases() %></td>
								<td><span class="status-badge <%= statusClass %>"><%= ap.getStatus() %></span></td>
							</tr>
							<% } %>
						</tbody>
					</table>
				</div>
				<% } %>
				
				<!-- Footer -->
				<div class="mt-4 pt-4 text-center" style="border-top: 2px solid var(--border-color);">
					<p class="text-muted mb-1"><i class="fa-solid fa-phone me-2"></i>Contact: +91 1234567890 | <i class="fa-solid fa-envelope me-2"></i>info@medihome.com</p>
					<p class="text-muted mb-0"><i class="fa-solid fa-location-dot me-2"></i>123 Health Street, Medical City, India</p>
					<p class="mt-3 mb-0" style="color: var(--primary-color); font-weight: 600;">Thank you for choosing Medi Home Hospital!</p>
				</div>
			</div>
		</div>
	</div>
	
	<script src="JS/theme.js"></script>
	<!-- html2pdf library for PDF download -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
	<script>
		function downloadReport() {
			const element = document.querySelector('.print-section');
			const patientName = '${userObj.fullname}'.replace(/\s+/g, '_');
			const today = new Date().toISOString().slice(0, 10);
			const filename = 'MediHome_Report_' + patientName + '_' + today + '.pdf';
			
			const opt = {
				margin: 10,
				filename: filename,
				image: { type: 'jpeg', quality: 0.98 },
				html2canvas: { scale: 2, useCORS: true },
				jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
			};
			
			// Show loading indicator
			const btn = event.target.closest('button');
			const originalText = btn.innerHTML;
			btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin me-2"></i>Generating...';
			btn.disabled = true;
			
			html2pdf().set(opt).from(element).save().then(function() {
				btn.innerHTML = originalText;
				btn.disabled = false;
			});
		}
	</script>
</body>
</html>
