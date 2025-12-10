<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- JSTL core library -->
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Registration - Medi Home</title>
<%@include file="component/allcss.jsp" %> 
<%-- Own CSS file --%>
<link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <%-- Navbar Include from component --%>
    <%@include file="component/navbar.jsp" %>
    
    <div class="container p-5">
   		<div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card paint-card">
                    <div class="card-body">
                    	<div class="text-center mb-3">
                    		<div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3); margin: 0 auto;">
   								<i class="fa-solid fa-user-plus fa-2x text-white"></i>
   							</div>
                    	</div>
                    	<p class="fs-3 fw-semibold text-center">Patient Registration</p>
                    	 
                        <c:if test="${not empty succMsg}">
                        	<div class="alert-msg alert-success"><i class="fa-solid fa-circle-check"></i> ${succMsg}</div>
                        	<c:remove var="succMsg" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                        </c:if>
                        
                        <c:if test="${not empty errorMsg}"> <!-- Display error msg in single var but i want errorMsg in red so i used it -->
                        	<div class="alert-msg alert-danger"><i class="fa-solid fa-circle-exclamation"></i> ${errorMsg}</div>
                        	<c:remove var="errorMsg" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                        </c:if>
                        
                        <form action="user_register" method="post" enctype="multipart/form-data">
                        	<div class="mb-3">
                                <label for="fullname" class="form-label"><i class="fa-solid fa-user"></i> Fullname</label>
                                <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Enter your full name" required>
                            </div>
                        
                            <div class="mb-3">
                                <label for="email" class="form-label"><i class="fa-solid fa-envelope"></i> Email address</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label"><i class="fa-solid fa-lock"></i> Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="photo" class="form-label"><i class="fa-solid fa-camera"></i> Profile Photo</label>
                                <input type="file" class="form-control" id="photo" name="photo" accept="image/*" onchange="previewPhoto(this)">
                            </div>
                            
                            <button type="submit" class="btn btn-custom col-md-12"><i class="fa-solid fa-user-plus me-2"></i>Register</button>
                       </form>
                       <br>
                       <p class="text-center">Already have an account? <a href="user_login.jsp" class="text-decoration-none" style="color: var(--primary-color); font-weight: 600;">Login here</a></p>
                       
                	</div>
            	</div>
        	</div>
    	</div>
	
	<script src="JS/theme.js"></script>
</body>
</html>