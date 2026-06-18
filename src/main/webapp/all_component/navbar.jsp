<%@page import="com.entity.Admin"%>
<%@page import="com.entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<%
Admin admin = (Admin) session.getAttribute("adminobj");
User user = (User) session.getAttribute("userobj");

String currentUri = request.getRequestURI();
String pageTitle = "HireHub Admin Panel";
String activeTab = "";

if (currentUri.endsWith("admin.jsp")) {
	pageTitle = "Admin Dashboard";
	activeTab = "dashboard";
} else if (currentUri.endsWith("add_job.jsp")) {
	pageTitle = "Post a New Job";
	activeTab = "add_job";
} else if (currentUri.endsWith("view_jobs.jsp") || currentUri.endsWith("edit_job.jsp")) {
	pageTitle = "Manage Jobs";
	activeTab = "view_jobs";
} else if (currentUri.endsWith("active_jobs.jsp")) {
	pageTitle = "Active Jobs";
	activeTab = "active_jobs";
} else if (currentUri.endsWith("inactive_jobs.jsp")) {
	pageTitle = "Inactive Jobs";
	activeTab = "inactive_jobs";
} else if (currentUri.endsWith("view_users.jsp")) {
	pageTitle = "Registered Users";
	activeTab = "view_users";
} else if (currentUri.endsWith("view_applicants.jsp")) {
	pageTitle = "Job Applications";
	activeTab = "view_applicants";
} else if (currentUri.endsWith("admin_profile.jsp")) {
	pageTitle = "Admin Profile";
	activeTab = "admin_profile";
}
%>

