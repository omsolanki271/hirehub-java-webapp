<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Admin Profile - HireHub</title>

<%@include file="../all_component/all_css.jsp"%>

<style type="text/css">
.profile-card {
	background: var(--white);
	border: 1px solid var(--border-color);
	border-radius: var(--radius-md);
	box-shadow: var(--shadow-sm);
	padding: 30px;
}
</style>
</head>
<body>

	<!-- Authentication Guard -->
	<%-- <c:if test="${empty adminobj}">
		<c:redirect url="../login.jsp"/>
	</c:if> --%>

	<%@include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		<div class="row">
			
			<!-- Profile Overview Card -->
			<div class="col-lg-4 mb-4">
				<div class="profile-card">
					<div class="text-center mb-4 pb-3 border-bottom" style="border-color: var(--border-color) !important;">
						<div class="rounded-circle d-inline-flex align-items-center justify-content-center text-white font-weight-bold mb-3" 
							style="width: 76px; height: 76px; font-size: 1.85rem; background: var(--gradient-primary); box-shadow: var(--shadow-primary);">
							A
						</div>
						<h4 class="font-weight-bold text-dark mb-1">Administrator</h4>
						<p class="text-muted mb-0" style="font-size: 0.9rem;">${adminobj.email}</p>
					</div>

					<!-- Details -->
					<div class="mb-4">
						<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.8rem; letter-spacing: 0.5px; text-transform: uppercase;">Admin ID</span>
						<div class="d-flex align-items-center py-2 px-3 bg-light rounded" style="border: 1px solid var(--border-color);">
							<i class="fa-solid fa-hashtag text-indigo mr-2"></i>
							<span class="font-weight-bold text-dark" style="font-size: 0.95rem;">${adminobj.id}</span>
						</div>
					</div>

					<div>
						<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.8rem; letter-spacing: 0.5px; text-transform: uppercase;">System Role</span>
						<div class="d-flex align-items-center py-2 px-3 bg-light rounded" style="border: 1px solid var(--border-color);">
							<i class="fa-solid fa-shield-halved text-success mr-2"></i>
							<span class="font-weight-bold text-dark" style="font-size: 0.95rem;">Super Admin</span>
						</div>
					</div>
				</div>
			</div>

			<!-- Password Updates Card -->
			<div class="col-lg-8">
				
				<!-- Page Header -->
				<div class="page-header mb-4">
					<h2>Security settings</h2>
					<p>Change your password to ensure secure authentication credentials.</p>
				</div>

				<!-- Change Password Card -->
				<div class="card form-card border-0 shadow-sm">
					
					<!-- Notifications -->
					<c:if test="${not empty sucMsg}">
						<div class="alert alert-custom alert-custom-success mb-4" role="alert">
							<i class="fa-solid fa-circle-check"></i>
							<span>${sucMsg}</span>
						</div>
						<c:remove var="sucMsg" />
					</c:if>

					<c:if test="${not empty failMsg}">
						<div class="alert alert-custom alert-custom-danger mb-4" role="alert">
							<i class="fa-solid fa-circle-exclamation"></i>
							<span>${failMsg}</span>
						</div>
						<c:remove var="failMsg" />
					</c:if>

					<form action="../changeAdminPassword" method="post" class="needs-validation" novalidate>
						<input type="hidden" name="id" value="${adminobj.id}">
						
						<!-- Current Password -->
						<div class="form-group mb-4">
							<label class="form-label">Current Password</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" 
										style="border: 1.5px solid var(--border-color); border-right: none; border-radius: var(--radius-sm) 0 0 var(--radius-sm); height: 44px; display: flex; align-items: center; justify-content: center; width: 44px;">
										<i class="fa-solid fa-lock"></i>
									</span>
								</div>
								<input type="password" name="currentPassword" class="form-control border-left-0" 
									style="border-radius: 0 var(--radius-sm) var(--radius-sm) 0; height: 44px;" 
									placeholder="Enter current password" required>
								<div class="invalid-feedback">Please enter your current password.</div>
							</div>
						</div>

						<!-- New Password -->
						<div class="form-group mb-4">
							<label class="form-label">New Password</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" 
										style="border: 1.5px solid var(--border-color); border-right: none; border-radius: var(--radius-sm) 0 0 var(--radius-sm); height: 44px; display: flex; align-items: center; justify-content: center; width: 44px;">
										<i class="fa-solid fa-key"></i>
									</span>
								</div>
								<input type="password" name="newPassword" id="newPassword" class="form-control border-left-0" 
									style="border-radius: 0 var(--radius-sm) var(--radius-sm) 0; height: 44px;" 
									placeholder="Create new password" required>
								<div class="invalid-feedback">Please enter a new password.</div>
							</div>
						</div>

						<!-- Confirm Password -->
						<div class="form-group mb-4">
							<label class="form-label">Confirm New Password</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" 
										style="border: 1.5px solid var(--border-color); border-right: none; border-radius: var(--radius-sm) 0 0 var(--radius-sm); height: 44px; display: flex; align-items: center; justify-content: center; width: 44px;">
										<i class="fa-solid fa-circle-check"></i>
									</span>
								</div>
								<input type="password" name="confirmPassword" id="confirmPassword" class="form-control border-left-0" 
									style="border-radius: 0 var(--radius-sm) var(--radius-sm) 0; height: 44px;" 
									placeholder="Confirm new password" required>
								<div class="invalid-feedback">Please confirm your new password.</div>
							</div>
						</div>

						<!-- Submit -->
						<div class="text-right pt-3 border-top" style="border-color: var(--border-color) !important;">
							<button type="submit" class="btn btn-primary-gradient px-4 py-2">
								<i class="fa-solid fa-floppy-disk mr-1"></i> Update Security Credentials
							</button>
						</div>

					</form>
				</div>
			</div>

		</div>
	</div>

	<%@include file="../all_component/footer.jsp"%>

	<!-- Form validation script -->
	<script>
		(function() {
			'use strict';
			window.addEventListener('load', function() {
				var forms = document.getElementsByClassName('needs-validation');
				var validation = Array.prototype.filter.call(forms, function(form) {
					form.addEventListener('submit', function(event) {
						var newPass = document.getElementById('newPassword').value;
						var confirmPass = document.getElementById('confirmPassword').value;
						
						if (form.checkValidity() === false || newPass !== confirmPass) {
							event.preventDefault();
							event.stopPropagation();
							if (newPass !== confirmPass) {
								document.getElementById('confirmPassword').setCustomValidity('Passwords do not match');
							} else {
								document.getElementById('confirmPassword').setCustomValidity('');
							}
						} else {
							document.getElementById('confirmPassword').setCustomValidity('');
						}
						form.classList.add('was-validated');
					}, false);
				});
			}, false);
		})();
	</script>
</body>
</html>
