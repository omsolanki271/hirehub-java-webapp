<%@page import="com.dao.JobDao"%>
<%@page import="com.dao.UserDao"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.entity.Jobs"%>
<%@page import="com.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Authentication Guard -->
<%
if (session.getAttribute("adminobj") == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>

<%
Connection conn = DBConnect.getConn();
JobDao jobDao = new JobDao(conn);
UserDao userDao = new UserDao(conn);

// Counts
int totalJobs = jobDao.getTotalJobs();
int totalUsers = jobDao.getTotalUsers();
int totalApplications = jobDao.getTotalApplications();

int activeJobsCount = 0;
int inactiveJobsCount = 0;
try (PreparedStatement ps = conn.prepareStatement("select count(*) from jobs where status = 'Active'");
		ResultSet rs = ps.executeQuery()) {
	if (rs.next()) {
		activeJobsCount = rs.getInt(1);
	}
} catch (Exception e) {
	e.printStackTrace();
}

try (PreparedStatement ps = conn.prepareStatement("select count(*) from jobs where status = 'Inactive'");
		ResultSet rs = ps.executeQuery()) {
	if (rs.next()) {
		inactiveJobsCount = rs.getInt(1);
	}
} catch (Exception e) {
	e.printStackTrace();
}

int adminCount = 0;
try (PreparedStatement ps = conn.prepareStatement("select count(*) from admin"); ResultSet rs = ps.executeQuery()) {
	if (rs.next()) {
		adminCount = rs.getInt(1);
	}
} catch (Exception e) {
	e.printStackTrace();
}

// Today productivity
int jobsPostedToday = 0;
try (PreparedStatement ps = conn.prepareStatement("select count(*) from jobs where date(pdate) = curdate()");
		ResultSet rs = ps.executeQuery()) {
	if (rs.next()) {
		jobsPostedToday = rs.getInt(1);
	}
} catch (Exception e) {
	e.printStackTrace();
}

int usersRegisteredToday = 0;
try (PreparedStatement ps = conn.prepareStatement("select count(*) from users where date(created_at) = curdate()");
		ResultSet rs = ps.executeQuery()) {
	if (rs.next()) {
		usersRegisteredToday = rs.getInt(1);
	}
} catch (Exception e) {
	e.printStackTrace();
}

int appsReceivedToday = 0;
try (PreparedStatement ps = conn.prepareStatement("select count(*) from apply_job where date(apply_date) = curdate()");
		ResultSet rs = ps.executeQuery()) {
	if (rs.next()) {
		appsReceivedToday = rs.getInt(1);
	}
} catch (Exception e) {
	e.printStackTrace();
}

// Percentages
int totalJobStatusCount = activeJobsCount + inactiveJobsCount;
double activePercent = totalJobStatusCount > 0 ? ((double) activeJobsCount / totalJobStatusCount) * 100 : 0;
double inactivePercent = totalJobStatusCount > 0 ? ((double) inactiveJobsCount / totalJobStatusCount) * 100 : 0;

// Lists
List<Jobs> recentJobs = jobDao.getRecentJobs();
List<User> recentUsers = userDao.getRecentUsers();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Admin Dashboard - HireHub</title>

<%@include file="../all_component/all_css.jsp"%>

<style type="text/css">
.dashboard-card {
	transition: transform 0.3s ease, box-shadow 0.3s ease !important;
}

.dashboard-card:hover {
	transform: translateY(-6px) !important;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15) !important;
}

.badge-status-active {
	background: rgba(16, 185, 129, 0.08);
	color: #047857;
}

