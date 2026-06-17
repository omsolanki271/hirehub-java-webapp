<%@page import="com.entity.Admin"%>
<%@page import="com.entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<%
Admin admin = (Admin) session.getAttribute("adminobj");
User user = (User) session.getAttribute("userobj");
%>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm fixed-top">
	<div class="container">
		<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
			<img src="<%=request.getContextPath()%>/img/Hire Hub.jpeg"
				width="38" height="38" class="rounded-circle">
			<span>HireHub</span>
		</a>

		<button class="navbar-toggler border-0" type="button"
			data-toggle="collapse" data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">
						<i class="fa-solid fa-house"></i> Home
					</a>
				</li>

				<%
				if (admin != null) {
				%>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/add_job.jsp">
						<i class="fa-solid fa-plus-circle"></i> Post Job
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/view_jobs.jsp">
						<i class="fa-solid fa-list-check"></i> View Jobs
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/admin/view_users.jsp">
						<i class="fa-solid fa-users-gear"></i> View Users
					</a>
				</li>
				<%
				}
				%>

				<%
				if (user != null) {
				%>
				<li class="nav-item">
					<a class="nav-link" href="<%=request.getContextPath()%>/user/user_home.jsp">
						<i class="fa-solid fa-table-columns"></i> Dashboard
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">
						<i class="fa-solid fa-briefcase"></i> Jobs
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">
						<i class="fa-solid fa-file-invoice"></i> My Applications
					</a>
				</li>
				<%
				}
				%>
			</ul>

			<!-- Search Form -->
			<form class="form-inline my-2 my-lg-0 mr-3 d-flex align-items-center">
				<div class="input-group">
					<input class="form-control nav-search-input" type="search" placeholder="Search jobs..." aria-label="Search">
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
				if (admin == null && user == null) {
				%>
				<a href="<%=request.getContextPath()%>/login.jsp" class="nav-link navbar-btn-login mr-2">
					<i class="fa-solid fa-right-to-bracket"></i> Login
				</a>
				<a href="<%=request.getContextPath()%>/signup.jsp" class="nav-link navbar-btn-signup">
					<i class="fa-solid fa-user-plus"></i> Sign Up
				</a>
				<%
				} else {
				%>
				<span class="navbar-text mr-3 text-white-50 font-weight-bold d-none d-lg-inline">
					<i class="fa-solid fa-circle-user mr-1 text-success"></i>
					<%= (admin != null) ? "Admin Panel" : user.getFullname() %>
				</span>
				<a href="<%=request.getContextPath()%>/logout" class="btn btn-danger-gradient btn-action-sm">
					<i class="fa-solid fa-power-off mr-1"></i> Logout
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>
</nav>
