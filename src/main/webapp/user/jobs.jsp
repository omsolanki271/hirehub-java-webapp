<%@page import="com.entity.Jobs"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.dao.JobDao"%>
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
<title>Browse Jobs - HireHub</title>
<%@ include file="../all_component/all_css.jsp"%>
</head>
<body class="bg-light">
	<%@ include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		<h2 class="text-center mb-4">Search & Apply for Jobs</h2>

		<%
		String searchTitle = request.getParameter("title");
		String searchCategory = request.getParameter("category");
		String searchLocation = request.getParameter("location");

		JobDao dao = new JobDao(DBConnect.getConn());
		List<Jobs> rawList;

		boolean isSearch = (searchTitle != null || searchCategory != null || searchLocation != null);
		if (isSearch) {
			rawList = dao.getJobsBySearch(searchTitle, searchCategory, searchLocation);
		} else {
			rawList = dao.getActiveJobs();
		}

		// Filter for active status only
		List<Jobs> list = new ArrayList<Jobs>();
		if (rawList != null) {
			for (Jobs j : rawList) {
				if ("Active".equalsIgnoreCase(j.getStatus())) {
					list.add(j);
				}
			}
		}
		%>

		<!-- Simple Search Form -->
		<div class="card p-4 mb-4 shadow-sm">
			<form action="jobs.jsp" method="get">
				<div class="form-row">
					<div class="form-group col-md-4">
						<label for="title">Search by Title</label>
						<input type="text" class="form-control" id="title" name="title" placeholder="Job title..." value="<%= (searchTitle != null) ? searchTitle : "" %>">
					</div>
					<div class="form-group col-md-3">
						<label for="category">Category</label>
						<select class="form-control" id="category" name="category">
							<option value="">All Categories</option>
							<option value="IT" <%= "IT".equals(searchCategory) ? "selected" : "" %>>IT</option>
							<option value="Banking" <%= "Banking".equals(searchCategory) ? "selected" : "" %>>Banking</option>
							<option value="Marketing" <%= "Marketing".equals(searchCategory) ? "selected" : "" %>>Marketing</option>
							<option value="HR" <%= "HR".equals(searchCategory) ? "selected" : "" %>>HR</option>
							<option value="Sales" <%= "Sales".equals(searchCategory) ? "selected" : "" %>>Sales</option>
						</select>
					</div>
					<div class="form-group col-md-3">
						<label for="location">Location</label>
						<select class="form-control" id="location" name="location">
							<option value="">All Locations</option>
							<option value="Ahmedabad" <%= "Ahmedabad".equals(searchLocation) ? "selected" : "" %>>Ahmedabad</option>
							<option value="Surat" <%= "Surat".equals(searchLocation) ? "selected" : "" %>>Surat</option>
							<option value="Rajkot" <%= "Rajkot".equals(searchLocation) ? "selected" : "" %>>Rajkot</option>
							<option value="Vadodara" <%= "Vadodara".equals(searchLocation) ? "selected" : "" %>>Vadodara</option>
							<option value="Remote" <%= "Remote".equals(searchLocation) ? "selected" : "" %>>Remote</option>
						</select>
					</div>
					<div class="form-group col-md-2 d-flex align-items-end">
						<div class="w-100 d-flex gap-2">
							<button type="submit" class="btn btn-primary flex-grow-1">Search</button>
							<% if (isSearch) { %>
								<a href="jobs.jsp" class="btn btn-secondary" title="Reset"><i class="fa-solid fa-arrow-rotate-left"></i></a>
							<% } %>
						</div>
					</div>
				</div>
			</form>
		</div>

		<!-- Jobs List Display -->
		<div class="row">
			<%
			if (list == null || list.isEmpty()) {
			%>
				<div class="col-md-12 text-center py-5">
					<div class="text-muted mb-3" style="font-size: 3rem;">
						<i class="fa-solid fa-circle-question"></i>
					</div>
					<h5 class="text-muted font-weight-bold">No Active Jobs Found</h5>
					<p class="text-muted">Try adjusting your filters or check back later.</p>
				</div>
			<%
			} else {
				for (Jobs j : list) {
			%>
				<div class="col-md-6 mb-4">
					<div class="card shadow-sm h-100">
						<div class="card-body d-flex flex-column">
							<h5 class="card-title font-weight-bold text-dark"><%= j.getTitle() %></h5>
							<h6 class="card-subtitle mb-2 text-muted">Category: <%= j.getCategory() %></h6>
							<p class="card-text text-secondary mb-4" style="flex-grow: 1;">
								Location: <span class="badge badge-info"><%= j.getLocation() %></span><br>
								Published Date: <%= j.getPdate() %>
							</p>
							<div class="text-right">
								<a href="<%= request.getContextPath() %>/one_view.jsp?id=<%= j.getId() %>" class="btn btn-outline-primary btn-sm">
									<i class="fa-solid fa-circle-info mr-1"></i> View Details
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
