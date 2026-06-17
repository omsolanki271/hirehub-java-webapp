<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard - HireHub</title>

<%@ include file="../all_component/all_css.jsp"%>

<style>
body {
	background-color: #f4f6f9;
}

.dashboard-container {
	margin-top: 90px;
}

.card-box {
	border-radius: 12px;
	transition: 0.3s;
}

.card-box:hover {
	transform: translateY(-5px);
}
</style>

</head>
<body>

	<c:if test="${empty userobj}">
		<c:redirect url="../login.jsp" />
	</c:if>

	<%@ include file="../all_component/navbar.jsp"%>

	<div class="container dashboard-container">

		<div class="text-center mb-4">
			<h2>Welcome ${userobj.fullname}</h2>
			<p class="text-muted">User Dashboard</p>
		</div>

		<div class="row">

			<div class="col-md-4">
				<div class="card shadow card-box">
					<div class="card-body text-center">
						<i class="fa-solid fa-briefcase fa-3x text-primary"></i>
						<h4 class="mt-3">View Jobs</h4>
						<p>Browse available jobs</p>

						<a href="#" class="btn btn-primary">
							View Jobs
						</a>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card shadow card-box">
					<div class="card-body text-center">
						<i class="fa-solid fa-file-circle-check fa-3x text-success"></i>
						<h4 class="mt-3">My Applications</h4>
						<p>Check applied jobs</p>

						<a href="#" class="btn btn-success">
							My Applications
						</a>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card shadow card-box">
					<div class="card-body text-center">
						<i class="fa-solid fa-user fa-3x text-warning"></i>
						<h4 class="mt-3">Profile</h4>
						<p>Manage your profile</p>

						<a href="#" class="btn btn-warning text-white">
							Profile
						</a>
					</div>
				</div>
			</div>

		</div>

	</div>

</body>
</html>
