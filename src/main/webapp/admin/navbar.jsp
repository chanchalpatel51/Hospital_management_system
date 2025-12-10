<!-- JSTL core library -->
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page isELIgnored="false"%>

 <nav class="navbar navbar-expand-lg navbar-dark" style="background: var(--navbar-bg);">
		<div class="container-fluid">
			<a class="navbar-brand fs-2 fw-bold" href="index.jsp"><i class="fa-solid fa-hospital"></i> Medi Home</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active" href="index.jsp"><i class="fas fa-home"></i> HOME</a></li>
					<li class="nav-item"><a class="nav-link active" href="doctor.jsp"><i class="fas fa-user-md"></i> DOCTOR</a></li>
					<li class="nav-item"><a class="nav-link active" href="view_doctor.jsp"><i class="fas fa-eye"></i> VIEW DOCTOR</a></li>
					<li class="nav-item"><a class="nav-link active" href="patient.jsp"><i class="fas fa-users"></i> PATIENT</a></li>
				</ul>
				
				<div class="d-flex align-items-center">
					<button class="btn btn-outline-light me-2" onclick="toggleTheme()" id="themeToggleBtn">
						<i class="fas fa-moon" id="themeIcon"></i>
					</button>
					<div class="dropdown">
						<button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" data-bs-boundary="viewport">
							<i class="fas fa-user-shield"></i> Admin
						</button>
						<ul class="dropdown-menu dropdown-menu-end" aria-labeledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="../adminLogout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
						</ul>
					</div>
           		</div>
			</div>
		</div>
	</nav>