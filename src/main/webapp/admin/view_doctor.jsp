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
			
			<div class="col-md-12">
				<div class="card paint-card">
                	<div class="card-body">
                		<p class="fs-3 text-center">Doctor Details</p>
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
                		
                		<!-- Responsive table wrapper to prevent overflow -->
                		<div class="table-responsive">
                			<table class="table table-hover table-bordered table-striped">
                				<thead class="table-primary">
                					<tr>
                						<th scope="col" style="width: 80px;">Photo</th>
                						<th scope="col" style="min-width: 150px;">Full Name</th>
                						<th scope="col" style="width: 120px;">DOB</th>
                						<th scope="col" style="min-width: 150px;">Qualification</th>
                						<th scope="col" style="width: 150px;">Specialist</th>
                						<th scope="col" style="min-width: 200px;">Email</th>
                						<th scope="col" style="width: 130px;">Mob No</th>
                						<th scope="col" style="width: 150px;">Action</th>
                					</tr>
                				</thead>
                				<tbody>
                				<% 
                					DoctorDao dao2 = new com.dao.DoctorDao(DBConnect.getConn());
                					List<Doctor> list2 = dao2.getAllDoctors();
                					for(Doctor d:list2) {
                				%>
                				<tr>
                					<td class="text-center">
                						<img src="../doctor_img/<%=d.getPhoto()%>" alt="Doctor" 
                					         style="width: 50px; height: 50px; object-fit: cover; border-radius: 50%;"
                					         onerror="this.src='../img/doc_default.jpg'">
                					</td>
                					<td style="word-wrap: break-word;"><%=d.getFullName()%></td>
                					<td style="white-space: nowrap;"><%=d.getDob()%></td>
                					<td style="word-wrap: break-word;"><%=d.getQualification()%></td>
                					<td style="word-wrap: break-word;"><%=d.getSpecialist()%></td>
                					<td style="word-wrap: break-word; word-break: break-all;"><%=d.getEmail()%></td>
                					<td style="white-space: nowrap;"><%=d.getMobNo()%></td>
                					<td style="white-space: nowrap;">
                						<a href="edit_doctor.jsp?id=<%=d.getId() %>" class="btn btn-primary btn-sm mb-1">Edit</a>
                						<a href="../deleteDoctor?id=<%=d.getId() %>" class="btn btn-danger btn-sm mb-1">Delete</a>
                					</td>
                				</tr>
                				<% } %>
                				</tbody>
                			</table>
                		</div><!-- End of table-responsive -->
                	</div>
				</div>                                	
			</div>
		</div>
	</div>
	<script src="../JS/theme.js"></script>
</body>
</html>