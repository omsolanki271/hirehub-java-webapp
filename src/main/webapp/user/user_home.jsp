<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>User Dashboard - HireHub</title>

<%@ include file="../all_component/all_css.jsp"%>

<style type="text/css">
.dashboard-banner {
	background: var(--gradient-primary);
	border-radius: var(--radius-md);
	padding: 40px;
	color: var(--white);
	margin-bottom: 40px;
	box-shadow: var(--shadow-primary);
	position: relative;
	overflow: hidden;
}

.dashboard-banner::after {
	content: '';
	position: absolute;
	right: -5%;
	bottom: -30%;
	width: 300px;
	height: 300px;
	background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
	pointer-events: none;
}

.profile-card {
	background: var(--white);
	border: 1px solid var(--border-color);
	border-radius: var(--radius-md);
	box-shadow: var(--shadow-sm);
	padding: 30px;
}

.shortcut-card {
	background: var(--white);
	border: 1px solid var(--border-color);
	border-radius: var(--radius-md);
	box-shadow: var(--shadow-sm);
	padding: 30px;
	transition: var(--transition);
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.shortcut-card:hover {
	transform: translateY(-5px);
	box-shadow: var(--shadow-lg);
}

.shortcut-icon {
	width: 50px;
	height: 50px;
	border-radius: var(--radius-sm);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.35rem;
	margin-bottom: 20px;
}
</style>
</head>
<body>

	<!-- Authentication Guard -->
	<c:if test="${empty userobj}">
		<c:redirect url="../login.jsp" />
	</c:if>

	<%@ include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		
		<!-- Welcome Dashboard Banner -->
		<div class="dashboard-banner">
			<div class="row align-items-center">
				<div class="col-md-8 text-center text-md-left mb-3 mb-md-0">
					<h2 class="font-weight-bold mb-1">Hello, ${userobj.fullname}!</h2>
					<p class="mb-0 text-white-50" style="font-size: 1.05rem;">Welcome back to your job application command center. Browse jobs or track your submittals.</p>
				</div>
				<div class="col-md-4 text-center text-md-right">
					<span class="badge badge-light px-4 py-2 font-weight-bold" style="border-radius: var(--radius-full); font-size: 0.85rem; color: var(--primary-color);">
						<i class="fa-solid fa-circle-user mr-1 text-success"></i> Candidate Account
					</span>
				</div>
			</div>
		</div>

		<div class="row">
			
			<!-- Profile Sidebar summary -->
			<div class="col-lg-4 mb-4">
				<div class="profile-card">
					<div class="text-center mb-4 pb-3 border-bottom" style="border-color: var(--border-color) !important;">
						<div class="rounded-circle d-inline-flex align-items-center justify-content-center text-white font-weight-bold mb-3" 
							style="width: 76px; height: 76px; font-size: 1.85rem; background: var(--gradient-primary); box-shadow: var(--shadow-primary);">
							<%= ((User)session.getAttribute("userobj")).getFullname() != null ? ((User)session.getAttribute("userobj")).getFullname().substring(0,1).toUpperCase() : "U" %>
						</div>
						<h4 class="font-weight-bold text-dark mb-1">${userobj.fullname}</h4>
						<p class="text-muted mb-0" style="font-size: 0.9rem;">${userobj.email}</p>
					</div>

					<!-- Profile Metadata -->
					<div class="mb-2">
						<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.8rem; letter-spacing: 0.5px; text-transform: uppercase;">Highest Qualification</span>
						<div class="d-flex align-items-center py-2 px-3 bg-light rounded" style="border: 1px solid var(--border-color);">
							<i class="fa-solid fa-graduation-cap text-indigo mr-2"></i>
							<span class="font-weight-bold text-dark" style="font-size: 0.95rem;">${userobj.qualification}</span>
						</div>
					</div>

					<div class="mt-4 pt-2 border-top" style="border-color: var(--border-color) !important;">
						<span class="text-muted d-block font-weight-bold mb-1" style="font-size: 0.8rem; letter-spacing: 0.5px; text-transform: uppercase;">Application Engine Status</span>
						<span class="badge badge-success px-3 py-2 mt-1" style="border-radius: var(--radius-full); font-size: 0.8rem; background-color: rgba(16, 185, 129, 0.12); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.15);">
							<i class="fa-solid fa-circle-check mr-1"></i> Ready to Apply
						</span>
					</div>
				</div>
			</div>

			<!-- Dashboard Action Grid -->
			<div class="col-lg-8">
				<div class="row">
					
					<!-- Browse Jobs card -->
					<div class="col-md-6 mb-4">
						<div class="shortcut-card">
							<div>
								<div class="shortcut-icon" style="background: rgba(79, 70, 229, 0.08); color: var(--primary-color);">
									<i class="fa-solid fa-briefcase"></i>
								</div>
								<h4 class="font-weight-bold text-dark mb-2">Browse Jobs</h4>
								<p class="text-muted mb-4" style="font-size: 0.92rem; line-height: 1.5;">
									Search for vacancies, review requirements, salaries, and filter listings by location or type.
								</p>
							</div>
							<a href="jobs.jsp" class="btn btn-primary-gradient btn-block py-2">
								<i class="fa-solid fa-arrow-up-right-from-square mr-1"></i> Search Openings
							</a>
						</div>
					</div>

					<!-- My Applications card -->
					<div class="col-md-6 mb-4">
						<div class="shortcut-card">
							<div>
								<div class="shortcut-icon" style="background: rgba(13, 148, 136, 0.08); color: var(--secondary-color);">
									<i class="fa-solid fa-file-invoice"></i>
								</div>
								<h4 class="font-weight-bold text-dark mb-2">My Applications</h4>
								<p class="text-muted mb-4" style="font-size: 0.92rem; line-height: 1.5;">
									Track the response status of jobs you have submitted resumes to and inspect your timeline.
								</p>
							</div>
							<a href="#" class="btn btn-success-gradient btn-block py-2">
								<i class="fa-solid fa-list-check mr-1"></i> Check Submissions
							</a>
						</div>
					</div>

				</div>
			</div>

		</div>

	</div>

	<%@ include file="../all_component/footer.jsp"%>
</body>
</html>
