<%@page import="com.entity.Jobs"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.dao.JobDao"%>
<%@page import="com.dao.ApplyJobDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>


<!-- Authentication Guard -->
<%
if (session.getAttribute("userobj") == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Job Details - HireHub</title>
<%@ include file="../all_component/all_css.jsp"%>
</head>
<body class="bg-light">
	<%@ include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		
		<!-- Message Display -->
		<c:if test="${not empty sucMsg}">
			<div class="alert alert-success text-center" role="alert">
				${sucMsg}
			</div>
			<c:remove var="sucMsg" />
		</c:if>
		<c:if test="${not empty failMsg}">
			<div class="alert alert-danger text-center" role="alert">
				${failMsg}
			</div>
			<c:remove var="failMsg" />
		</c:if>

		<%
		int jobId = Integer.parseInt(request.getParameter("id"));
		JobDao jobDao = new JobDao(DBConnect.getConn());
		Jobs j = jobDao.getEditbyId(jobId);
		
		// Use user variable defined in navbar.jsp
		int userId = (user != null) ? user.getId() : 0;
		
		ApplyJobDao applyDao = new ApplyJobDao(DBConnect.getConn());
		boolean alreadyApplied = applyDao.isAlreadyApplied(userId, jobId);
		%>

		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card shadow-sm border-0">
					<div class="card-header bg-primary text-white py-3">
						<h4 class="mb-0 font-weight-bold">Job Details</h4>
					</div>
					<div class="card-body p-4">
						<% if (j == null) { %>
							<div class="text-center py-4">
								<h5 class="text-danger">Job Listing Not Found</h5>
								<a href="jobs.jsp" class="btn btn-secondary mt-3">Back to Jobs</a>
							</div>
						<% } else { %>
							<h3 class="font-weight-bold text-dark mb-3"><%= j.getTitle() %></h3>
							<hr>
							
							<div class="mb-4">
								<h5 class="font-weight-bold text-muted">Job Description</h5>
								<p class="text-secondary" style="white-space: pre-line; line-height: 1.6;"><%= j.getDescription() %></p>
							</div>

							<div class="row mb-4">
								<div class="col-md-6 mb-3">
									<strong class="text-muted d-block">Category</strong>
									<span class="badge badge-pill badge-primary py-2 px-3"><%= j.getCategory() %></span>
								</div>
								<div class="col-md-6 mb-3">
									<strong class="text-muted d-block">Location</strong>
									<span class="badge badge-pill badge-info py-2 px-3"><%= j.getLocation() %></span>
								</div>
								<div class="col-md-6 mb-3">
									<strong class="text-muted d-block">Status</strong>
									<span class="badge badge-pill badge-success py-2 px-3"><%= j.getStatus() %></span>
								</div>
								<div class="col-md-6 mb-3">
									<strong class="text-muted d-block">Publish Date</strong>
									<span class="text-secondary"><%= j.getPdate() %></span>
								</div>
							</div>

							<hr>
							<div class="d-flex justify-content-between align-items-center mt-4">
								<a href="jobs.jsp" class="btn btn-secondary">
									<i class="fa-solid fa-arrow-left mr-1"></i> Back to Jobs
								</a>
								
								<% if (alreadyApplied) { %>
									<button class="btn btn-warning" disabled>
										<i class="fa-solid fa-circle-check mr-1"></i> Already Applied
									</button>
								<% } else { %>
									<a href="<%= request.getContextPath() %>/ApplyJobServlet?jid=<%= j.getId() %>" class="btn btn-success font-weight-bold">
										<i class="fa-solid fa-file-signature mr-1"></i> Apply Job
									</a>
								<% } %>
							</div>
						<% } %>
					</div>
				</div>
			</div>
		</div>

	</div>

	<%@ include file="../all_component/footer.jsp"%>
</body>
</html>
