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
		<div class="page-header d-flex flex-wrap justify-content-between align-items-center mb-5">
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

		<!-- Job Listing Cards Grid -->
		<div class="row">

			<%
			JobDao dao = new JobDao(DBConnect.getConn());
			List<Jobs> list = dao.getAlljobs();

			if (list == null || list.isEmpty()) {
			%>
				<div class="col-12 text-center py-5">
					<div class="text-muted mb-3" style="font-size: 3rem;">
						<i class="fa-solid fa-folder-open"></i>
					</div>
					<h5 class="text-muted font-weight-bold">No jobs posted yet</h5>
					<p class="text-muted mb-0">Use the "Post a New Job" button to publish your first listing.</p>
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
					<p class="text-muted mb-4" style="font-size: 0.92rem; line-height: 1.5; flex-grow: 1;">
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
						
						<div class="d-flex gap-2">
							<a href="edit_job.jsp?id=<%=j.getId()%>" 
								class="btn btn-outline-primary btn-action-sm mr-2" style="border-color: rgba(79, 70, 229, 0.25); color: var(--primary-color);">
								<i class="fa-solid fa-pen-to-square mr-1"></i> Edit
							</a>
							<a href="delete?id=<%=j.getId()%>" 
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
</body>
</html>
