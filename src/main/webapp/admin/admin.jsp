<%@page import="com.dao.JobDao"%>
<%@page import="com.DB.DBConnect"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
JobDao dao = new JobDao(DBConnect.getConn());

int totalJobs = dao.getTotalJobs();
int totalUsers = dao.getTotalUsers();
int totalApplications = dao.getTotalApplications();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Admin Dashboard - HireHub</title>

<%@include file="../all_component/all_css.jsp"%>
</head>
<body>

	<!-- Authentication Guard -->
	<%-- <c:if test="${empty adminobj}">
		<c:redirect url="../login.jsp"/>
	</c:if> --%>

	<%@include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		
		<!-- Welcome Header -->
		<div class="page-header mb-5">
			<h2>Welcome Admin, Control Center</h2>
			<p>Monitor statistics, view jobs, and manage registered users.</p>
		</div>

		<!-- Statistics Section -->
		<div class="row mb-5">

			<!-- Total Jobs Card -->
			<div class="col-md-4 mb-4">
				<div class="card dashboard-card dashboard-card-primary">
					<div class="card-body p-0">
						<h5 class="text-white-50 font-weight-bold mb-2">Total Jobs</h5>
						<h2 class="display-4 font-weight-bold mb-0"><%=totalJobs%></h2>
						<i class="fa-solid fa-briefcase dashboard-card-icon"></i>
					</div>
				</div>
			</div>

			<!-- Total Users Card -->
			<div class="col-md-4 mb-4">
				<div class="card dashboard-card dashboard-card-success">
					<div class="card-body p-0">
						<h5 class="text-white-50 font-weight-bold mb-2">Total Users</h5>
						<h2 class="display-4 font-weight-bold mb-0"><%=totalUsers%></h2>
						<i class="fa-solid fa-users dashboard-card-icon"></i>
					</div>
				</div>
			</div>

			<!-- Total Applications Card -->
			<div class="col-md-4 mb-4">
				<div class="card dashboard-card dashboard-card-warning">
					<div class="card-body p-0">
						<h5 class="text-white-50 font-weight-bold mb-2">Total Applications</h5>
						<h2 class="display-4 font-weight-bold mb-0"><%=totalApplications%></h2>
						<i class="fa-solid fa-file-invoice dashboard-card-icon"></i>
					</div>
				</div>
			</div>

		</div>

		<!-- Quick Action Panel -->
		<div class="card form-card border-0 shadow">
			<h4 class="font-weight-bold mb-4" style="color: var(--dark-color);"><i class="fa-solid fa-bolt mr-2 text-warning"></i>Quick Action Portal</h4>
			<div class="row">
				<div class="col-md-4 mb-3">
					<a href="add_job.jsp" class="btn btn-primary-gradient btn-block py-3">
						<i class="fa-solid fa-circle-plus mr-2"></i> Post a New Job
					</a>
				</div>
				<div class="col-md-4 mb-3">
					<a href="view_jobs.jsp" class="btn btn-success-gradient btn-block py-3">
						<i class="fa-solid fa-list-check mr-2"></i> Manage Posted Jobs
					</a>
				</div>
				<div class="col-md-4 mb-3">
					<a href="view_users.jsp" class="btn btn-block py-3 font-weight-bold text-white" 
						style="background: var(--gradient-dark); border: none; box-shadow: var(--shadow-sm); border-radius: var(--radius-sm); transition: var(--transition);">
						<i class="fa-solid fa-users-gear mr-2"></i> View Registered Users
					</a>
				</div>
			</div>
		</div>

	</div>

	<%@include file="../all_component/footer.jsp"%>
</body>
</html>
