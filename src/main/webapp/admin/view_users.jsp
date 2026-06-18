<%@page import="java.util.List"%>
<%@page import="com.entity.User"%>
<%@page import="com.dao.UserDao"%>
<%@page import="com.DB.DBConnect"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Registered Users - HireHub</title>

<%@include file="../all_component/all_css.jsp"%>
</head>
<body>
	<%@include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		
		<!-- Page Header & Search Bar -->
		<div class="row align-items-center mb-4">
			<div class="col-md-7 mb-3 mb-md-0">
				<div class="page-header mb-0">
					<h2>All Registered Users</h2>
					<p>Browse qualification profiles, login handles, and registration details for all candidates.</p>
				</div>
			</div>
			
			<!-- Interactive Search Bar -->
			<div class="col-md-5">
				<div class="input-group" style="box-shadow: var(--shadow-sm); border-radius: var(--radius-sm); overflow: hidden;">
					<div class="input-group-prepend">
						<span class="input-group-text bg-white border-right-0 text-muted" 
							style="border: 1.5px solid var(--border-color); border-right: none; height: 44px; display: flex; align-items: center; justify-content: center; width: 44px;">
							<i class="fa-solid fa-magnifying-glass"></i>
						</span>
					</div>
					<input type="text" id="userInputSearch" class="form-control border-left-0" 
						style="border: 1.5px solid var(--border-color); border-radius: 0 var(--radius-sm) var(--radius-sm) 0; height: 44px;" 
						placeholder="Search users by name, qualification, email...">
				</div>
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

		<c:if test="${not empty failMsg}">
			<div class="alert alert-custom alert-custom-danger mb-4" role="alert">
				<i class="fa-solid fa-circle-exclamation"></i>
				<span>${failMsg}</span>
			</div>
			<c:remove var="failMsg" />
		</c:if>

		<!-- Users Table Responsive Card -->
		<div class="table-responsive-custom">
			<table class="table table-custom text-left" id="usersTable">
				<thead>
					<tr>
						<th width="8%">User ID</th>
						<th width="27%">Full Name</th>
						<th width="25%">Email Address</th>
						<th width="22%">Qualification</th>
						<th width="18%">Action</th>
					</tr>
				</thead>
				<tbody>
				<%
				UserDao dao = new UserDao(DBConnect.getConn());
				List<User> list = dao.getAllUsers();

				if (list == null || list.isEmpty()) {
				%>
					<tr>
						<td colspan="5" class="text-center py-5 text-muted">
							<i class="fa-solid fa-users-slash fa-3x mb-3 text-muted"></i>
							<h5>No registered users found</h5>
						</td>
					</tr>
				<%
				} else {
					for (User u : list) {
				%>
					<tr>
						<td>
							<span class="font-weight-bold" style="color: var(--text-muted); font-size: 0.88rem;">#<%=u.getId()%></span>
						</td>
						<td>
							<div class="d-flex align-items-center">
								<div class="rounded-circle bg-light d-flex align-items-center justify-content-center text-primary mr-3" 
									style="width: 38px; height: 38px; font-weight: 700; background-color: rgba(79, 70, 229, 0.06) !important;">
									<%= u.getFullname() != null && !u.getFullname().isEmpty() ? u.getFullname().substring(0,1).toUpperCase() : "U" %>
								</div>
								<div>
									<span class="font-weight-bold text-dark d-block mb-0" style="font-size: 0.95rem;"><%=u.getFullname()%></span>
								</div>
							</div>
						</td>
						<td>
							<a href="mailto:<%=u.getEmail()%>" class="text-decoration-none d-inline-flex align-items-center" style="color: var(--primary-color);">
								<i class="fa-solid fa-envelope mr-2 text-muted" style="font-size: 0.88rem;"></i>
								<span><%=u.getEmail()%></span>
							</a>
						</td>
						<td>
							<span class="badge badge-pill badge-category py-2 px-3 m-0" style="font-size: 0.8rem;">
								<i class="fa-solid fa-graduation-cap mr-1"></i> <%=u.getQualification()%>
							</span>
						</td>
						<td>
							<a href="../deleteUser?id=<%=u.getId()%>" 
								class="btn btn-outline-danger btn-action-sm" 
								onclick="return confirm('Are you sure you want to delete this user candidate profile?')">
								<i class="fa-solid fa-trash-can mr-1"></i> Delete
							</a>
						</td>
					</tr>
				<%
					}
				}
				%>
				</tbody>
			</table>
		</div>

	</div>

	<%@include file="../all_component/footer.jsp"%>

	<!-- Instant Row Filtering Logic -->
	<script>
		document.getElementById('userInputSearch').addEventListener('keyup', function() {
			var filter = this.value.toLowerCase();
			var rows = document.querySelectorAll('#usersTable tbody tr');
			
			rows.forEach(function(row) {
				// Skip if empty record row
				if (row.cells.length < 5) return;
				
				var name = row.cells[1].textContent.toLowerCase();
				var email = row.cells[2].textContent.toLowerCase();
				var qualification = row.cells[3].textContent.toLowerCase();
				
				if (name.indexOf(filter) > -1 || email.indexOf(filter) > -1 || qualification.indexOf(filter) > -1) {
					row.style.display = "";
				} else {
					row.style.display = "none";
				}
			});
		});
	</script>
</body>
</html>