<%
if (admin != null) {
%>
<style>
@media ( min-width : 992px) {
	body {
		padding-left: 260px !important;
		padding-top: 90px !important;
	}
}

@media ( max-width : 991.98px) {
	body {
		padding-top: 90px !important;
	}
}
</style>

<div class="admin-sidebar">
	<a class="admin-sidebar-brand"
		href="<%=request.getContextPath()%>/admin/admin.jsp"> 
		<img src="<%=request.getContextPath()%>/img/Hire Hub.jpeg" width="35"
		height="35" class="rounded-circle"> <span>HireHub Admin</span>
	</a>
	<ul class="admin-sidebar-menu" style="padding-top: 10px;">
		<li
			class="admin-menu-item <%="dashboard".equals(activeTab) ? "active" : ""%>">
			<a href="<%=request.getContextPath()%>/admin/admin.jsp"> <i
				class="fa-solid fa-gauge"></i> Dashboard
			</a>
		</li>
		
		<li class="admin-menu-header text-uppercase text-muted font-weight-bold" style="font-size: 0.72rem; letter-spacing: 0.8px; padding: 18px 24px 6px 24px; opacity: 0.7; list-style: none;">Job Management</li>
		<li
			class="admin-menu-item <%="add_job".equals(activeTab) ? "active" : ""%>">
			<a href="<%=request.getContextPath()%>/admin/add_job.jsp"> <i
				class="fa-solid fa-plus-circle"></i> Post Job
			</a>
		</li>
		<li
			class="admin-menu-item <%="view_jobs".equals(activeTab) ? "active" : ""%>">
			<a href="<%=request.getContextPath()%>/admin/view_jobs.jsp"> <i
				class="fa-solid fa-list-check"></i> View Jobs
			</a>
		</li>
		<li
			class="admin-menu-item <%="active_jobs".equals(activeTab) ? "active" : ""%>">
			<a href="<%=request.getContextPath()%>/admin/active_jobs.jsp"> <i
				class="fa-solid fa-briefcase"></i> Active Jobs
			</a>
		</li>
		<li
			class="admin-menu-item <%="inactive_jobs".equals(activeTab) ? "active" : ""%>">
			<a href="<%=request.getContextPath()%>/admin/inactive_jobs.jsp"> <i
				class="fa-solid fa-ban"></i> Inactive Jobs
			</a>
		</li>
		
		<li class="admin-menu-header text-uppercase text-muted font-weight-bold" style="font-size: 0.72rem; letter-spacing: 0.8px; padding: 18px 24px 6px 24px; opacity: 0.7; list-style: none;">User Management</li>
		<li
			class="admin-menu-item <%="view_users".equals(activeTab) ? "active" : ""%>">
			<a href="<%=request.getContextPath()%>/admin/view_users.jsp"> <i
				class="fa-solid fa-users-gear"></i> View Users
			</a>
		</li>
		
		<li class="admin-menu-header text-uppercase text-muted font-weight-bold" style="font-size: 0.72rem; letter-spacing: 0.8px; padding: 18px 24px 6px 24px; opacity: 0.7; list-style: none;">Application Management</li>
		<li
			class="admin-menu-item <%="view_applicants".equals(activeTab) ? "active" : ""%>">
			<a href="<%=request.getContextPath()%>/admin/view_applicants.jsp">
				<i class="fa-solid fa-file-invoice"></i> View Applicants
			</a>
		</li>
		
		<li class="admin-menu-header text-uppercase text-muted font-weight-bold" style="font-size: 0.72rem; letter-spacing: 0.8px; padding: 18px 24px 6px 24px; opacity: 0.7; list-style: none;">Account</li>
		<li
			class="admin-menu-item <%="admin_profile".equals(activeTab) ? "active" : ""%>">
			<a href="<%=request.getContextPath()%>/admin/admin_profile.jsp">
				<i class="fa-solid fa-circle-user"></i> Admin Profile
			</a>
		</li>
		
		<li class="admin-menu-header text-uppercase text-muted font-weight-bold" style="font-size: 0.72rem; letter-spacing: 0.8px; padding: 18px 24px 6px 24px; opacity: 0.7; list-style: none;">System</li>
		<li class="admin-menu-item"><a
			href="<%=request.getContextPath()%>/logout" class="text-danger">
				<i class="fa-solid fa-power-off text-danger"></i> Logout
			</a>
		</li>
	</ul>
</div>

<div class="admin-top-navbar">
	<div class="d-flex align-items-center">
		<button class="admin-toggle-btn mr-3 d-lg-none"
			id="adminSidebarToggle">
			<i class="fa-solid fa-bars"></i>
		</button>
		<h5 class="admin-top-brand mb-0">
			<i class="fa-solid fa-shield-halved text-primary mr-2"></i>
			<%=pageTitle%>
		</h5>
	</div>

	<div class="admin-profile-info">
		<!-- Notification Icon (UI only) -->
		<div class="position-relative cursor-pointer mr-3 text-muted"
			style="font-size: 1.15rem;">
			<i class="fa-regular fa-bell"></i> <span
				class="position-absolute badge badge-danger rounded-circle"
				style="top: -5px; right: -5px; font-size: 0.6rem; padding: 3px 5px;">3</span>
		</div>
		<!-- Admin Profile Email -->
		<div class="admin-profile-email">
			<i class="fa-solid fa-circle-user text-success"></i> <span><%=admin.getEmail()%></span>
		</div>
	</div>
</div>

<script>
	$(document).ready(
			function() {
				$('#adminSidebarToggle').on('click', function(e) {
					e.stopPropagation();
					$('.admin-sidebar').toggleClass('show');
				});

				$(document).on(
						'click',
						function(e) {
							if (!$(e.target).closest('.admin-sidebar').length
									&& !$(e.target).closest(
											'#adminSidebarToggle').length) {
								$('.admin-sidebar').removeClass('show');
							}
						});
			});
</script>
<%
} else {
%>
<nav
	class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm fixed-top">
	<div class="container">
		<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
			<img src="<%=request.getContextPath()%>/img/Hire Hub.jpeg" width="38"
			height="38" class="rounded-circle"> <span>HireHub</span>
		</a>

		<button class="navbar-toggler border-0" type="button"
			data-toggle="collapse" data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<%-- <li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">
						<i class="fa-solid fa-house"></i> Home
					</a>
				</li> --%>

				<%
				if (user != null) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath()%>/user/user_home.jsp"> <i
						class="fa-solid fa-table-columns"></i> Dashboard
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#"> <i
						class="fa-solid fa-briefcase"></i> Jobs
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#"> <i
						class="fa-solid fa-file-invoice"></i> My Applications
				</a></li>
				<%
				}
				%>
			</ul>

			<!-- Search Form -->
			<form class="form-inline my-2 my-lg-0 mr-3 d-flex align-items-center">
				<div class="input-group">
					<input class="form-control nav-search-input" type="search"
						placeholder="Search jobs..." aria-label="Search">
					<div class="input-group-append">
						<button class="btn nav-search-btn" type="submit">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
				</div>
			</form>

			<!-- Authentication Buttons -->
			<div class="d-flex align-items-center gap-2">
				<%
				if (user == null) {
				%>
				<a href="<%=request.getContextPath()%>/login.jsp"
					class="nav-link navbar-btn-login mr-2"> <i
					class="fa-solid fa-right-to-bracket"></i> Login
				</a> <a href="<%=request.getContextPath()%>/signup.jsp"
					class="nav-link navbar-btn-signup"> <i
					class="fa-solid fa-user-plus"></i> Sign Up
				</a>
				<%
				} else {
				%>
				<span
					class="navbar-text mr-3 text-white-50 font-weight-bold d-none d-lg-inline">
					<i class="fa-solid fa-circle-user mr-1 text-success"></i> <%=user.getFullname()%>
				</span> <a href="<%=request.getContextPath()%>/logout"
					class="btn btn-danger-gradient btn-action-sm"> <i
					class="fa-solid fa-power-off mr-1"></i> Logout
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>
</nav>
<%
}
%>