.badge-status-inactive {
	background: rgba(239, 68, 68, 0.08);
	color: #b91c1c;
}
</style>
</head>
<body>

	<!-- Authentication Guard -->
	<c:if test="${empty adminobj}">
		<c:redirect url="../login.jsp" />
	</c:if>

	<%@include file="../all_component/navbar.jsp"%>

	<div class="container-fluid px-md-5 my-5">

		<!-- Welcome Header -->
		<div class="row align-items-center mb-5">
			<div class="col-md-8">
				<div class="page-header mb-0">
					<h2>Welcome Back, Admin</h2>
					<p>Manage jobs, users, and applications from one dashboard.</p>
				</div>
			</div>
			<div class="col-md-4 text-md-right mt-3 mt-md-0">
				<div
					class="d-inline-block p-3 bg-white border rounded shadow-sm text-left">
					<span class="d-block text-muted font-weight-bold text-uppercase"
						style="font-size: 0.7rem; letter-spacing: 0.5px;">Current
						Time</span> <span id="liveClock" class="font-weight-bold text-dark"
						style="font-size: 0.95rem;"></span>
				</div>
				<span
					class="badge badge-success py-2 px-3 ml-2 align-middle font-weight-bold shadow-sm"
					style="font-size: 0.85rem;"> <i
					class="fa-solid fa-shield-halved mr-1"></i> Logged In
				</span>
			</div>
		</div>

		<!-- Statistics Section -->
		<div class="row mb-4">

			<!-- Total Jobs Card -->
			<div class="col-xl-4 col-md-6 mb-4">
				<a href="<%=request.getContextPath()%>/admin/view_jobs.jsp"
					class="text-decoration-none">
					<div
						class="card dashboard-card dashboard-card-primary h-100 shadow-sm border-0"
						style="background: var(--gradient-primary); border-radius: var(--radius-md);">
						<div class="card-body position-relative text-white p-4">
							<h5 class="text-white-50 font-weight-bold mb-2">Total Jobs</h5>
							<h2 class="display-4 font-weight-bold mb-3"><%=totalJobs%></h2>
							<div class="d-flex align-items-center justify-content-between"
								style="font-size: 0.9rem;">
								<span>View all postings &rarr;</span>
							</div>
							<i class="fa-solid fa-briefcase dashboard-card-icon"
								style="position: absolute; right: 20px; bottom: 20px; font-size: 4.5rem; opacity: 0.15; pointer-events: none;"></i>
						</div>
					</div>
				</a>
			</div>

			<!-- Active Jobs Card -->
			<div class="col-xl-4 col-md-6 mb-4">
				<a href="<%=request.getContextPath()%>/admin/active_jobs.jsp"
					class="text-decoration-none">
					<div
						class="card dashboard-card dashboard-card-success h-100 shadow-sm border-0"
						style="background: var(--gradient-success); border-radius: var(--radius-md);">
						<div class="card-body position-relative text-white p-4">
							<h5 class="text-white-50 font-weight-bold mb-2">Active Jobs</h5>
							<h2 class="display-4 font-weight-bold mb-3"><%=activeJobsCount%></h2>
							<div class="d-flex align-items-center justify-content-between"
								style="font-size: 0.9rem;">
								<span>Manage active postings &rarr;</span>
							</div>
							<i class="fa-solid fa-circle-check dashboard-card-icon"
								style="position: absolute; right: 20px; bottom: 20px; font-size: 4.5rem; opacity: 0.15; pointer-events: none;"></i>
						</div>
					</div>
				</a>
			</div>

			<!-- Inactive Jobs Card -->
			<div class="col-xl-4 col-md-6 mb-4">
				<a href="<%=request.getContextPath()%>/admin/inactive_jobs.jsp"
					class="text-decoration-none">
					<div class="card dashboard-card h-100 shadow-sm border-0"
						style="background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%); border-radius: var(--radius-md);">
						<div class="card-body position-relative text-white p-4">
							<h5 class="text-white-50 font-weight-bold mb-2">Inactive
								Jobs</h5>
							<h2 class="display-4 font-weight-bold mb-3"><%=inactiveJobsCount%></h2>
							<div class="d-flex align-items-center justify-content-between"
								style="font-size: 0.9rem;">
								<span>Review draft/closed jobs &rarr;</span>
							</div>
							<i class="fa-solid fa-ban dashboard-card-icon"
								style="position: absolute; right: 20px; bottom: 20px; font-size: 4.5rem; opacity: 0.15; pointer-events: none;"></i>
						</div>
					</div>
				</a>
			</div>

			<!-- Total Users Card -->
			<div class="col-xl-4 col-md-6 mb-4">
				<a href="<%=request.getContextPath()%>/admin/view_users.jsp"
					class="text-decoration-none">
					<div class="card dashboard-card h-100 shadow-sm border-0"
						style="background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%); border-radius: var(--radius-md);">
						<div class="card-body position-relative text-white p-4">
							<h5 class="text-white-50 font-weight-bold mb-2">Total Users</h5>
							<h2 class="display-4 font-weight-bold mb-3"><%=totalUsers%></h2>
							<div class="d-flex align-items-center justify-content-between"
								style="font-size: 0.9rem;">
								<span>Manage registered candidates &rarr;</span>
							</div>
							<i class="fa-solid fa-users dashboard-card-icon"
								style="position: absolute; right: 20px; bottom: 20px; font-size: 4.5rem; opacity: 0.15; pointer-events: none;"></i>
						</div>
					</div>
				</a>
			</div>

			<!-- Total Applications Card -->
			<div class="col-xl-4 col-md-6 mb-4">
				<a href="<%=request.getContextPath()%>/admin/view_applicants.jsp"
					class="text-decoration-none">
					<div
						class="card dashboard-card dashboard-card-warning h-100 shadow-sm border-0"
						style="background: var(--gradient-warning); border-radius: var(--radius-md);">
						<div class="card-body position-relative text-white p-4">
							<h5 class="text-white-50 font-weight-bold mb-2">Total
								Applications</h5>
							<h2 class="display-4 font-weight-bold mb-3"><%=totalApplications%></h2>
							<div class="d-flex align-items-center justify-content-between"
								style="font-size: 0.9rem;">
								<span>Check submissions &rarr;</span>
							</div>
							<i class="fa-solid fa-file-invoice dashboard-card-icon"
								style="position: absolute; right: 20px; bottom: 20px; font-size: 4.5rem; opacity: 0.15; pointer-events: none;"></i>
						</div>
					</div>
				</a>
			</div>

			<!-- Admin Count Card -->
			<div class="col-xl-4 col-md-6 mb-4">
				<a href="<%=request.getContextPath()%>/admin/admin_profile.jsp"
					class="text-decoration-none">
					<div class="card dashboard-card h-100 shadow-sm border-0"
						style="background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%); border-radius: var(--radius-md);">
						<div class="card-body position-relative text-white p-4">
							<h5 class="text-white-50 font-weight-bold mb-2">Admin Count</h5>
							<h2 class="display-4 font-weight-bold mb-3"><%=adminCount%></h2>
							<div class="d-flex align-items-center justify-content-between"
								style="font-size: 0.9rem;">
								<span>Manage profiles & security &rarr;</span>
							</div>
							<i class="fa-solid fa-shield-halved dashboard-card-icon"
								style="position: absolute; right: 20px; bottom: 20px; font-size: 4.5rem; opacity: 0.15; pointer-events: none;"></i>
						</div>
					</div>
				</a>
			</div>

		</div>

		<!-- Status & Productivity Row -->
		<div class="row">

			<!-- Left Widget: Job Overview + Productivity -->
			<div class="col-lg-6 mb-4">

				<!-- Job Status Overview Card -->
				<div class="card border-0 shadow-sm mb-4"
					style="border-radius: var(--radius-md);">
					<div class="card-body p-4">
						<h5 class="font-weight-bold mb-4"
							style="color: var(--dark-color);">
							<i class="fa-solid fa-chart-pie mr-2 text-primary"></i>Job Status
							Overview
						</h5>
						<div class="mb-4">
							<div class="d-flex justify-content-between mb-2">
								<span class="font-weight-bold text-muted">Active Jobs</span> <span
									class="text-success font-weight-bold"><%=activeJobsCount%>
									/ <%=totalJobStatusCount%> (<%=String.format("%.1f", activePercent)%>%)</span>
							</div>
							<div class="progress"
								style="height: 12px; border-radius: var(--radius-full);">
								<div
									class="progress-bar bg-success progress-bar-striped progress-bar-animated"
									role="progressbar" style="width: <%=activePercent%>%"
									aria-valuenow="<%=activePercent%>" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
						<div>
							<div class="d-flex justify-content-between mb-2">
								<span class="font-weight-bold text-muted">Inactive Jobs</span> <span
									class="text-danger font-weight-bold"><%=inactiveJobsCount%>
									/ <%=totalJobStatusCount%> (<%=String.format("%.1f", inactivePercent)%>%)</span>
							</div>
							<div class="progress"
								style="height: 12px; border-radius: var(--radius-full);">
								<div
									class="progress-bar bg-danger progress-bar-striped progress-bar-animated"
									role="progressbar" style="width: <%=inactivePercent%>%"
									aria-valuenow="<%=inactivePercent%>" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div>
				</div>

				<!-- Admin Productivity Card -->
				<div class="card border-0 shadow-sm"
					style="border-radius: var(--radius-md);">
					<div class="card-body p-4">
						<h5 class="font-weight-bold mb-4"
							style="color: var(--dark-color);">
							<i class="fa-solid fa-chart-line mr-2 text-info"></i>Admin
							Productivity (Today)
						</h5>
						<div class="row">
							<!-- Jobs Posted Today -->
							<div class="col-md-4 mb-3 mb-md-0">
								<div class="p-3 bg-light rounded text-center border">
									<i class="fa-solid fa-briefcase text-indigo mb-2"
										style="font-size: 1.5rem;"></i> <span
										class="d-block text-muted font-weight-bold text-uppercase mb-1"
										style="font-size: 0.65rem;">Posted Today</span>
									<h3 class="font-weight-bold text-dark mb-0"><%=jobsPostedToday%></h3>
								</div>
							</div>
							<!-- Users Registered Today -->
							<div class="col-md-4 mb-3 mb-md-0">
								<div class="p-3 bg-light rounded text-center border">
									<i class="fa-solid fa-user-plus text-success mb-2"
										style="font-size: 1.5rem;"></i> <span
										class="d-block text-muted font-weight-bold text-uppercase mb-1"
										style="font-size: 0.65rem;">New Users</span>
									<h3 class="font-weight-bold text-dark mb-0"><%=usersRegisteredToday%></h3>
								</div>
							</div>
							<!-- Applications Received Today -->
							<div class="col-md-4">
								<div class="p-3 bg-light rounded text-center border">
									<i class="fa-solid fa-file-arrow-up text-warning mb-2"
										style="font-size: 1.5rem;"></i> <span
										class="d-block text-muted font-weight-bold text-uppercase mb-1"
										style="font-size: 0.65rem;">Apps Received</span>
									<h3 class="font-weight-bold text-dark mb-0"><%=appsReceivedToday%></h3>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

			<!-- Right Widget: System Health + Quick Action -->
			<div class="col-lg-6 mb-4">

				<!-- System Health Status Card -->
				<div class="card border-0 shadow-sm mb-4"
					style="border-radius: var(--radius-md);">
					<div class="card-body p-4">
						<h5 class="font-weight-bold mb-4"
							style="color: var(--dark-color);">
							<i class="fa-solid fa-server mr-2 text-success"></i>System Health
							& Status
						</h5>
						<div
							class="d-flex flex-wrap align-items-center justify-content-between mb-3 border-bottom pb-2">
							<span class="text-muted font-weight-bold">Database
								Connection</span> <span
								class="badge badge-success py-2 px-3 font-weight-bold"><i
								class="fa-solid fa-link mr-1"></i> Connected</span>
						</div>
						<div
							class="d-flex flex-wrap align-items-center justify-content-between mb-3 border-bottom pb-2">
							<span class="text-muted font-weight-bold">Session
								Authentication</span> <span
								class="badge badge-success py-2 px-3 font-weight-bold"><i
								class="fa-solid fa-circle-user mr-1"></i> Logged In</span>
						</div>
						<div
							class="d-flex flex-wrap align-items-center justify-content-between mb-3 border-bottom pb-2">
							<span class="text-muted font-weight-bold">Total Active
								Jobs</span> <span class="font-weight-bold text-dark"><%=activeJobsCount%></span>
						</div>
						<div
							class="d-flex flex-wrap align-items-center justify-content-between">
							<span class="text-muted font-weight-bold">Total Candidate
								Accounts</span> <span class="font-weight-bold text-dark"><%=totalUsers%></span>
						</div>
					</div>
				</div>

				<!-- Quick Actions Card -->
				<div class="card border-0 shadow-sm"
					style="border-radius: var(--radius-md);">
					<div class="card-body p-4">
						<h5 class="font-weight-bold mb-4"
							style="color: var(--dark-color);">
							<i class="fa-solid fa-bolt mr-2 text-warning"></i>Quick Action
							Portal
						</h5>
						<div class="row text-white">
							<div class="col-sm-6 mb-3">
								<a href="<%=request.getContextPath()%>/admin/add_job.jsp"
									class="btn btn-primary-gradient btn-block py-3 text-left d-flex align-items-center justify-content-between">
									<span><i class="fa-solid fa-circle-plus mr-2"></i> Post
										New Job</span> <i class="fa-solid fa-chevron-right opacity-50"></i>
								</a>
							</div>
							<div class="col-sm-6 mb-3">
								<a href="<%=request.getContextPath()%>/admin/view_jobs.jsp"
									class="btn btn-success-gradient btn-block py-3 text-left d-flex align-items-center justify-content-between">
									<span><i class="fa-solid fa-list-check mr-2"></i> Manage
										Jobs</span> <i class="fa-solid fa-chevron-right opacity-50"></i>
								</a>
							</div>
							<div class="col-sm-6 mb-3 mb-sm-0">
								<a href="<%=request.getContextPath()%>/admin/view_users.jsp"
									class="btn btn-block py-3 font-weight-bold text-white text-left d-flex align-items-center justify-content-between"
									style="background: var(--gradient-dark); border: none; box-shadow: var(--shadow-sm); border-radius: var(--radius-sm); transition: var(--transition);">
									<span><i class="fa-solid fa-users-gear mr-2"></i> Manage
										Users</span> <i
									class="fa-solid fa-chevron-right opacity-50 text-white-50"></i>
								</a>
							</div>
							<div class="col-sm-6">
								<a
									href="<%=request.getContextPath()%>/admin/view_applicants.jsp"
									class="btn btn-block py-3 font-weight-bold text-white text-left d-flex align-items-center justify-content-between"
									style="background: linear-gradient(135deg, #6b7280 0%, #374151 100%); border: none; box-shadow: var(--shadow-sm); border-radius: var(--radius-sm); transition: var(--transition);">
									<span><i class="fa-solid fa-file-invoice mr-2"></i> View
										Applications</span> <i
									class="fa-solid fa-chevron-right opacity-50 text-white-50"></i>
								</a>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

		<!-- Recent Activity Lists -->
		<div class="row mt-4">

			<!-- Recent Jobs Section -->
			<div class="col-lg-6 mb-4">
				<div class="card border-0 shadow-sm"
					style="border-radius: var(--radius-md);">
					<div class="card-body p-4">
						<div
							class="d-flex justify-content-between align-items-center mb-4">
							<h5 class="font-weight-bold mb-0"
								style="color: var(--dark-color);">
								<i class="fa-solid fa-briefcase mr-2 text-primary"></i>Recent
								Posted Jobs
							</h5>
							<a href="<%=request.getContextPath()%>/admin/view_jobs.jsp"
								class="btn btn-link btn-sm text-decoration-none font-weight-bold p-0">View
								All Jobs <i class="fa-solid fa-chevron-right"
								style="font-size: 0.75rem;"></i>
							</a>
						</div>

						<div class="table-responsive">
							<table class="table table-hover mb-0" style="font-size: 0.88rem;">
								<thead class="bg-light text-muted">
									<tr>
										<th>Job Title</th>
										<th>Category</th>
										<th>Status</th>
										<th>Publish Date</th>
										<th class="text-right">Action</th>
									</tr>
								</thead>
								<tbody>
									<%
									if (recentJobs == null || recentJobs.isEmpty()) {
									%>
									<tr>
										<td colspan="5" class="text-center py-5"><i
											class="fa-solid fa-briefcase fa-3x mb-3 text-muted"
											style="opacity: 0.4;"></i>
											<h6 class="text-muted font-weight-bold">No Jobs
												Available</h6>
											<p class="text-muted small mb-0">Use the quick access
												portal to publish new jobs.</p></td>
									</tr>
									<%
									} else {
									for (Jobs j : recentJobs) {
										String badgeClass = "badge-status-active";
										if (!"Active".equalsIgnoreCase(j.getStatus())) {
											badgeClass = "badge-status-inactive";
										}
									%>
									<tr>
										<td class="font-weight-bold text-dark"><%=j.getTitle()%></td>
										<td><span
											class="badge badge-pill badge-category m-0 py-1 px-2"><%=j.getCategory()%></span></td>
										<td><span
											class="badge badge-pill <%=badgeClass%> py-1 px-2"><%=j.getStatus()%></span></td>
										<td><%=j.getPdate()%></td>
										<td class="text-right"><a
											href="<%=request.getContextPath()%>/admin/job_details.jsp?id=<%=j.getId()%>"
											class="btn btn-sm btn-outline-info py-1 px-2 border-0"> <i
												class="fa-solid fa-eye"></i> Details
										</a></td>
									</tr>
									<%
									}
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<!-- Recent Users Section -->
			<div class="col-lg-6 mb-4">
				<div class="card border-0 shadow-sm"
					style="border-radius: var(--radius-md);">
					<div class="card-body p-4">
						<div
							class="d-flex justify-content-between align-items-center mb-4">
							<h5 class="font-weight-bold mb-0"
								style="color: var(--dark-color);">
								<i class="fa-solid fa-users mr-2 text-info"></i>Recent
								Registered Users
							</h5>
							<a href="<%=request.getContextPath()%>/admin/view_users.jsp"
								class="btn btn-link btn-sm text-decoration-none font-weight-bold p-0">View
								All Users <i class="fa-solid fa-chevron-right"
								style="font-size: 0.75rem;"></i>
							</a>
						</div>

						<div class="table-responsive">
							<table class="table table-hover mb-0" style="font-size: 0.88rem;">
								<thead class="bg-light text-muted">
									<tr>
										<th>Name</th>
										<th>Email</th>
										<th>Registration Date</th>
										<th class="text-right">Action</th>
									</tr>
								</thead>
								<tbody>
									<%
									if (recentUsers == null || recentUsers.isEmpty()) {
									%>
									<tr>
										<td colspan="4" class="text-center py-5"><i
											class="fa-solid fa-users-slash fa-3x mb-3 text-muted"
											style="opacity: 0.4;"></i>
											<h6 class="text-muted font-weight-bold">No Users Found</h6>
											<p class="text-muted small mb-0">Wait for candidates to
												register profiles.</p></td>
									</tr>
									<%
									} else {
									for (User u : recentUsers) {
									%>
									<tr>
										<td class="font-weight-bold text-dark">
											<div class="d-flex align-items-center">
												<div
													class="rounded-circle bg-light d-flex align-items-center justify-content-center text-primary mr-2"
													style="width: 28px; height: 28px; font-weight: 700; font-size: 0.8rem; background-color: rgba(79, 70, 229, 0.06) !important;">
													<%=u.getFullname() != null && !u.getFullname().isEmpty() ? u.getFullname().substring(0, 1).toUpperCase() : "U"%>
												</div>
												<span><%=u.getFullname()%></span>
											</div>
										</td>
										<td><a href="mailto:<%=u.getEmail()%>"
											class="text-decoration-none"
											style="color: var(--primary-color);"><%=u.getEmail()%></a></td>
										<td><%=u.getRegDate() != null ? u.getRegDate() : "N/A"%></td>
										<td class="text-right"><a
											href="<%=request.getContextPath()%>/admin/view_users.jsp"
											class="btn btn-sm btn-outline-dark py-1 px-2 border-0"> <i
												class="fa-solid fa-user-gear"></i> View User
										</a></td>
									</tr>
									<%
									}
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>

	<%@include file="../all_component/footer.jsp"%>

	<script>
		function updateClock() {
			var now = new Date();
			var options = {
				weekday : 'short',
				year : 'numeric',
				month : 'short',
				day : 'numeric',
				hour : '2-digit',
				minute : '2-digit',
				second : '2-digit'
			};
			document.getElementById('liveClock').textContent = now
					.toLocaleDateString('en-US', options);
		}
		setInterval(updateClock, 1000);
		updateClock();
	</script>
</body>
</html>
