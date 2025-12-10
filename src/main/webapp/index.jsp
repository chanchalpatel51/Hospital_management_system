<%@page import="com.db.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- Head Tag Start -->
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Medi Home - Your trusted healthcare partner providing world-class medical services">

<!-- Add favicon here -->
<link rel="icon" type="image/png" href="img/icon/hospital.png">
    
<!-- Title Tag -->
<title>Medi Home</title>
<!--Title Tag End -->

<!-- Bootstrap CSS Include from component -->
<%@include file="component/allcss.jsp"%>

<!-- Own CSS file -->
<link rel="stylesheet" href="CSS/style.css">

</head>
<!-- Head Tag End -->

<!-- Body Tag Start -->
<body>
	<!-- Navbar Include from component -->
	<%@include file="component/navbar.jsp"%>

    <!-- Carousel Start -->
	<div id="carouselExampleIndicators" class="carousel slide"
		data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="img/hos1.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="img/hos2.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="img/hos3.jpg" class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<%-- Carousel End --%>
	
	<%-- Key Features Section Start --%>
	<div class="container mt-5 features-section">
        <h2 class="text-center mb-5 text-gradient">Key Features of our Hospital</h2>
        
        <div class="row">
            <div class="col-md-8 p-md-5 p-3">
            	<div class="row">
            		<div class="col-lg-6 col-md-6 col-sm-12 mb-4">
          		    	<div class="card paint-card feature-card">
          		    		<div class="card-body text-center">
          		    			<i class="fas fa-shield-alt card-icon"></i>
          		    			<p class="fs-5 fw-bold">100% Safety</p>
          		    			<p>A 100% safety hospital is a fully secure and hygienic healthcare environment where all medical, physical, and emergency safety protocols are strictly followed to ensure complete protection of patients, staff, and visitors without any compromise.</p>
          		    		</div>
          		    	</div>
            		</div>
            		
            		<div class="col-lg-6 col-md-6 col-sm-12 mb-4">
          		    	<div class="card paint-card feature-card">
          		    		<div class="card-body text-center">
          		    			<i class="fas fa-leaf card-icon"></i>
          		    			<p class="fs-5 fw-bold">Clean Environment</p>
          		    			<p>A clean environment means a hygienic, well-maintained, and pollution-free surrounding where waste is properly managed, surfaces are sanitized, and air and water remain safe, ensuring good health and comfort for everyone.</p>
          		    		</div>
          		    	</div>
	                </div>

					<div class="col-lg-6 col-md-6 col-sm-12 mb-4">
						<div class="card paint-card feature-card">
							<div class="card-body text-center">
								<i class="fas fa-user-md card-icon"></i>
								<p class="fs-5 fw-bold">Friendly Doctors</p>
								<p>Friendly doctors are health care professionals who treat patients with kindness, respect, clear communication, and supportive behavior, creating a comfortable and trusting environment for better healing.</p>
							</div>
						</div>
					</div>

					<div class="col-lg-6 col-md-6 col-sm-12 mb-4">
						<div class="card paint-card feature-card">
							<div class="card-body text-center">
								<i class="fas fa-microscope card-icon"></i>
								<p class="fs-5 fw-bold">Medical Research</p>
								<p>Medical research is the systematic study of diseases, treatments, and health practices to develop new knowledge, improve patient care, and discover better methods for preventing, diagnosing, and curing illnesses.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4 d-none d-md-flex justify-content-center align-items-center">
          		<img src="img/main_doct.png" class="img-fluid" style="max-height: 600px; object-fit: contain;" alt="Key Features Image">
            </div>
		</div>
</div>
<hr style="border-color: var(--border-color);">
<%-- Key Features Section End --%>

<%-- Our Team Section Start--%>
	<div class="container team-section">
		<h2 class="text-center pb-5 text-gradient">Our Expert Team</h2>
		<div class="row">
            <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                <div class="card paint-card team-card h-100">
                    <div class="card-body text-center">
                        <img src="img/doct1.jpg" alt="Doctor 1" class="img-fluid rounded-circle mt-3" style="width: 190px; height: 190px; object-fit: cover;">
                        <p class="fw-bold fs-5 mt-3 mb-1">Dr. Samuani Simi</p>
                        <p class="text-muted">(CEO &amp; Chairman)</p>
                        <div class="mt-3">
                        	<a href="#" class="text-decoration-none me-2"><i class="fab fa-linkedin" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        	<a href="#" class="text-decoration-none me-2"><i class="fab fa-twitter" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        	<a href="#" class="text-decoration-none"><i class="fas fa-envelope" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        </div>
                  	</div>
              	</div>
          	</div>	
          	
          	<div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                <div class="card paint-card team-card h-100">
                    <div class="card-body text-center">
                        <img src="img/doct2.jpg" alt="Doctor 2" class="img-fluid rounded-circle mt-3" style="width: 190px; height: 190px; object-fit: cover;">
                        <p class="fw-bold fs-5 mt-3 mb-1">Dr. Siva Kumar</p>
                        <p class="text-muted">(Chief Doctor)</p>
                        <div class="mt-3">
                        	<a href="#" class="text-decoration-none me-2"><i class="fab fa-linkedin" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        	<a href="#" class="text-decoration-none me-2"><i class="fab fa-twitter" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        	<a href="#" class="text-decoration-none"><i class="fas fa-envelope" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        </div>
                  	</div>
              	</div>
          	</div>
          	
          	<div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                <div class="card paint-card team-card h-100">
                    <div class="card-body text-center">
                        <img src="img/doct3.jpg" alt="Doctor 3" class="img-fluid rounded-circle mt-3" style="width: 190px; height: 190px; object-fit: cover;">
                        <p class="fw-bold fs-5 mt-3 mb-1">Dr. Mathue Samuel</p>
                        <p class="text-muted">(Chief Doctor)</p>
                        <div class="mt-3">
                        	<a href="#" class="text-decoration-none me-2"><i class="fab fa-linkedin" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        	<a href="#" class="text-decoration-none me-2"><i class="fab fa-twitter" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        	<a href="#" class="text-decoration-none"><i class="fas fa-envelope" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        </div>
                  	</div>
              	</div>
          	</div>
          	
          	<div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                <div class="card paint-card team-card h-100">
                    <div class="card-body text-center">
                        <img src="img/doct4.jpg" alt="Doctor 4" class="img-fluid rounded-circle mt-3" style="width: 190px; height: 190px; object-fit: cover;">
                        <p class="fw-bold fs-5 mt-3 mb-1">Dr. Niuise Paule</p>
                        <p class="text-muted">(Chief Doctor)</p>
                        <div class="mt-3">
                        	<a href="#" class="text-decoration-none me-2"><i class="fab fa-linkedin" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        	<a href="#" class="text-decoration-none me-2"><i class="fab fa-twitter" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        	<a href="#" class="text-decoration-none"><i class="fas fa-envelope" style="color: var(--primary-color); font-size: 1.2rem;"></i></a>
                        </div>
                  	</div>
              	</div>
          	</div>
       	</div>
	</div>	
<%-- Our Team Section End--%>

<%-- Footer Start --%>
	<%@include file="component/footer.jsp"%>
<%-- Footer End --%>

<!-- Theme Toggle Script -->
<script src="JS/theme.js"></script>

</body>
<%-- Body Tag End --%>

</html>