<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Post Job - HireHub</title>

<%@ include file="../all_component/all_css.jsp" %>
</head>
<body>
	
	<!-- Authentication Guard -->
	<%-- <c:if test="${empty adminobj}">
		<c:redirect url="../login.jsp" />
	</c:if> --%>

	<%@include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		<div class="row justify-content-center">
			<div class="col-lg-10">

				<!-- Page Header -->
				<div class="page-header mb-4">
					<h2>Post a New Job</h2>
					<p>Create a job listing with specific category, location, and description requirements.</p>
				</div>

				<!-- Form card -->
				<div class="card form-card border-0 shadow">
					
					<!-- Notifications -->
					<c:if test="${not empty sucMsg}">
						<div class="alert alert-custom alert-custom-success mb-4" role="alert">
							<i class="fa-solid fa-circle-check"></i>
							<span>${sucMsg}</span>
						</div>
						<c:remove var="sucMsg" />
					</c:if>

					<form action="<%=request.getContextPath()%>/AddPostServlet" method="post" class="needs-validation" novalidate>
						
						<!-- Job Title -->
						<div class="form-group mb-4">
							<label class="form-label">Job Title</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text bg-transparent border-right-0 text-muted" 
										style="border: 1.5px solid var(--border-color); border-right: none; border-radius: var(--radius-sm) 0 0 var(--radius-sm); height: 44px; display: flex; align-items: center; justify-content: center; width: 44px;">
										<i class="fa-solid fa-briefcase"></i>
									</span>
								</div>
								<input type="text" name="title" class="form-control border-left-0" 
									style="border-radius: 0 var(--radius-sm) var(--radius-sm) 0; height: 44px;" 
									placeholder="e.g. Senior Java Developer" required>
								<div class="invalid-feedback">Please enter a job title.</div>
							</div>
						</div>

						<!-- Parameters Row -->
						<div class="form-row mb-3">
							
							<!-- Location -->
							<div class="form-group col-md-4 mb-4">
								<label class="form-label">Location</label>
								<select name="location" class="custom-select" style="height: 44px;" required>
									<option value="">Choose location...</option>
									<option value="Ahmedabad">Ahmedabad</option>
									<option value="Surat">Surat</option>
									<option value="Rajkot">Rajkot</option>
									<option value="Vadodara">Vadodara</option>
									<option value="Remote">Remote</option>
								</select>
								<div class="invalid-feedback">Please choose a location.</div>
							</div>

							<!-- Category -->
							<div class="form-group col-md-4 mb-4">
								<label class="form-label">Category</label>
								<select name="category" class="custom-select" style="height: 44px;" required>
									<option value="">Choose category...</option>
									<option value="IT">IT</option>
									<option value="Banking">Banking</option>
									<option value="Marketing">Marketing</option>
									<option value="HR">HR</option>
									<option value="Sales">Sales</option>
								</select>
								<div class="invalid-feedback">Please choose a category.</div>
							</div>

							<!-- Status -->
							<div class="form-group col-md-4 mb-4">
								<label class="form-label">Status</label>
								<select name="status" class="custom-select" style="height: 44px;">
									<option value="Active">Active</option>
									<option value="Inactive">Inactive</option>
								</select>
							</div>

						</div>

						<!-- Description -->
						<div class="form-group mb-4">
							<label class="form-label">Job Description</label>
							<textarea name="description" class="form-control" rows="6" 
								placeholder="Describe core duties, requirements, expectations, and compensation package..." required></textarea>
							<div class="invalid-feedback">Please enter the job description details.</div>
						</div>

						<!-- Action Control Buttons -->
						<div class="d-flex align-items-center justify-content-between pt-3 border-top" style="border-color: var(--border-color) !important;">
							<a href="admin.jsp" class="btn btn-light px-4 py-2 font-weight-bold" style="border-radius: var(--radius-sm);">
								<i class="fa-solid fa-arrow-left mr-1"></i> Back to Dashboard
							</a>
							<button type="submit" class="btn btn-success-gradient px-4 py-2">
								<i class="fa-solid fa-cloud-arrow-up mr-1"></i> Publish Job Listing
							</button>
						</div>

					</form>
				</div>

			</div>
		</div>
	</div>

	<%@include file="../all_component/footer.jsp"%>

	<!-- Form validation script -->
	<script>
		(function() {
			'use strict';
			window.addEventListener('load', function() {
				var forms = document.getElementsByClassName('needs-validation');
				var validation = Array.prototype.filter.call(forms, function(form) {
					form.addEventListener('submit', function(event) {
						if (form.checkValidity() === false) {
							event.preventDefault();
							event.stopPropagation();
						}
						form.classList.add('was-validated');
					}, false);
				});
			}, false);
		})();
	</script>
</body>
</html>