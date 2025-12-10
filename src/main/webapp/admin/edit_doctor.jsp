<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.entity.Specialist"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.SpecialistDao"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>Insert title here</title>
<%-- Bootstrap CSS Include from component --%>
<%@include file="../component/allcss.jsp"%>
<%-- Own CSS file --%>
<link rel="stylesheet" href="../CSS/style.css">
</head>
<body>
	<%@include file="navbar.jsp"%>
	
	<div class="container-fluid p-3">
		<div class="row">
			<div class="col-md-4 offset-md-4">
                <div class="card paint-card">
                	<div class="card-body">
                		<p class="fs-3 text-center">Edit Doctor Details</p>
                		<%-- Error message --%>
                		<c:if test="${not empty errorMsg}">
                    		<div class="alert-msg alert-danger"><i class="fa-solid fa-circle-exclamation"></i> ${errorMsg}</div>
                    		<c:remove var="errorMsg" scope="session" />
                		</c:if>
                		<%-- Success message --%>
                		<c:if test="${not empty succMsg}">
                    		<div class="alert-msg alert-success"><i class="fa-solid fa-circle-check"></i> ${succMsg}</div>
                    		<c:remove var="succMsg" scope="session" />
                		</c:if>
                		
                		<% 
                		int id=Integer.parseInt(request.getParameter("id"));
                		DoctorDao dao2=new DoctorDao(DBConnect.getConn());
                		Doctor d = dao2.getDoctorById(id);
                		%>
                		
                		<form action="../updateDoctor" method="post" enctype="multipart/form-data">
                			<div class="mb-3 text-center">
                				<img src="../doctor_img/<%=d.getPhoto()%>" alt="Doctor Photo" 
                				     class="img-fluid rounded-circle mb-2" 
                				     style="width: 100px; height: 100px; object-fit: cover;"
                				     onerror="this.src='../img/doc_default.jpg'">
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-user"></i> Full Name</label>
                				<input type="text" name="fullname" class="form-control" value="<%=d.getFullName() %>" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-calendar"></i> DOB</label>
                				<input type="date" name="dob" class="form-control" value="<%=d.getDob() %>" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-graduation-cap"></i> Qualification</label>
                				<input type="text" name="qualification" class="form-control" value="<%=d.getQualification() %>" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-stethoscope"></i> Specialist</label>
                				<select name="spec" class="form-control" required>
                					<% SpecialistDao dao=new SpecialistDao(DBConnect.getConn());
                						List<Specialist> list = dao.getAllSpecialist();
                						for(Specialist s:list) {
                							String selected = s.getSpecialistName().equals(d.getSpecialist()) ? "selected" : "";
                					%>
                					<option <%=selected%>><%=s.getSpecialistName()%></option>
                					<% } %>
                					<option>demo</option>
                				</select>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-envelope"></i> Email</label>
                				<input type="email" name="email" class="form-control" value="<%=d.getEmail() %>" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-phone"></i> Mob no</label>
                				<input type="text" name="mobno" class="form-control" value="<%=d.getMobNo() %>" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-lock"></i> Password</label>
                				<input type="text" name="password" class="form-control" value="<%=d.getPassword() %>" required>
                			</div>
                			
                			<div class="mb-3">
                				<label class="form-label"><i class="fa-solid fa-image"></i> Photo (Leave empty to keep current)</label>
                				<input type="file" name="photo" class="form-control" accept="image/*">
                			</div>
                			
                			<input type="hidden" name="id" value="<%=d.getId()%>">
                			<input type="hidden" name="oldPhoto" value="<%=d.getPhoto()%>">
                			
                			<button type="submit" class="btn btn-primary col-md-12"><i class="fa-solid fa-pen-to-square me-2"></i>Update</button>
                		</form>
                	</div>
                </div>
			</div>
		</div>
	</div>
	<script src="../JS/theme.js"></script>
</body>
</html>