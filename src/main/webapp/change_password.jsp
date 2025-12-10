<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page isELIgnored="false"%>
 
<%-- Check if user is logged in, redirect if not --%>
<c:if test="${empty userObj}">
    <c:redirect url="user_login.jsp"></c:redirect>
</c:if>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- Bootstrap CSS Include from component --%>
<%@include file="component/allcss.jsp"%>
<%-- Own CSS file --%>
<link rel="stylesheet" href="CSS/style.css">

<title>Insert title here</title>
</head>
<body>
	<%-- Navbar Include from component --%>
	<%@include file="component/navbar.jsp"%>
	
	
	<div class="container p-5">
        <div class="row">
            <div class="col-md-4 offset-md-4">
            	<div class="card paint-card my-5">
            		<p class="text-center fs-3 my-3">Change Password</p>
            		<c:if test="${not empty succMsg}">
                        	<div class="alert-msg alert-success"><i class="fa-solid fa-circle-check"></i> ${succMsg}</div>
                        	<c:remove var="succMsg" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                        </c:if>
                        
                        <c:if test="${not empty errorMsg}"> <!-- Display error msg in single var but i want errorMsg in red so i used it -->
                        	<div class="alert-msg alert-danger"><i class="fa-solid fa-circle-exclamation"></i> ${errorMsg}</div>
                        	<c:remove var="errorMsg" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                        </c:if>
                        
            		<div class="card-body">
            			<form action="userChangePassword" method="post">
            				<div class="mb-3">
            					<label class="form-label"><i class="fa-solid fa-lock"></i> Enter New Password</label>
            					<input type="password" name="newPassword" class="form-control" placeholder="Enter new password" required>
            				</div> 
            				
            				<div class="mb-3">
            					<label class="form-label"><i class="fa-solid fa-key"></i> Enter Old Password</label>
            					<input type="password" name="oldPassword" class="form-control" placeholder="Enter old password" required>
            				</div>
            				
            				<input type="hidden" name="uid" value="${userObj.id}">
            				<button class="btn text-white col-md-12" style="background: var(--navbar-bg);"><i class="fa-solid fa-rotate me-2"></i>Change Password</button>
            			</form>
            		</div>
            	</div>
        	</div>
        </div>
    </div>
    <script src="JS/theme.js"></script>
</body>
</html>