<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- JSTL core library -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Navbar</title>
<style>
.navbar-dark .navbar-nav .nav-link {
    transition: all 0.3s ease;
}

.navbar-dark .navbar-nav .nav-link:hover {
    color: #a7f3d0 !important;
    transform: translateY(-2px);
}

.theme-switcher {
    margin-left: 15px;
}

.theme-switcher button {
    border: 2px solid rgba(255,255,255,0.3);
    transition: all 0.3s ease;
}

.theme-switcher button:hover {
    border-color: #a7f3d0;
    transform: scale(1.05);
}

@media (max-width: 991px) {
    .theme-switcher {
        margin-left: 0;
        margin-top: 10px;
    }
}
</style>
</head>
<body>
	<!-- Enhanced Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark" style="background: var(--navbar-bg);">
		<div class="container-fluid">
			<a class="navbar-brand fs-2 fw-bold" href="index.jsp">
				<i class="fa-solid fa-hospital"></i> Medi Home
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center">

					<c:if test="${empty userObj }">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="index.jsp"><i class="fas fa-home"></i> HOME</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="pending_appointments.jsp"><i class="fas fa-calendar-check"></i> APPOINTMENTS</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="admin_login.jsp"><i
								class="fa-solid fa-user-shield"></i> ADMIN</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="doctor_login.jsp"><i class="fas fa-user-md"></i> DOCTOR</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="user_appointment.jsp"><i class="fas fa-user-injured"></i> PATIENT</a></li>
					</c:if>

					<c:if test="${not empty userObj }">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="index.jsp"><i class="fas fa-home"></i> HOME</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="user_appointment.jsp"><i class="fas fa-calendar-check"></i> APPOINTMENT</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="view_appointment.jsp"><i class="fas fa-eye"></i> VIEW APPOINTMENT</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="generate_report.jsp"><i class="fas fa-file-medical"></i> GENERATE REPORT</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="icard.jsp"><i class="fas fa-id-card"></i> I-CARD</a></li>

						<div class="dropdown">
							<button class="btn btn-success dropdown-toggle" type="button"
								id="dropdownMenuButton1" data-bs-toggle="dropdown"
								aria-expanded="false">
								<i class="fa-solid fa-circle-user"></i> ${userObj.fullname}
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="edit_profile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
								<li><a class="dropdown-item" href="change_password.jsp"><i class="fas fa-key"></i> Change Password</a></li>
								<li><hr class="dropdown-divider"></li>
								<li><a class="dropdown-item" href="userLogout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
							</ul>
						</div>
					</c:if>

					<!-- Theme Switcher -->
					<li class="nav-item theme-switcher">
						<button class="btn btn-outline-light" onclick="toggleTheme()" id="themeToggleBtn">
							<i class="fas fa-moon" id="themeIcon"></i>
						</button>
					</li>

				</ul>
			</div>
		</div>
	</nav>

</body>
</html>