<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
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
<title>Patient I-Card - Medi Home</title>
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
		.navbar, .theme-toggle {
			display: none !important;
		}
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
			<h3 style="color: var(--text-color);"><i class="fa-solid fa-id-card me-2" style="color: var(--primary-color);"></i>Patient I-Card</h3>
			<div class="d-flex gap-2">
				<button onclick="printCard()" class="btn text-white" style="background: #3b82f6; border-radius: 10px;">
					<i class="fa-solid fa-print me-2"></i>Print I-Card
				</button>
				<a href="index.jsp" class="btn btn-outline-success" style="border-radius: 10px;">
					<i class="fa-solid fa-arrow-left me-2"></i>Back
				</a>
			</div>
		</div>
		
		<!-- Patient I-Card Section -->
		<div class="row justify-content-center mb-4" id="idCardSection">
			<div class="col-md-6">
				<div class="card" id="patientIdCard" style="border-radius: 15px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.15);">
					<!-- Card Header -->
					<div style="background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); padding: 15px 20px; color: white;">
						<div class="d-flex justify-content-between align-items-center">
							<div>
								<h5 class="mb-0"><i class="fa-solid fa-hospital me-2"></i>Medi Home Hospital</h5>
								<small class="opacity-75">Patient Identity Card</small>
							</div>
							<i class="fa-solid fa-id-card fa-2x"></i>
						</div>
					</div>
					
					<!-- Card Body -->
					<div class="card-body" style="background: var(--card-bg);">
						<div class="row">
							<div class="col-4 text-center">
								<c:choose>
									<c:when test="${not empty userObj.photo}">
										<img src="user_img/${userObj.photo}" alt="Profile Photo" 
											style="width: 100px; height: 100px; border-radius: 10px; object-fit: cover; border: 3px solid var(--primary-color);">
									</c:when>
									<c:otherwise>
										<div style="width: 100px; height: 100px; border-radius: 10px; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); display: flex; align-items: center; justify-content: center; margin: 0 auto;">
											<i class="fa-solid fa-user fa-3x text-white"></i>
										</div>
									</c:otherwise>
								</c:choose>
								<p class="mt-2 mb-0 fw-bold" style="color: var(--primary-color); font-size: 0.9rem;">MRD${1000 + userObj.id}</p>
							</div>
							<div class="col-8">
								<h5 class="fw-bold mb-2" style="color: var(--text-color);">${userObj.fullname}</h5>
								<table style="font-size: 0.85rem;">
									<tr>
										<td style="padding: 3px 10px 3px 0; color: var(--text-color);"><i class="fa-solid fa-envelope me-2" style="color: var(--primary-color);"></i></td>
										<td style="color: var(--text-color);">${userObj.email}</td>
									</tr>
									<tr>
										<td style="padding: 3px 10px 3px 0; color: var(--text-color);"><i class="fa-solid fa-phone me-2" style="color: var(--primary-color);"></i></td>
										<td style="color: var(--text-color);">
											<%
											User cardUser = (User) session.getAttribute("userObj");
											AppointmentDAO cardDao = new AppointmentDAO(DBConnect.getConn());
											List<Appointment> cardList = cardDao.getAllAppointmentByLoginUser(cardUser.getId());
											String phone = "Not Available";
											String address = "Not Available";
											if(!cardList.isEmpty()) {
												phone = cardList.get(0).getPhNo();
												address = cardList.get(0).getAddress();
											}
											%>
											<%= phone %>
										</td>
									</tr>
									<tr>
										<td style="padding: 3px 10px 3px 0; color: var(--text-color);"><i class="fa-solid fa-location-dot me-2" style="color: var(--primary-color);"></i></td>
										<td style="color: var(--text-color); font-size: 0.8rem;"><%= address %></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					
					<!-- Card Footer -->
					<div style="background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); padding: 10px 20px; color: white;">
						<div class="d-flex justify-content-between align-items-center" style="font-size: 0.75rem;">
							<span><i class="fa-solid fa-phone me-1"></i> +91 1234567890</span>
							<span><i class="fa-solid fa-globe me-1"></i> www.medihome.com</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script src="JS/theme.js"></script>
	<script>
		function printCard() {
			var printContents = document.getElementById('patientIdCard').outerHTML;
			var originalContents = document.body.innerHTML;
			document.body.innerHTML = '<div style="display: flex; justify-content: center; align-items: center; min-height: 100vh;">' + printContents + '</div>';
			window.print();
			document.body.innerHTML = originalContents;
			location.reload();
		}
	</script>
</body>
</html>
