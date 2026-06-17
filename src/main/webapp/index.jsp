<%@ page import="com.DB.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>HireHub - Online Job Portal</title>

<%@include file="all_component/all_css.jsp"%>

<style type="text/css">
.hero-wrapper {
	padding: 120px 0 100px 0;
	background: radial-gradient(circle at 10% 20%, rgba(99, 102, 241, 0.15) 0%, transparent 40%),
	            radial-gradient(circle at 90% 80%, rgba(13, 148, 136, 0.12) 0%, transparent 45%),
	            var(--gradient-dark);
	position: relative;
	color: var(--white);
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	min-height: 80vh;
	display: flex;
	align-items: center;
}

.feature-box {
	background: var(--white);
	border: 1px solid var(--border-color);
	border-radius: var(--radius-md);
	padding: 30px;
	transition: var(--transition);
	box-shadow: var(--shadow-sm);
	height: 100%;
}

.feature-box:hover {
	transform: translateY(-5px);
	box-shadow: var(--shadow-lg);
}

.feature-icon {
	width: 50px;
	height: 50px;
	border-radius: var(--radius-sm);
	background: rgba(79, 70, 229, 0.08);
	color: var(--primary-color);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.25rem;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<!-- Hero Landing Section -->
	<div class="hero-wrapper">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-7 text-center text-lg-left">
					<span class="badge px-3 py-2 text-white font-weight-bold mb-3" style="background: rgba(255,255,255,0.1); border-radius: var(--radius-full); font-size: 0.82rem;">
						<i class="fa-solid fa-circle-check text-success mr-1"></i> Trusted by 10,000+ Professionals
					</span>
					<h1 class="hero-title mb-3">
						Discover Your Next <span style="background: linear-gradient(to right, #6366f1, #06b6d4); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Career Move</span>
					</h1>
					<p class="text-white-50 mb-4" style="font-size: 1.15rem; max-width: 580px; line-height: 1.6;">
						Browse thousands of live job listings across technology, marketing, banking, and management. Your next opportunity is just a search away.
					</p>

					<!-- Action Controls -->
					<div class="d-flex flex-wrap justify-content-center justify-content-lg-start gap-3">
						<a href="<%=request.getContextPath()%>/signup.jsp" class="btn btn-primary-gradient px-4 py-3 mr-3 mb-2">
							<i class="fa-solid fa-user-plus mr-1"></i> Get Started
						</a>
						<a href="<%=request.getContextPath()%>/login.jsp" class="btn btn-custom-outline px-4 py-3 mb-2">
							<i class="fa-solid fa-magnifying-glass mr-1"></i> Search Jobs
						</a>
					</div>
					
					<!-- Database Connection Test Status Badge -->
					<%
					Connection conn = DBConnect.getConn();
					if (conn != null) {
					%>
						<div class="mt-4 pt-2">
							<span class="badge badge-success px-3 py-2" style="border-radius: var(--radius-full); font-size: 0.8rem; background-color: rgba(16, 185, 129, 0.15); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.2);">
								<i class="fa-solid fa-circle-check mr-1 animate-pulse"></i> Engine Online
							</span>
						</div>
					<%
					} else {
					%>
						<div class="mt-4 pt-2">
							<span class="badge badge-danger px-3 py-2" style="border-radius: var(--radius-full); font-size: 0.8rem; background-color: rgba(239, 68, 68, 0.15); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.2);">
								<i class="fa-solid fa-circle-xmark mr-1"></i> Engine Offline
							</span>
						</div>
					<%
					}
					%>
				</div>

				<!-- Visual Representation Card -->
				<div class="col-lg-5 d-none d-lg-block">
					<div class="card p-4 border-0 shadow-lg text-dark" 
						style="border-radius: var(--radius-lg); background: rgba(255, 255, 255, 0.08); border: 1px solid rgba(255, 255, 255, 0.15); backdrop-filter: blur(8px);">
						<div class="card-body">
							<div class="d-flex align-items-center mb-3">
								<div class="rounded-circle mr-3" style="width: 10px; height: 10px; background-color: #ef4444;"></div>
								<div class="rounded-circle mr-3" style="width: 10px; height: 10px; background-color: #f59e0b;"></div>
								<div class="rounded-circle" style="width: 10px; height: 10px; background-color: #10b981;"></div>
							</div>
							
							<h5 class="text-white font-weight-bold mb-3"><i class="fa-solid fa-terminal mr-2 text-indigo"></i>Featured Categories</h5>
							<div class="text-white-50" style="font-size: 0.92rem; font-family: monospace;">
								<p class="mb-2">&gt; IT & Software Engineering</p>
								<p class="mb-2">&gt; Investment Banking</p>
								<p class="mb-2">&gt; Digital Marketing</p>
								<p class="mb-0">&gt; HR & Management</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Core Features Info Container -->
	<div class="container my-5 py-4">
		<div class="row">
			<div class="col-md-4 mb-4">
				<div class="feature-box">
					<div class="feature-icon">
						<i class="fa-solid fa-briefcase"></i>
					</div>
					<h5 class="font-weight-bold" style="color: var(--dark-color);">Find Match Jobs</h5>
					<p class="text-muted mb-0" style="font-size: 0.92rem;">
						Filter listings by location, type, and categories to match your exact skill profile.
					</p>
				</div>
			</div>
			
			<div class="col-md-4 mb-4">
				<div class="feature-box">
					<div class="feature-icon" style="background: rgba(13, 148, 136, 0.08); color: var(--secondary-color);">
						<i class="fa-solid fa-file-circle-check"></i>
					</div>
					<h5 class="font-weight-bold" style="color: var(--dark-color);">Easy Applications</h5>
					<p class="text-muted mb-0" style="font-size: 0.92rem;">
						Apply to job postings instantly and keep track of your submission status seamlessly.
					</p>
				</div>
			</div>

			<div class="col-md-4 mb-4">
				<div class="feature-box">
					<div class="feature-icon" style="background: rgba(245, 158, 11, 0.08); color: #d97706;">
						<i class="fa-solid fa-shield-halved"></i>
					</div>
					<h5 class="font-weight-bold" style="color: var(--dark-color);">Verified Employers</h5>
					<p class="text-muted mb-0" style="font-size: 0.92rem;">
						All jobs posted undergo manual checks to ensure strict authenticity.
					</p>
				</div>
			</div>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
</html>