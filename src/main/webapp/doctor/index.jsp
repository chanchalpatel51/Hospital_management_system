<%@page import="com.entity.Doctor"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.DoctorDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Doctor Dashboard - Medi Home</title>
<%-- Bootstrap CSS Include from component --%>
<%@include file="../component/allcss.jsp" %>
<%-- Own CSS file --%>
<link rel="stylesheet" href="../CSS/style.css">
</head>
<body>
	<c:if test="${empty doctorObj}">
        <c:redirect url="../doctor_login.jsp"></c:redirect>
     </c:if>
	<%@include file="navbar.jsp" %>
	
	<%
		Doctor d = (Doctor) session.getAttribute("doctorObj");
		DoctorDao dao = new DoctorDao(DBConnect.getConn());
	%>

	<div class="container p-5 d-flex align-items-center justify-content-center" style="min-height: calc(100vh - 150px);">
		<div class="row g-4 w-100">
			<div class="col-md-4 offset-md-2">
				<div class="card dashboard-card">
					<div class="card-body d-flex align-items-center justify-content-between">
						<div>
							<h6 class="mb-2">Total Doctors</h6>
							<h2 class="mb-0"><%=dao.countDoctor()%></h2>
						</div>
						<div class="icon-box bg-success">
							<i class="fas fa-user-md fa-2x text-white"></i>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="card dashboard-card">
					<div class="card-body d-flex align-items-center justify-content-between">
						<div>
							<h6 class="mb-2">My Appointments</h6>
							<h2 class="mb-0"><%=dao.countAppointmentByDoctorId(d.getId()) %></h2>
						</div>
						<div class="icon-box bg-primary">
							<i class="fa-regular fa-calendar-check fa-2x text-white"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="../JS/theme.js"></script>
</body>
</html>