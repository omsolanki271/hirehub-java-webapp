<%@page import="com.entity.Admin"%>
<%@page import="com.entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<%
Admin admin = (Admin) session.getAttribute("adminobj");
User user = (User) session.getAttribute("userobj");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom shadow-sm fixed-top">

	<a class="navbar-brand d-flex align-items-center"
		href="<%=request.getContextPath()%>/index.jsp">

		<img
		src="<%=request.getContextPath()%>/img/Hire Hub.jpeg"
		width="35" height="35"
		class="rounded-circle mr-2">

		<span class="font-weight-bold">HireHub</span>

	</a>

	<button class="navbar-toggler" type="button"
		data-toggle="collapse"
		data-target="#navbarSupportedContent">

		<span class="navbar-toggler-icon"></span>

	</button>

	<div class="collapse navbar-collapse"
		id="navbarSupportedContent">

		<ul class="navbar-nav mr-auto">

			<li class="nav-item">
				<a class="nav-link"
				href="../index.jsp">
					<i class="fa-solid fa-house"></i> Home
				</a>
			</li>

			<%
			if(admin != null)
			{
			%>

			<li class="nav-item">
				<a class="nav-link"
				href="<%=request.getContextPath()%>/admin/add_job.jsp">

					<i class="fa-solid fa-briefcase"></i>
					Post Job

				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link"
				href="<%=request.getContextPath()%>/admin/view_jobs.jsp">

					<i class="fa-solid fa-eye"></i>
					View Jobs

				</a>
			</li>

			<%
			}
			%>

			<%
			if(user != null)
			{
			%>

			<li class="nav-item">
				<a class="nav-link"
				href="<%=request.getContextPath()%>/user/user_home.jsp">

					<i class="fa-solid fa-user"></i>
					Dashboard

				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link"
				href="#">

					<i class="fa-solid fa-briefcase"></i>
					Jobs

				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link"
				href="#">

					<i class="fa-solid fa-file"></i>
					My Applications

				</a>
			</li>

			<%
			}
			%>

		</ul>

		<form class="form-inline my-2 my-lg-0 mr-3">
			<input class="form-control mr-2"
				type="search"
				placeholder="Search jobs...">

			<button class="btn btn-outline-light"
				type="submit">

				<i class="fa-solid fa-magnifying-glass"></i>

			</button>
		</form>

		<%
		if(admin == null && user == null)
		{
		%>

		<a href="<%=request.getContextPath()%>/login.jsp"
			class="btn btn-outline-light mr-2">

			Login

		</a>

		<a href="<%=request.getContextPath()%>/signup.jsp"
			class="btn btn-light font-weight-bold">

			Sign Up

		</a>

		<%
		}
		else
		{
		%>

		<a href="<%=request.getContextPath()%>/logout"
			class="btn btn-danger">

			Logout

		</a>

		<%
		}
		%>

	</div>

</nav>

