<%@page import="com.entity.Appointment"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../component/allcss.jsp" %>
<%-- Own CSS file --%>
<link rel="stylesheet" href="../CSS/style.css">
</head>
<body>
	<c:if test="${empty doctorObj}">
        <c:redirect url="../doctor_login.jsp"></c:redirect>
     </c:if>

	<%@include file="navbar.jsp" %>
	
	<div class="container-fluid backImg p-5">
		<p class="text-center fs-2 text-white"></p>
	</div>
	<div class="container p-3">
		<div class="row">
		
			<div class="col-md-6 offset-md-3">
				<div class="card paint-card">
					<div class="card-body">
						<p class="text-center fs-4">Patient Comment</p>
						
						<% int id=Integer.parseInt(request.getParameter("id"));
						AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
						Appointment ap = dao.getAppointmentById(id);
						
						%>
						
						<form class="row" action="../updateStatus" method="post">
							<div class="col-md-6">
								<label class="form-label"><i class="fa-solid fa-user"></i> Patient Name</label>
								<input type="text" readonly value="<%=ap.getFullName() %>" class="form-control">
							</div>
							
							<div class="col-md-6">
								<label class="form-label"><i class="fa-solid fa-cake-candles"></i> Age</label>
								<input type="text" readonly value="<%=ap.getAge() %>" class="form-control">
							</div>
							
							<div class="col-md-6">
								<label class="form-label"><i class="fa-solid fa-phone"></i> Mob No</label>
								<input type="text" readonly value="<%=ap.getPhNo()%>" class="form-control">
							</div>
							
							<div class="col-md-6">
								<label class="form-label"><i class="fa-solid fa-notes-medical"></i> Diseases</label>
								<input type="text" readonly value="<%=ap.getDiseases() %>" class="form-control">
							</div>
							
							<div class="col-md-12 mt-3">
								<label class="form-label"><i class="fa-solid fa-comment-medical"></i> Comment</label>
								<textarea required name="comm" class="form-control" rows="3" placeholder="Enter your medical comment/prescription"></textarea>
							</div>
							
							<input type="hidden" name="id" value="<%=ap.getId()%>">
							<input type="hidden" name="did" value="<%=ap.getDoctorId()%>">
							
							<button class="mt-4 btn btn-primary col-md-6 offset-md-3"><i class="fa-solid fa-paper-plane me-2"></i>Submit Comment</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="../JS/theme.js"></script>
</body>
</html>