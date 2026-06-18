<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.User"%>
<%@ page import="com.dao.UserDao"%>
<%@ page import="com.DB.DBConnect"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!-- Authentication Guard -->
<c:if test="${empty userobj}">
	<c:redirect url="../login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>My Profile - HireHub</title>
<%@ include file="../all_component/all_css.jsp"%>

<style type="text/css">
.profile-card {
	background: var(--white);
	border: 1px solid var(--border-color);
	border-radius: var(--radius-md);
	box-shadow: var(--shadow-sm);
	padding: 30px;
}

.profile-avatar {
	width: 80px;
	height: 80px;
	border-radius: var(--radius-full);
	background: var(--gradient-primary);
	color: var(--white);
	font-size: 2rem;
	font-weight: 700;
	display: flex;
	align-items: center;
	justify-content: center;
	box-shadow: var(--shadow-primary);
	margin: 0 auto 15px auto;
}

.profile-info-item {
	border-bottom: 1px solid var(--border-color);
	padding: 12px 0;
}

.profile-info-item:last-child {
	border-bottom: none;
}

.settings-card {
	background: var(--white);
	border: 1px solid var(--border-color);
	border-radius: var(--radius-md);
	box-shadow: var(--shadow-sm);
	padding: 30px;
	margin-bottom: 30px;
}
</style>
</head>
<body class="bg-light">
	<%@ include file="../all_component/navbar.jsp"%>

	<%
	UserDao userDao = new UserDao(DBConnect.getConn());
	User currentUser = userDao.getUserById(user.getId());
	%>

	<div class="container my-5">
		<div class="page-header mb-4">
			<h2>Account Settings</h2>
			<p>Manage your public profile details and login security settings.</p>
		</div>

		<!-- Status Messages -->
		<div class="row">
			<div class="col-12">
				<c:if test="${not empty sucMsg}">
					<div class="alert alert-custom alert-custom-success mb-4" role="alert">
						<i class="fa-solid fa-circle-check"></i>
						<span>${sucMsg}</span>
					</div>
					<c:remove var="sucMsg" scope="session" />
				</c:if>

				<c:if test="${not empty failMsg}">
					<div class="alert alert-custom alert-custom-danger mb-4" role="alert">
						<i class="fa-solid fa-circle-exclamation"></i>
						<span>${failMsg}</span>
					</div>
					<c:remove var="failMsg" scope="session" />
				</c:if>
			</div>
		</div>

		<div class="row">
			<!-- Profile Card Sidebar -->
			<div class="col-lg-4 mb-4">
				<div class="profile-card text-center">
					<div class="profile-avatar">
						<%= (currentUser != null && currentUser.getFullname() != null) ? currentUser.getFullname().substring(0,1).toUpperCase() : "U" %>
					</div>
					<h4 class="font-weight-bold text-dark mb-1"><%= (currentUser != null) ? currentUser.getFullname() : "" %></h4>
					<p class="text-muted mb-4"><%= (currentUser != null) ? currentUser.getEmail() : "" %></p>

					<div class="text-left border-top pt-3">
						<div class="profile-info-item">
							<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.75rem; text-transform: uppercase;">Highest Qualification</span>
							<span class="font-weight-bold text-dark">
								<i class="fa-solid fa-graduation-cap text-indigo mr-1"></i>
								<%= (currentUser != null) ? currentUser.getQualification() : "" %>
							</span>
						</div>
						<div class="profile-info-item">
							<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.75rem; text-transform: uppercase;">Registration Date</span>
							<span class="font-weight-bold text-dark">
								<i class="fa-regular fa-calendar text-teal mr-1"></i>
								<%= (currentUser != null && currentUser.getRegDate() != null) ? currentUser.getRegDate() : "N/A" %>
							</span>
						</div>
						<div class="profile-info-item">
							<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.75rem; text-transform: uppercase;">Account Status</span>
							<span class="badge badge-success px-2 py-1" style="border-radius: var(--radius-full);">
								<i class="fa-solid fa-circle-check mr-1"></i> Active Candidate
							</span>
						</div>
					</div>
				</div>
			</div>

			<!-- Profile Edit & Password Forms -->
			<div class="col-lg-8">
				<!-- Edit Profile Details Card -->
				<div class="settings-card">
					<h5 class="font-weight-bold text-dark border-bottom pb-3 mb-4">
						<i class="fa-regular fa-id-card text-primary mr-2"></i>Edit Profile Information
					</h5>
					<form action="<%=request.getContextPath()%>/UpdateProfileServlet" method="post" class="needs-validation" novalidate>
						<input type="hidden" name="id" value="<%= (currentUser != null) ? currentUser.getId() : 0 %>">
						
						<!-- Email (Read-Only) -->
						<div class="form-group">
							<label class="form-label">Email Address (Read-Only)</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-light border-right-0 text-muted" style="border: 1.5px solid var(--border-color); border-right: none; height: 44px; width: 44px; justify-content: center; display: flex; align-items: center;">
										<i class="fa-solid fa-envelope"></i>
									</span>
								</div>
								<input type="email" class="form-control bg-light border-left-0" style="height: 44px; border-radius: 0 var(--radius-sm) var(--radius-sm) 0;" value="<%= (currentUser != null) ? currentUser.getEmail() : "" %>" readonly>
							</div>
						</div>

						<!-- Full Name -->
						<div class="form-group">
							<label class="form-label">Full Name</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" style="border: 1.5px solid var(--border-color); border-right: none; height: 44px; width: 44px; justify-content: center; display: flex; align-items: center;">
										<i class="fa-solid fa-user"></i>
									</span>
								</div>
								<input type="text" class="form-control border-left-0" style="height: 44px; border-radius: 0 var(--radius-sm) var(--radius-sm) 0;" name="fullname" value="<%= (currentUser != null) ? currentUser.getFullname() : "" %>" required>
								<div class="invalid-feedback">Please enter your full name.</div>
							</div>
						</div>

						<!-- Qualification -->
						<div class="form-group mb-4">
							<label class="form-label">Highest Qualification</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" style="border: 1.5px solid var(--border-color); border-right: none; height: 44px; width: 44px; justify-content: center; display: flex; align-items: center;">
										<i class="fa-solid fa-graduation-cap"></i>
									</span>
								</div>
								<input type="text" class="form-control border-left-0" style="height: 44px; border-radius: 0 var(--radius-sm) var(--radius-sm) 0;" name="qualification" value="<%= (currentUser != null) ? currentUser.getQualification() : "" %>" required>
								<div class="invalid-feedback">Please enter your qualification.</div>
							</div>
						</div>

						<button type="submit" class="btn btn-primary-gradient py-2">
							<i class="fa-solid fa-floppy-disk mr-1"></i> Update Profile
						</button>
					</form>
				</div>

				<!-- Change Password Card -->
				<div class="settings-card">
					<h5 class="font-weight-bold text-dark border-bottom pb-3 mb-4">
						<i class="fa-solid fa-key text-warning mr-2"></i>Change Password
					</h5>
					<form action="<%=request.getContextPath()%>/ChangePasswordServlet" method="post" id="passwordForm" class="needs-validation" novalidate>
						<input type="hidden" name="id" value="<%= (currentUser != null) ? currentUser.getId() : 0 %>">

						<!-- Current Password -->
						<div class="form-group">
							<label class="form-label">Current Password</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" style="border: 1.5px solid var(--border-color); border-right: none; height: 44px; width: 44px; justify-content: center; display: flex; align-items: center;">
										<i class="fa-solid fa-lock-open"></i>
									</span>
								</div>
								<input type="password" class="form-control border-left-0" style="height: 44px; border-radius: 0 var(--radius-sm) var(--radius-sm) 0;" name="currentPassword" placeholder="Enter current password" required>
								<div class="invalid-feedback">Please enter your current password.</div>
							</div>
						</div>

						<!-- New Password -->
						<div class="form-group">
							<label class="form-label">New Password</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" style="border: 1.5px solid var(--border-color); border-right: none; height: 44px; width: 44px; justify-content: center; display: flex; align-items: center;">
										<i class="fa-solid fa-lock"></i>
									</span>
								</div>
								<input type="password" class="form-control border-left-0" id="newPassword" style="height: 44px; border-radius: 0 var(--radius-sm) var(--radius-sm) 0;" name="newPassword" placeholder="Enter new password" required>
								<div class="invalid-feedback">Please enter your new password.</div>
							</div>
						</div>

						<!-- Confirm Password -->
						<div class="form-group mb-4">
							<label class="form-label">Confirm Password</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" style="border: 1.5px solid var(--border-color); border-right: none; height: 44px; width: 44px; justify-content: center; display: flex; align-items: center;">
										<i class="fa-solid fa-shield-halved"></i>
									</span>
								</div>
								<input type="password" class="form-control border-left-0" id="confirmPassword" style="height: 44px; border-radius: 0 var(--radius-sm) var(--radius-sm) 0;" name="confirmPassword" placeholder="Confirm new password" required>
								<div class="invalid-feedback" id="confirmPasswordFeedback">Please confirm your new password.</div>
							</div>
						</div>

						<button type="submit" class="btn btn-warning text-white bg-warning border-0 font-weight-bold py-2 px-4 shadow-sm" style="border-radius: var(--radius-sm); transition: var(--transition);">
							<i class="fa-solid fa-key mr-1"></i> Change Password
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../all_component/footer.jsp"%>

	<!-- Form validation and password matching scripts -->
	<script>
		(function() {
			'use strict';
			window.addEventListener('load', function() {
				// Bootstrap validation style application
				var forms = document.getElementsByClassName('needs-validation');
				var validation = Array.prototype.filter.call(forms, function(form) {
					form.addEventListener('submit', function(event) {
						if (form.checkValidity() === false) {
							event.preventDefault();
							event.stopPropagation();
						}
						form.classList.add('was-validated');
					}, false);
				});

				// Client side validation checking password equality
				var passwordForm = document.getElementById("passwordForm");
				if(passwordForm) {
					passwordForm.addEventListener("submit", function(event) {
						var newPass = document.getElementById("newPassword").value;
						var confirmPass = document.getElementById("confirmPassword").value;
						var confirmInput = document.getElementById("confirmPassword");
						var feedback = document.getElementById("confirmPasswordFeedback");
						
						if (newPass !== confirmPass) {
							event.preventDefault();
							event.stopPropagation();
							feedback.innerText = "New Password and Confirm Password do not match.";
							confirmInput.classList.add("is-invalid");
							confirmInput.setCustomValidity("Passwords must match.");
						} else {
							confirmInput.classList.remove("is-invalid");
							confirmInput.setCustomValidity("");
						}
					});
				}
			}, false);
		})();
	</script>
</body>
</html>
