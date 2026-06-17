
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
<title>Admin Dashboard</title>

<%@include file="../all_component/all_css.jsp"%>

<style>
body{
	background:#f4f6f9;
}

.dashboard{
	margin-top:100px;
}

.card-box{
	border-radius:12px;
	transition:0.3s;
}

.card-box:hover{
	transform:translateY(-5px);
}
</style>

</head>
<body>

<c:if test="${empty adminobj}">
	<c:redirect url="../login.jsp"/>
</c:if>

<%@include file="../all_component/navbar.jsp"%>

<div class="container dashboard">

	<h2 class="text-center mb-4">
		Welcome Admin
	</h2>

	<div class="row">

		<div class="col-md-4">
			<div class="card shadow card-box">
				<div class="card-body text-center">

					<i class="fa-solid fa-briefcase fa-3x text-primary"></i>

					<h3 class="mt-3">
						<%=totalJobs%>
					</h3>

					<h5>Total Jobs</h5>

				</div>
			</div>
		</div>

		<div class="col-md-4">
			<div class="card shadow card-box">
				<div class="card-body text-center">

					<i class="fa-solid fa-users fa-3x text-success"></i>

					<h3 class="mt-3">
						<%=totalUsers%>
					</h3>

					<h5>Total Users</h5>

				</div>
			</div>
		</div>

		<div class="col-md-4">
			<div class="card shadow card-box">
				<div class="card-body text-center">

					<i class="fa-solid fa-file fa-3x text-warning"></i>

					<h3 class="mt-3">
						<%=totalApplications%>
					</h3>

					<h5>Total Applications</h5>

				</div>
			</div>
		</div>

	</div>

</div>

</body>
</html>

