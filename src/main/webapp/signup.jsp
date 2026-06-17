jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration - HireHub</title>

<%@include file="all_component/all_css.jsp"%>

<style>
body {
	background: #f4f6f9;
}

.register-container {
	margin-top: 90px;
	margin-bottom: 40px;
}

.register-card {
	width: 450px;
	border-radius: 12px;
}

.form-control {
	height: 42px;
}
</style>

</head>
<body>

	<%@include file="all_component/navbar.jsp"%>

	<div class="container register-container d-flex justify-content-center">

		<div class="card register-card shadow p-4">

			<div class="text-center mb-3">
				<i class="fa-solid fa-user-plus fa-2x text-primary"></i>
				<h4 class="mt-2">Create Account</h4>
			</div>

			<c:if test="${not empty sucMsg}">
				<div class="alert alert-success">${sucMsg}</div>
				<c:remove var="sucMsg" />
			</c:if>

			<c:if test="${not empty failMsg}">
				<div class="alert alert-danger">${failMsg}</div>
				<c:remove var="failMsg" />
			</c:if>

			<form action="RegisterServlet" method="post">

				<div class="form-group">
					<label>Full Name</label> <input type="text" name="fullname"
						class="form-control" required>
				</div>

				<div class="form-group">
					<label>Qualification</label> <input type="text"
						name="qualification" class="form-control"
						placeholder="BCA, MCA, B.Tech..." required>
				</div>

				<div class="form-group">
					<label>Email Address</label> <input type="email" name="email"
						class="form-control" required>
				</div>

				<div class="form-group">
					<label>Password</label> <input type="password" name="password"
						class="form-control" required>
				</div>

				<button type="submit" class="btn btn-primary btn-block">
					Register</button>

				<div class="text-center mt-3">
					<a href="login.jsp"> Already have an account? Login </a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>

