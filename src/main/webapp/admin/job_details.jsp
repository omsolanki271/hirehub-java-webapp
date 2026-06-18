<%@page import="com.entity.Jobs"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.dao.JobDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Job Details - HireHub</title>

<%@include file="../all_component/all_css.jsp"%>

<style type="text/css">
.details-card {
	background: var(--white);
	border: 1px solid var(--border-color);
	border-radius: var(--radius-md);
	box-shadow: var(--shadow-lg);
	padding: 40px;
}

.details-header {
	border-bottom: 1px solid var(--border-color);
	padding-bottom: 24px;
	margin-bottom: 30px;
}

.spec-item {
	padding: 15px 20px;
	border-radius: var(--radius-sm);
	background-color: var(--light-bg);
	border: 1px solid var(--border-color);
	height: 100%;
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
		<div class="row justify-content-center">
			<div class="col-lg-10">

				<%
				String idParam = request.getParameter("id");
				if (idParam == null || idParam.isEmpty()) {
					response.sendRedirect("admin/view_jobs.jsp");
					return;
				}
				
				int id = Integer.parseInt(idParam);
				JobDao dao = new JobDao(DBConnect.getConn());
				Jobs j = dao.getEditbyId(id);
				
				if (j == null) {
				%>
					<div class="text-center py-5">
						<i class="fa-solid fa-circle-exclamation text-danger fa-3x mb-3"></i>
						<h5>Job Record Not Found</h5>
						<a href="view_jobs.jsp" class="btn btn-primary-gradient mt-3">Back to Listings</a>
					</div>
				<%
				} else {
					String statusClass = "badge-status-active";
					String statusIcon = "fa-solid fa-circle-check";
					if (!"Active".equalsIgnoreCase(j.getStatus())) {
						statusClass = "badge-status-inactive";
						statusIcon = "fa-solid fa-circle-xmark";
					}
				%>

				<!-- Page Header -->
				<div class="page-header mb-4">
					<h2>Job Specification Details</h2>
					<p>Technical information and metadata associated with Job ID: #<%=j.getId()%></p>
				</div>

				<!-- Details Card -->
				<div class="details-card">
					
					<!-- Header Section -->
					<div class="details-header d-flex flex-wrap justify-content-between align-items-start">
						<div class="mb-3 mb-md-0">
							<h3 class="font-weight-bold text-dark mb-2" style="letter-spacing: -0.5px;"><%=j.getTitle()%></h3>
							<span class="text-muted font-weight-bold" style="font-size: 0.9rem;">
								<i class="fa-regular fa-calendar-days mr-1 text-primary"></i> 
								Published: <%=j.getPdate()%>
							</span>
						</div>
						<span class="job-meta-badge <%=statusClass%> py-2 px-3" style="font-size: 0.88rem;">
							<i class="<%=statusIcon%> mr-1"></i> <%=j.getStatus()%>
						</span>
					</div>

					<!-- Metadata Specs Row -->
					<div class="row mb-5">
						<div class="col-md-6 mb-3 mb-md-0">
							<div class="spec-item">
								<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.78rem; text-transform: uppercase; letter-spacing: 0.5px;">Job Category</span>
								<div class="d-flex align-items-center">
									<i class="fa-solid fa-layer-group text-primary mr-2" style="font-size: 1.15rem;"></i>
									<span class="font-weight-bold text-dark" style="font-size: 1.05rem;"><%=j.getCategory()%></span>
								</div>
							</div>
						</div>
						
						<div class="col-md-6">
							<div class="spec-item">
								<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.78rem; text-transform: uppercase; letter-spacing: 0.5px;">Job Location</span>
								<div class="d-flex align-items-center">
									<i class="fa-solid fa-location-dot text-warning mr-2" style="font-size: 1.15rem;"></i>
									<span class="font-weight-bold text-dark" style="font-size: 1.05rem;"><%=j.getLocation()%></span>
								</div>
							</div>
						</div>
					</div>

					<!-- Description Container -->
					<div class="mb-5">
						<h5 class="font-weight-bold text-dark mb-3"><i class="fa-solid fa-align-left mr-2 text-muted"></i>Detailed Description</h5>
						<div class="p-4 bg-light rounded" style="border: 1px solid var(--border-color); font-size: 0.98rem; line-height: 1.7; color: var(--text-main); white-space: pre-wrap;"><%=j.getDescription()%></div>
					</div>

					<!-- Actions Footer Row -->
					<div class="d-flex flex-wrap justify-content-between align-items-center pt-4 border-top" style="border-color: var(--border-color) !important;">
						<a href="view_jobs.jsp" class="btn btn-light px-4 py-2 font-weight-bold" style="border-radius: var(--radius-sm);">
							<i class="fa-solid fa-arrow-left mr-1"></i> Back to Jobs
						</a>
						
						<div class="d-flex gap-2">
							<a href="edit_job.jsp?id=<%=j.getId()%>" class="btn btn-primary-gradient px-4 py-2 mr-2">
								<i class="fa-solid fa-pen-to-square mr-1"></i> Edit Specifications
							</a>
							<a href="<%=request.getContextPath()%>/delete?id=<%=j.getId()%>" class="btn btn-danger-gradient px-4 py-2" 
								onclick="return confirm('Are you sure you want to delete this job listing?')">
								<i class="fa-solid fa-trash-can mr-1"></i> Delete listing
							</a>
						</div>
					</div>

				</div>

				<%
				}
				%>

			</div>
		</div>
	</div>

	<%@include file="../all_component/footer.jsp"%>
</body>
</html>