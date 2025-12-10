<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.DoctorDao"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Medi Home</title>
<%-- Bootstrap CSS Include from component --%>
<%@include file="../component/allcss.jsp"%>
<%-- Own CSS file --%>
<link rel="stylesheet" href="../CSS/style.css">
</head>
<body>
	<%@include file="navbar.jsp"%>

	<c:if test="${empty adminObj}">
		<c:redirect url="../admin_login.jsp"></c:redirect>>
</c:if>

	<div class="container p-5">
		<h2 class="text-center mb-4" style="font-weight: 700; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; letter-spacing: 1px; text-transform: uppercase;">
			<i class="fa-solid fa-gauge-high me-2" style="-webkit-text-fill-color: var(--primary-color);"></i>Admin Dashboard
		</h2>
		<c:if test="${not empty errorMsg}">
			<div class="fs-3 text-center text-danger" role="alert">${errorMsg}</div>
			<c:remove var="errorMsg" scope="session" />
		</c:if>
		<c:if test="${not empty succMsg}">
			<div class="fs-3 text-center text-success" role="alert">${succMsg}</div>
			<c:remove var="succMsg" scope="session" />
		</c:if>
		
		<%
			DoctorDao dao = new DoctorDao(DBConnect.getConn());
			AppointmentDAO apDao = new AppointmentDAO(DBConnect.getConn());
			List<Appointment> recentList = apDao.getRecentAppointments(5);
		%>

		<div class="row g-4">
			<div class="col-md-4">
				<div class="card dashboard-card">
					<div class="card-body">
						<div class="d-flex align-items-center justify-content-between">
							<div>
								<h6 class="text-muted mb-1">Total Doctors</h6>
								<h2 class="fw-bold mb-0"><%=dao.countDoctor() %></h2>
							</div>
							<div class="icon-box bg-primary">
								<i class="fa-solid fa-user-doctor fa-2x text-white"></i>
							</div>
						</div>
						<div class="mt-3">
							<span class="badge bg-success-light text-success"><i class="fa-solid fa-arrow-up me-1"></i>Active</span>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card dashboard-card">
					<div class="card-body">
						<div class="d-flex align-items-center justify-content-between">
							<div>
								<h6 class="text-muted mb-1">Total Users</h6>
								<h2 class="fw-bold mb-0"><%=dao.countUser() %></h2>
							</div>
							<div class="icon-box bg-success">
								<i class="fa-solid fa-users fa-2x text-white"></i>
							</div>
						</div>
						<div class="mt-3">
							<span class="badge bg-info-light text-info"><i class="fa-solid fa-chart-line me-1"></i>Growing</span>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card dashboard-card">
					<div class="card-body">
						<div class="d-flex align-items-center justify-content-between">
							<div>
								<h6 class="text-muted mb-1">Total Appointments</h6>
								<h2 class="fw-bold mb-0"><%=dao.countAppointment() %></h2>
							</div>
							<div class="icon-box bg-warning">
								<i class="fa-solid fa-calendar-check fa-2x text-white"></i>
							</div>
						</div>
						<div class="mt-3">
							<span class="badge bg-warning-light text-warning"><i class="fa-solid fa-clock me-1"></i>Scheduled</span>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card dashboard-card">
					<div class="card-body">
						<div class="d-flex align-items-center justify-content-between">
							<div>
								<h6 class="text-muted mb-1">Pending Appointments</h6>
								<h2 class="fw-bold mb-0"><%=apDao.countPendingAppointment() %></h2>
							</div>
							<div class="icon-box" style="background: #f97316;">
								<i class="fa-solid fa-hourglass-half fa-2x text-white"></i>
							</div>
						</div>
						<div class="mt-3">
							<span class="badge" style="background: rgba(249, 115, 22, 0.15); color: #f97316;"><i class="fa-solid fa-exclamation me-1"></i>Needs Attention</span>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card dashboard-card">
					<div class="card-body">
						<div class="d-flex align-items-center justify-content-between">
							<div>
								<h6 class="text-muted mb-1">Today's Appointments</h6>
								<h2 class="fw-bold mb-0"><%=apDao.countTodayAppointment() %></h2>
							</div>
							<div class="icon-box" style="background: #8b5cf6;">
								<i class="fa-solid fa-calendar-day fa-2x text-white"></i>
							</div>
						</div>
						<div class="mt-3">
							<span class="badge" style="background: rgba(139, 92, 246, 0.15); color: #8b5cf6;"><i class="fa-solid fa-bell me-1"></i>Today</span>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card dashboard-card cursor-pointer" data-bs-toggle="modal" data-bs-target="#exampleModal">
					<div class="card-body">
						<div class="d-flex align-items-center justify-content-between">
							<div>
								<h6 class="text-muted mb-1">Specialists</h6>
								<h2 class="fw-bold mb-0"><%=dao.countSpecialist() %></h2>
							</div>
							<div class="icon-box bg-danger">
								<i class="fa-solid fa-stethoscope fa-2x text-white"></i>
							</div>
						</div>
						<div class="mt-3">
							<span class="badge bg-primary-light text-primary"><i class="fa-solid fa-plus me-1"></i>Add New</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="../addSpecialist" method="post">
						<div class="form-group">
                            <label>Enter Specialist Name:</label> 
                            <input type="text" name="specName" class="form-control mt-2">
                        </div>
                        <div class="text-center mt-3">
                        	<button type="submit" class="btn btn-primary">Add</button>
                        </div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<script src="../JS/theme.js"></script>
</body>
</html>