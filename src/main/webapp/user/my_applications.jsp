<%@page import="com.entity.ApplyJob"%>
<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.dao.ApplyJobDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>My Applications - HireHub</title>
<%@ include file="../all_component/all_css.jsp"%>
</head>
<body class="bg-light">
	<%@ include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		<h2 class="mb-4">My Job Applications</h2>

		<%
		int userId = (user != null) ? user.getId() : 0;

		ApplyJobDao dao = new ApplyJobDao(DBConnect.getConn());
		List<ApplyJob> list = dao.getApplicationsByUser(userId);
		%>

		<% if (list == null || list.isEmpty()) { %>
			<div class="card p-5 text-center shadow-sm">
				<div class="card-body">
					<div class="text-muted mb-3" style="font-size: 3rem;">
						<i class="fa-solid fa-file-excel"></i>
					</div>
					<h4 class="text-muted font-weight-bold">No Applications Found</h4>
					<p class="text-muted mb-4">You have not submitted applications to any jobs yet.</p>
					<a href="jobs.jsp" class="btn btn-primary">Browse Open Jobs</a>
				</div>
			</div>
		<% } else { %>
			<div class="table-responsive bg-white rounded border shadow-sm">
				<table class="table table-hover mb-0">
					<thead class="thead-dark">
						<tr>
							<th>Job Title</th>
							<th>Category</th>
							<th>Location</th>
							<th>Apply Date</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<% for (ApplyJob aj : list) { 
							String badgeClass = "badge-success";
							if (!"Active".equalsIgnoreCase(aj.getJobStatus())) {
								badgeClass = "badge-danger";
							}
						%>
							<tr>
								<td class="font-weight-bold text-dark"><%= aj.getJobTitle() %></td>
								<td><span class="badge badge-pill badge-light border"><%= aj.getJobCategory() %></span></td>
								<td><%= aj.getJobLocation() %></td>
								<td><%= aj.getApplyDate() %></td>
								<td><span class="badge <%= badgeClass %>"><%= aj.getJobStatus() %></span></td>
								<td>
									<a href="job_details.jsp?id=<%= aj.getJobId() %>" class="btn btn-primary btn-sm">
										<i class="fa-solid fa-eye mr-1"></i> View Job
									</a>
								</td>
							</tr>
						<% } %>
					</tbody>
				</table>
			</div>
		<% } %>
	</div>

	<%@ include file="../all_component/footer.jsp"%>
</body>
</html>
