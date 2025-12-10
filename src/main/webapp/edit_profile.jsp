<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile - Medi Home</title>
<%@include file="component/allcss.jsp" %>
<link rel="stylesheet" href="CSS/style.css">
<style>
	.profile-container {
		max-width: 600px;
		margin: 0 auto;
	}
	.profile-photo-wrapper {
		position: relative;
		width: 150px;
		height: 150px;
		margin: 0 auto 20px;
	}
	.profile-photo {
		width: 150px;
		height: 150px;
		border-radius: 50%;
		object-fit: cover;
		border: 4px solid var(--primary-color);
		box-shadow: 0 8px 25px rgba(16, 185, 129, 0.3);
	}
	.profile-photo-placeholder {
		width: 150px;
		height: 150px;
		border-radius: 50%;
		background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
		display: flex;
		align-items: center;
		justify-content: center;
		box-shadow: 0 8px 25px rgba(16, 185, 129, 0.3);
	}
	.photo-edit-btn {
		position: absolute;
		bottom: 5px;
		right: 5px;
		width: 40px;
		height: 40px;
		border-radius: 50%;
		background: var(--primary-color);
		border: 3px solid var(--card-bg);
		display: flex;
		align-items: center;
		justify-content: center;
		cursor: pointer;
		transition: all 0.3s ease;
	}
	.photo-edit-btn:hover {
		transform: scale(1.1);
		background: var(--secondary-color);
	}
	.section-title {
		font-weight: 700;
		background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	.info-item {
		padding: 15px;
		border-radius: 10px;
		background: var(--card-bg);
		margin-bottom: 10px;
		border: 1px solid rgba(0,0,0,0.1);
	}
	.info-label {
		font-size: 0.85rem;
		color: #888;
		margin-bottom: 5px;
	}
	.info-value {
		font-size: 1.1rem;
		font-weight: 500;
		color: var(--text-color);
	}
</style>
</head>
<body>
	<%@include file="component/navbar.jsp" %>
	
	<c:if test="${empty userObj}">
        <c:redirect url="user_login.jsp"></c:redirect>
    </c:if>
	
	<div class="container-fluid backImg p-5">
		<p class="text-center fs-2 text-white"></p>
	</div>
	
	<div class="container p-4">
		<div class="profile-container">
			<div class="card" style="border-radius: 20px; box-shadow: 0 8px 30px rgba(0,0,0,0.1); overflow: hidden;">
				<div class="card-header text-center py-4" style="background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));">
					<h3 class="text-white mb-0"><i class="fa-solid fa-user-pen me-2"></i>Edit Profile</h3>
				</div>
				<div class="card-body p-4" style="background: var(--card-bg);">
					
					<!-- Success/Error Messages -->
					<c:if test="${not empty succMsg}">
						<div class="alert alert-success alert-dismissible fade show" role="alert">
							<i class="fa-solid fa-check-circle me-2"></i>${succMsg}
							<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
						</div>
						<c:remove var="succMsg" scope="session" />
					</c:if>
					<c:if test="${not empty errorMsg}">
						<div class="alert alert-danger alert-dismissible fade show" role="alert">
							<i class="fa-solid fa-exclamation-circle me-2"></i>${errorMsg}
							<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
						</div>
						<c:remove var="errorMsg" scope="session" />
					</c:if>
					
					<!-- Profile Photo Section -->
					<div class="text-center mb-4">
						<div class="profile-photo-wrapper">
							<c:choose>
								<c:when test="${not empty userObj.photo}">
									<img src="user_img/${userObj.photo}" alt="Profile Photo" class="profile-photo">
								</c:when>
								<c:otherwise>
									<div class="profile-photo-placeholder">
										<i class="fa-solid fa-user fa-4x text-white"></i>
									</div>
								</c:otherwise>
							</c:choose>
							<label for="photoInput" class="photo-edit-btn">
								<i class="fa-solid fa-camera text-white"></i>
							</label>
						</div>
						<h4 class="mt-3" style="color: var(--text-color);">${userObj.fullname}</h4>
						<p class="text-muted"><i class="fa-solid fa-envelope me-1"></i>${userObj.email}</p>
					</div>
					
					<!-- Photo Upload Form -->
					<form action="updateProfilePhoto" method="post" enctype="multipart/form-data" id="photoForm">
						<input type="file" name="photo" id="photoInput" accept="image/*" style="display: none;" onchange="submitForm()">
						<div class="text-center mt-3">
							<label for="photoInput" class="btn text-white" style="background: var(--navbar-bg); border-radius: 10px; cursor: pointer;">
								<i class="fa-solid fa-camera me-2"></i>Change Profile Photo
							</label>
						</div>
					</form>
					
					<!-- User Info Display -->
					<div class="mt-4">
						<h5 class="section-title mb-3" style="-webkit-text-fill-color: var(--primary-color);">
							<i class="fa-solid fa-circle-info me-2"></i>Profile Information
						</h5>
						
						<div class="info-item">
							<div class="info-label"><i class="fa-solid fa-user me-1"></i>Full Name</div>
							<div class="info-value">${userObj.fullname}</div>
						</div>
						
						<div class="info-item">
							<div class="info-label"><i class="fa-solid fa-envelope me-1"></i>Email Address</div>
							<div class="info-value">${userObj.email}</div>
						</div>
						
						<div class="info-item">
							<div class="info-label"><i class="fa-solid fa-id-badge me-1"></i>User ID</div>
							<div class="info-value">#${userObj.id}</div>
						</div>
					</div>
					
					<!-- Action Buttons -->
					<div class="d-flex gap-3 mt-4 justify-content-center flex-wrap">
						<a href="change_password.jsp" class="btn btn-outline-primary" style="border-radius: 10px; padding: 10px 25px;">
							<i class="fa-solid fa-key me-2"></i>Change Password
						</a>
						<a href="view_appointment.jsp" class="btn text-white" style="background: var(--navbar-bg); border-radius: 10px; padding: 10px 25px;">
							<i class="fa-solid fa-calendar-check me-2"></i>My Appointments
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="component/footer.jsp" %>
	<script src="JS/theme.js"></script>
	<script>
		function submitForm() {
			var input = document.getElementById('photoInput');
			if (input.files && input.files[0]) {
				if(confirm('Do you want to update your profile photo?')) {
					document.getElementById('photoForm').submit();
				} else {
					input.value = '';
				}
			}
		}
	</script>
</body>
</html>
