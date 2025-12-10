<%@page import="com.entity.Specialist"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.SpecialistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- Bootstrap CSS Include from component --%>
<%@include file="../component/allcss.jsp"%>
<%-- Own CSS file --%>
<link rel="stylesheet" href="../CSS/style.css">
</head>
<body>

	<c:if test="${empty doctorObj}">
        <c:redirect url="../doctor_login.jsp"></c:redirect>
     </c:if>
     
	<%@include file="navbar.jsp" %>

	<div class="container p-4">
        <div class="row">
            <div class="col-md-4">
            	<div class="card paint-card">
            		<p class="text-center fs-3 pt-4">Change Password</p>
            		<c:if test="${not empty succMsg}">
                        	<div class="alert-msg alert-success"><i class="fa-solid fa-circle-check"></i> ${succMsg}</div>
                        	<c:remove var="succMsg" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                        </c:if>
                        
                        <c:if test="${not empty errorMsg}"> <!-- Display error msg in single var but i want errorMsg in red so i used it -->
                        	<div class="alert-msg alert-danger"><i class="fa-solid fa-circle-exclamation"></i> ${errorMsg}</div>
                        	<c:remove var="errorMsg" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                        </c:if>
                        
            		<div class="card-body">
            			<form action="../doctChangePassword" method="post">
            				<div class="mb-3">
            					<label class="form-label"><i class="fa-solid fa-lock"></i> Enter New Password</label>
            					<input type="password" name="newPassword" class="form-control" placeholder="Enter new password" required>
            				</div> 
            				
            				<div class="mb-3">
            					<label class="form-label"><i class="fa-solid fa-key"></i> Enter Old Password</label>
            					<input type="password" name="oldPassword" class="form-control" placeholder="Enter old password" required>
            				</div>
            				
            				<input type="hidden" name="uid" value="${doctorObj.id}">
            				<button class="btn text-white col-md-12" style="background: var(--navbar-bg);"><i class="fa-solid fa-rotate me-2"></i>Change Password</button>
            			</form>
            		</div>
            	</div>
        	</div>
        	<div class="col-md-5 offset-md-2">
        		<div class="card paint-card">
        		<p class="text-center pt-4 fs-3">Edit Profile</p>
        		<c:if test="${not empty succMsgd}">
                	<div class="alert-msg alert-success"><i class="fa-solid fa-circle-check"></i> ${succMsgd}</div>
                	<c:remove var="succMsgd" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                </c:if>
                
                <c:if test="${not empty errorMsgd}"> <!-- Display error msg in single var but i want errorMsg in red so i used it -->
                	<div class="alert-msg alert-danger"><i class="fa-solid fa-circle-exclamation"></i> ${errorMsgd}</div>
                	<c:remove var="errorMsgd" scope="session"/> <!-- Remove the message after refreshing the page  --> 
                </c:if>
                        
        			<div class="card-body">
        				<form action="../doctorUpdateProfile" method="post">
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-user"></i> Full Name</label>
                				<input type="text" name="fullname" class="form-control" value="${doctorObj.fullName }" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-calendar"></i> DOB</label>
                				<input type="date" name="dob" class="form-control" value="${doctorObj.dob }" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-graduation-cap"></i> Qualification</label>
                				<input type="text" name="qualification" class="form-control" value="${doctorObj.qualification }" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-stethoscope"></i> Specialist</label>
                				<select name="spec" class="form-control"  required>
	                				<option>${doctorObj.specialist }</option>
	                				
	                				<% SpecialistDao dao=new SpecialistDao(DBConnect.getConn());
	                					List<Specialist> list = dao.getAllSpecialist();
	                					for(Specialist s:list) {
	                				%>
                    				<option> <%=s.getSpecialistName()%> </option>
                    				<% 
                    				}
	                				%>
	       
                				</select>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-envelope"></i> Email</label>
                				<input type="email" name="email" class="form-control" value="${doctorObj.email }" readonly required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-phone"></i> Mob no</label>
                				<input type="text" name="mobno" class="form-control" value="${doctorObj.mobNo }" required>
                			</div>
                			
                			<input type="hidden" name="id" value="${doctorObj.id }">
                			
                			<button type="submit" class="btn btn-primary col-md-12"><i class="fa-solid fa-pen-to-square me-2"></i>Update Profile</button>
                		</form>
        			</div>
        		</div>
        	</div>
        </div>
    </div>
	<script src="../JS/theme.js"></script>
</body>
</html>