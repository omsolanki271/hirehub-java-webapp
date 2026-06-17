<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Login - HireHub</title>

<%@include file="all_component/all_css.jsp"%>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="auth-bg">
		<div class="auth-card">
			<div class="text-center mb-4">
				<div class="d-inline-flex align-items-center justify-content-center rounded-circle mb-3 text-white" 
					style="width: 56px; height: 56px; background: var(--gradient-primary); font-size: 1.35rem; box-shadow: var(--shadow-primary);">
					<i class="fa-solid fa-right-to-bracket"></i>
				</div>
				<h3 class="font-weight-bold mb-1" style="color: var(--dark-color); letter-spacing: -0.5px;">Welcome Back</h3>
				<p class="text-muted" style="font-size: 0.95rem;">Enter your credentials to access your dashboard</p>
			</div>

			<!-- Success Notification -->
			<c:if test="${not empty sucMsg}">
				<div class="alert alert-custom alert-custom-success mb-3" role="alert">
					<i class="fa-solid fa-circle-check"></i>
					<span>${sucMsg}</span>
				</div>
				<c:remove var="sucMsg" scope="session" />
			</c:if>

			<!-- Failure Notification -->
			<c:if test="${not empty failMsg}">
				<div class="alert alert-custom alert-custom-danger mb-3" role="alert">
					<i class="fa-solid fa-circle-exclamation"></i>
					<span>${failMsg}</span>
				</div>
				<c:remove var="failMsg" scope="session" />
			</c:if>

			<form action="loginServlet" method="post" class="needs-validation" novalidate>
				
				<!-- Email Address -->
				<div class="form-group mb-3">
					<label class="form-label">Email Address</label>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text bg-transparent border-right-0 text-muted" 
								style="border: 1.5px solid var(--border-color); border-right: none; border-radius: var(--radius-sm) 0 0 var(--radius-sm); height: 44px; width: 44px; justify-content: center; display: flex; align-items: center;">
								<i class="fa-solid fa-envelope"></i>
							</span>
						</div>
						<input type="email" class="form-control border-left-0" 
							style="border-radius: 0 var(--radius-sm) var(--radius-sm) 0; height: 44px;" 
							placeholder="Enter email" name="email" required>
						<div class="invalid-feedback">Please enter a valid email address.</div>
					</div>
				</div>

				<!-- Password -->
				<div class="form-group mb-4">
					<label class="form-label">Password</label>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text bg-transparent border-right-0 text-muted" 
								style="border: 1.5px solid var(--border-color); border-right: none; border-radius: var(--radius-sm) 0 0 var(--radius-sm); height: 44px; width: 44px; justify-content: center; display: flex; align-items: center;">
								<i class="fa-solid fa-lock"></i>
							</span>
						</div>
						<input type="password" class="form-control border-left-0" 
							style="border-radius: 0 var(--radius-sm) var(--radius-sm) 0; height: 44px;" 
							placeholder="Enter password" name="password" required>
						<div class="invalid-feedback">Please enter your password.</div>
					</div>
				</div>

				<!-- Submit Button -->
				<button type="submit" class="btn btn-primary-gradient btn-block py-2 mb-3">
					Sign In
				</button>

				<!-- Alternative link -->
				<div class="text-center mt-4 pt-3 border-top" style="border-color: var(--border-color) !important;">
					<p class="text-muted mb-0" style="font-size: 0.92rem;">
						Don't have an account? 
						<a href="signup.jsp" class="font-weight-bold" style="color: var(--primary-color); text-decoration: none;">
							Sign Up
						</a>
					</p>
				</div>
			</form>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>

	<!-- Form validation script -->
	<script>
		(function() {
			'use strict';
			window.addEventListener('load', function() {
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
			}, false);
		})();
	</script>
</body>
</html>
