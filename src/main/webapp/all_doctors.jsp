<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Meet our expert doctors at Medi Home">

<!-- Add favicon here -->
<link rel="icon" type="image/png" href="img/icon/hospital.png">

<title>Our Doctors - Medi Home</title>

<!-- Bootstrap CSS Include from component -->
<%@include file="component/allcss.jsp"%>

<!-- Own CSS file -->
<link rel="stylesheet" href="CSS/style.css">

<style>
    .doctor-card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border-radius: 15px;
        overflow: hidden;
    }
    
    .doctor-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
    }
    
    .doctor-img {
        width: 150px;
        height: 150px;
        object-fit: cover;
        border: 4px solid var(--primary-color);
    }
    
    .specialist-badge {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
        padding: 5px 15px;
        border-radius: 20px;
        font-size: 0.85rem;
    }
    
    .doctor-info i {
        color: var(--primary-color);
        width: 20px;
    }
    
    .page-header {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        padding: 60px 0;
        margin-bottom: 50px;
    }
    
    .page-header h1 {
        color: white;
        font-weight: 700;
    }
    
    .page-header p {
        color: rgba(255, 255, 255, 0.9);
    }
    
    .no-doctors {
        text-align: center;
        padding: 50px;
        color: var(--text-muted);
    }
    
    .no-doctors i {
        font-size: 4rem;
        margin-bottom: 20px;
        color: var(--primary-color);
    }
</style>
</head>
<body>
    <!-- Navbar Include from component -->
    <%@include file="component/navbar.jsp"%>
    
    <!-- Page Header -->
    <div class="page-header text-center">
        <div class="container">
            <h1><i class="fas fa-user-md me-2"></i>Our Doctors</h1>
            <p class="lead mb-0">Meet our team of expert healthcare professionals</p>
        </div>
    </div>
    
    <!-- Doctors List Section -->
    <div class="container mb-5">
        <div class="row">
            <%
                DoctorDao dao = new DoctorDao(DBConnect.getConn());
                List<Doctor> doctorList = dao.getAllDoctors();
                
                if(doctorList == null || doctorList.isEmpty()) {
            %>
                <div class="col-12">
                    <div class="no-doctors">
                        <i class="fas fa-user-md"></i>
                        <h3>No Doctors Available</h3>
                        <p>Please check back later for our team of healthcare professionals.</p>
                    </div>
                </div>
            <%
                } else {
                    for(Doctor d : doctorList) {
            %>
                <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                    <div class="card paint-card doctor-card h-100">
                        <div class="card-body text-center p-4">
                            <img src="doctor_img/<%=d.getPhoto()%>" alt="<%=d.getFullName()%>" 
                                 class="img-fluid rounded-circle doctor-img mb-3"
                                 onerror="this.src='img/doc_default.jpg'">
                            <h5 class="fw-bold mb-2"><%=d.getFullName()%></h5>
                            <span class="specialist-badge mb-3 d-inline-block"><%=d.getSpecialist()%></span>
                            
                            <div class="doctor-info text-start mt-3">
                                <p class="mb-2">
                                    <i class="fas fa-graduation-cap me-2"></i>
                                    <strong>Qualification:</strong> <%=d.getQualification()%>
                                </p>
                                <p class="mb-2">
                                    <i class="fas fa-envelope me-2"></i>
                                    <strong>Email:</strong> <%=d.getEmail()%>
                                </p>
                                <p class="mb-0">
                                    <i class="fas fa-phone me-2"></i>
                                    <strong>Contact:</strong> <%=d.getMobNo()%>
                                </p>
                            </div>
                            
                            <div class="mt-4">
                                <a href="user_appointment.jsp" class="btn btn-primary">
                                    <i class="fas fa-calendar-check me-1"></i> Book Appointment
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>
    
    <!-- Footer Include from component -->
    <%@include file="component/footer.jsp"%>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="JS/theme.js"></script>
</body>
</html>
