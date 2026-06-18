<%@page import="com.entity.Jobs"%>
<%@page import="java.util.List"%>
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
<title>All Jobs - HireHub</title>

<%@ include file="../all_component/all_css.jsp"%>
</head>
<body>

	<!-- Authentication Guard -->
	<c:if test="${empty adminobj}">
		<c:redirect url="../login.jsp"/>
	</c:if>

	<%@ include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		
		<!-- Page Header -->
		<div class="page-header d-flex flex-wrap justify-content-between align-items-center mb-4">
			<div>
				<h2>Manage Posted Jobs</h2>
				<p>View, edit, and delete job postings currently active on the platform.</p>
			</div>
			<div>
				<a href="add_job.jsp" class="btn btn-success-gradient">
					<i class="fa-solid fa-circle-plus mr-1"></i> Post a New Job
				</a>
			</div>
		</div>

		<!-- Notifications -->
		<c:if test="${not empty sucMsg}">
			<div class="alert alert-custom alert-custom-success mb-4" role="alert">
				<i class="fa-solid fa-circle-check"></i>
				<span>${sucMsg}</span>
			</div>
			<c:remove var="sucMsg" />
		</c:if>

		<%
		String searchTitle = request.getParameter("title");
		String searchCategory = request.getParameter("category");
		String searchLocation = request.getParameter("location");
		
		JobDao dao = new JobDao(DBConnect.getConn());
		List<Jobs> list;
		
		boolean isSearch = (searchTitle != null || searchCategory != null || searchLocation != null);
		if (isSearch) {
			list = dao.getJobsBySearch(searchTitle, searchCategory, searchLocation);
		} else {
			list = dao.getAlljobs();
		}
		%>

		<!-- Search Filters Form Card -->
		<div class="card form-card border-0 shadow-sm p-4 mb-5">
			<h5 class="font-weight-bold mb-3" style="color: var(--dark-color);"><i class="fa-solid fa-filter mr-2 text-primary"></i>Filter Job Listings</h5>
			<form action="view_jobs.jsp" method="get" class="needs-validation" novalidate>
				<div class="form-row">
					<!-- Title -->
					<div class="form-group col-md-4 mb-3 mb-md-0">
						<label class="form-label" style="font-size: 0.85rem;">Job Title</label>
						<input type="text" name="title" class="form-control" placeholder="Search by title..." 
							value="<%= (searchTitle != null) ? searchTitle : "" %>">
					</div>
					<!-- Category -->
					<div class="form-group col-md-3 mb-3 mb-md-0">
						<label class="form-label" style="font-size: 0.85rem;">Category</label>
						<select name="category" class="custom-select">
							<option value="">Choose category...</option>
							<option value="IT" <%= "IT".equals(searchCategory) ? "selected" : "" %>>IT</option>
							<option value="Banking" <%= "Banking".equals(searchCategory) ? "selected" : "" %>>Banking</option>
							<option value="Marketing" <%= "Marketing".equals(searchCategory) ? "selected" : "" %>>Marketing</option>
							<option value="HR" <%= "HR".equals(searchCategory) ? "selected" : "" %>>HR</option>
							<option value="Sales" <%= "Sales".equals(searchCategory) ? "selected" : "" %>>Sales</option>
						</select>
					</div>
					<!-- Location -->
					<div class="form-group col-md-3 mb-3 mb-md-0">
						<label class="form-label" style="font-size: 0.85rem;">Location</label>
						<select name="location" class="custom-select">
							<option value="">Choose location...</option>
							<option value="Ahmedabad" <%= "Ahmedabad".equals(searchLocation) ? "selected" : "" %>>Ahmedabad</option>
							<option value="Surat" <%= "Surat".equals(searchLocation) ? "selected" : "" %>>Surat</option>
							<option value="Rajkot" <%= "Rajkot".equals(searchLocation) ? "selected" : "" %>>Rajkot</option>
							<option value="Vadodara" <%= "Vadodara".equals(searchLocation) ? "selected" : "" %>>Vadodara</option>
							<option value="Remote" <%= "Remote".equals(searchLocation) ? "selected" : "" %>>Remote</option>
						</select>
					</div>
					<!-- Buttons -->
					<div class="form-group col-md-2 d-flex align-items-end mb-0">
						<div class="d-flex w-100 gap-2">
							<button type="submit" class="btn btn-primary-gradient btn-block py-2 flex-grow-1" style="height: 44px;">
								<i class="fa-solid fa-magnifying-glass"></i>
							</button>
							<% if (isSearch) { %>
								<a href="view_jobs.jsp" class="btn btn-light d-flex align-items-center justify-content-center" style="height: 44px; width: 44px; border: 1.5px solid var(--border-color); border-radius: var(--radius-sm);" title="Clear Search">
									<i class="fa-solid fa-arrow-rotate-left text-muted"></i>
								</a>
							<% } %>
						</div>
					</div>
				</div>
			</form>
		</div>

		<!-- Job Listing Cards Grid -->
		<div class="row">

			<%
			if (list == null || list.isEmpty()) {
			%>
				<div class="col-12 text-center py-5">
					<div class="text-muted mb-3" style="font-size: 3rem;">
						<i class="fa-solid fa-circle-question"></i>
					</div>
					<h5 class="text-muted font-weight-bold">No Jobs Found</h5>
					<p class="text-muted mb-0">Try adjusting your search filters to find what you are looking for.</p>
				</div>
			<%
			} else {
				for (Jobs j : list) {
					String statusClass = "badge-status-active";
					String statusIcon = "fa-solid fa-circle-check";
					if (!"Active".equalsIgnoreCase(j.getStatus())) {
						statusClass = "badge-status-inactive";
						statusIcon = "fa-solid fa-circle-xmark";
					}
			%>

			<div class="col-lg-6 mb-4">
				<div class="modern-job-card">
					
					<!-- Header Section -->
					<div class="d-flex align-items-start justify-content-between mb-3">
						<div class="job-icon-container">
							<i class="fa-solid fa-briefcase"></i>
						</div>
						<span class="job-meta-badge <%=statusClass%>">
							<i class="<%=statusIcon%>"></i> <%=j.getStatus()%>
						</span>
					</div>

					<!-- Title and Description -->
					<h4 class="font-weight-bold mb-2 text-dark" style="letter-spacing: -0.3px;"><%=j.getTitle()%></h4>
					<p class="text-muted mb-4" style="font-size: 0.92rem; line-height: 1.5; flex-grow: 1; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;">
						<%=j.getDescription()%>
					</p>

					<!-- Badges Row -->
					<div class="mb-4">
						<span class="job-meta-badge badge-category">
							<i class="fa-solid fa-layer-group"></i> <%=j.getCategory()%>
						</span>
						<span class="job-meta-badge badge-location">
							<i class="fa-solid fa-location-dot"></i> <%=j.getLocation()%>
						</span>
					</div>

					<hr class="my-3" style="border-color: var(--border-color);">

					<!-- Footer Info & Actions -->
					<div class="d-flex justify-content-between align-items-center">
						<span class="text-muted" style="font-size: 0.82rem; font-weight: 500;">
							<i class="fa-regular fa-calendar-days mr-1 text-primary"></i> 
							Published: <%=j.getPdate()%>
						</span>
						
						<div class="d-flex gap-2 align-items-center">
							<a href="job_details.jsp?id=<%=j.getId()%>" 
								class="btn btn-outline-info btn-action-sm mr-2" style="border-color: rgba(13, 202, 240, 0.3); color: #0dcaf0;">
								<i class="fa-solid fa-circle-info mr-1"></i> View Details
							</a>
							<a href="<%=request.getContextPath()%>/admin/edit_job.jsp?id=<%=j.getId()%>" 
								class="btn btn-outline-primary btn-action-sm mr-2" style="border-color: rgba(79, 70, 229, 0.25); color: var(--primary-color);">
								<i class="fa-solid fa-pen-to-square mr-1"></i> Edit
							</a>
							<a  href="<%=request.getContextPath()%>/delete?id=<%=j.getId()%>" 
								class="btn btn-outline-danger btn-action-sm" 
								onclick="return confirm('Are you sure you want to delete this job listing?')">
								<i class="fa-solid fa-trash-can mr-1"></i> Delete
							</a>
						</div>
					</div>

				</div>
			</div>

			<%
				}
			}
			%>

		</div>

	</div>
	
	<%@ include file="../all_component/footer.jsp"%>
</body>
</html>
