<%@page import="com.entity.Doctor"%>
<%@page import="java.util.List"%>
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
<title>User Appointment</title>
<%@include file="component/allcss.jsp" %>
<%-- Own CSS file --%>
<link rel="stylesheet" href="CSS/style.css">
</head>
<body>
	<%@include file="component/navbar.jsp" %>
	
	<div class="container-fluid backImg p-5">
		<p class="text-center fs-2 text-white"></p>
	</div>
	
	<%-- Show Login Required Section for Non-Logged In Users --%>
	<c:if test="${empty userObj}">
		<div class="container p-5">
			<div class="row justify-content-center">
				<div class="col-md-8">
					<div class="card paint-card">
						<div class="card-body text-center p-5">
							<div style="width: 120px; height: 120px; border-radius: 50%; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); display: flex; align-items: center; justify-content: center; margin: 0 auto 30px;">
								<i class="fa-solid fa-calendar-check fa-3x text-white"></i>
							</div>
							<h2 class="mb-3" style="color: var(--text-color);">Book Your Appointment</h2>
							<p class="text-muted mb-4 fs-5">Please login or create an account to book an appointment with our experienced doctors.</p>
							
							<div class="row justify-content-center mb-4">
								<div class="col-md-10">
									<div class="row g-4">
										<div class="col-md-4">
											<div class="p-3" style="background: rgba(16, 185, 129, 0.1); border-radius: 15px;">
												<i class="fa-solid fa-user-doctor fa-2x mb-2" style="color: var(--primary-color);"></i>
												<p class="mb-0 fw-semibold" style="color: var(--text-color);">Expert Doctors</p>
												<small class="text-muted">Qualified specialists</small>
											</div>
										</div>
										<div class="col-md-4">
											<div class="p-3" style="background: rgba(16, 185, 129, 0.1); border-radius: 15px;">
												<i class="fa-solid fa-clock fa-2x mb-2" style="color: var(--primary-color);"></i>
												<p class="mb-0 fw-semibold" style="color: var(--text-color);">Quick Booking</p>
												<small class="text-muted">Easy & fast process</small>
											</div>
										</div>
										<div class="col-md-4">
											<div class="p-3" style="background: rgba(16, 185, 129, 0.1); border-radius: 15px;">
												<i class="fa-solid fa-hospital fa-2x mb-2" style="color: var(--primary-color);"></i>
												<p class="mb-0 fw-semibold" style="color: var(--text-color);">Best Care</p>
												<small class="text-muted">Quality treatment</small>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="d-flex justify-content-center gap-3 flex-wrap">
								<a href="user_login.jsp" class="btn btn-lg text-white px-5" style="background: var(--navbar-bg); border-radius: 12px;">
									<i class="fa-solid fa-right-to-bracket me-2"></i>Login
								</a>
								<a href="signup.jsp" class="btn btn-lg btn-outline-success px-5" style="border-radius: 12px;">
									<i class="fa-solid fa-user-plus me-2"></i>Sign Up
								</a>
							</div>
							
							<p class="mt-4 text-muted">
								<i class="fa-solid fa-shield-halved me-1"></i> 
								Your data is secure with us
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	
	<%-- Show Appointment Form for Logged In Users --%>
	<c:if test="${not empty userObj}">
	<div class="container p-3">
		<div class="row justify-content-center">
			<div class="col-md-8 p-4">
				<div class="card paint-card">
					<div class="card-body">
						<!-- Patient Profile Section at Top -->
						<div class="text-center mb-4">
							<c:choose>
								<c:when test="${not empty userObj.photo}">
									<img src="user_img/${userObj.photo}" alt="Profile Photo" 
										style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 4px solid var(--primary-color); box-shadow: 0 8px 25px rgba(16, 185, 129, 0.3);">
								</c:when>
								<c:otherwise>
									<div style="width: 100px; height: 100px; border-radius: 50%; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 25px rgba(16, 185, 129, 0.3); margin: 0 auto;">
										<i class="fa-solid fa-user fa-3x text-white"></i>
									</div>
								</c:otherwise>
							</c:choose>
							<p class="mt-3 mb-0 fs-5 fw-semibold" style="color: var(--text-color);">Welcome, ${userObj.fullname}</p>
							<small class="text-muted">${userObj.email}</small>
						</div>
						
						<p class="text-center fs-3">Book Appointment</p>
						<c:if test="${not empty succMsg}">
                        	<div class="alert-msg alert-success"><i class="fa-solid fa-circle-check"></i> ${succMsg}</div>
                        	<c:remove var="succMsg" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                        </c:if>
                        
                        <c:if test="${not empty errorMsg}"> <!-- Display error msg in single var but i want errorMsg in red so i used it -->
                        	<div class="alert-msg alert-danger"><i class="fa-solid fa-circle-exclamation"></i> ${errorMsg}</div>
                        	<c:remove var="errorMsg" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                        </c:if>
                        
                        <form class="row g-3" action="addAppointment" method="post">
                        
                        	<input type="hidden" name="userid" value="${userObj.id}">
                        	
                        	<div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-user"></i> Full Name</label>
                                <input type="text" class="form-control" name="fullname" value="${userObj.fullname}" readonly required>
                            </div>
                        
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-venus-mars"></i> Gender</label>
                                <select class="form-control" name="gender" required>
	                                <option value="">--select--</option>
	                                <option value="male">Male</option>
	                                <option value="female">Female</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-cake-candles"></i> Age</label>
                                <input type="number" class="form-control" name="age" placeholder="Enter your age" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-calendar-days"></i> Appointment Date</label>
                                <input type="date" class="form-control" name="appoint_date" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-envelope"></i> Email</label>
                                <input type="email" class="form-control" name="email" value="${userObj.email}" readonly required>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-phone"></i> Phone No</label>
                                <input maxlength="10" type="number" class="form-control" name="phno" placeholder="Enter phone number" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-notes-medical"></i> Diseases</label>
                                <input type="text" class="form-control" name="diseases" placeholder="Enter disease/symptoms" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-user-doctor"></i> Doctor</label>
                                <select class="form-control" name="doct" required>
	                                <option value="">--select--</option>
	                                <% DoctorDao dao = new DoctorDao(DBConnect.getConn());  
	                                	List<Doctor> list = dao.getAllDoctors();
                                		for(Doctor d: list) { 
                                	%>
                                			<option value="<%=d.getId() %>"><%=d.getFullName() %>(<%=d.getSpecialist() %>)</option>
                                	<%}
                                	%>
	                                
                                </select>
                            </div>
                            
                            <div class="col-md-12">
                                <label class="form-label"><i class="fa-solid fa-location-dot"></i> Full Address</label>
                                <textarea name="address" class="form-control" rows="3" placeholder="Enter your full address"></textarea>
                            </div>
                            
                            <button class="col-md-6 offset-md-3 btn text-white" style="background: var(--navbar-bg);"><i class="fa-solid fa-calendar-check me-2"></i>Book Appointment</button>
                            
                       </form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>
	
	<script src="JS/theme.js"></script>
</body>
</html>