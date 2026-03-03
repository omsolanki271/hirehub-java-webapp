<nav
	class="navbar navbar-expand-lg navbar-dark bg-custom shadow-sm fixed-top">

	<!-- Logo -->
	<a class="navbar-brand d-flex align-items-center" href="index.jsp">
		<img src="<%=request.getContextPath()%>/img/Hire Hub.jpeg" width="35"
		height="35" class="rounded-circle mr-2" alt="HireHub Logo"> <span
		class="font-weight-bold">HireHub</span>
	</a>

	<!-- Toggle Button -->
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent">
		<span class="navbar-toggler-icon"></span>
	</button>

	<!-- Navbar Content -->
	<div class="collapse navbar-collapse" id="navbarSupportedContent">

		<!-- Left Menu -->
		<ul class="navbar-nav mr-auto">

			<li class="nav-item active md-2"><a class="nav-link" href="index.jsp">
					<i class="fa-solid fa-house "></i> Home
			</a></li>

			<li class="nav-item ml-2"><a class="nav-link" href="add_job.jsp">
					<i class="fa-solid fa-briefcase"></i> Post Job
			</a></li>

			<li class="nav-item ml-2"><a class="nav-link" href="view_job.jsp">
					<i class="fa-solid fa-eye"></i> View Jobs
			</a></li>

		</ul>

		<!-- Search Form -->
		<form class="form-inline my-2 my-lg-0 mr-3">
			<input class="form-control mr-2" type="search"
				placeholder="Search jobs..." aria-label="Search">

			<button class="btn btn-outline-light" type="submit">
				<i class="fa-solid fa-magnifying-glass"></i>
			</button>
		</form>

		<!-- Right Buttons -->
		<a href="login.jsp" class="btn btn-outline-light mr-2"> <i class="bi bi-box-arrow-in-right mr-2 p-1"></i>Login </a> <a
			href="signup.jsp" class="btn btn-light font-weight-bold"> Sign Up
		</a>

	</div>
</nav>