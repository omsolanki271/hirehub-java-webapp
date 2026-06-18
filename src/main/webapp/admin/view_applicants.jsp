<%@page import="java.util.List"%>
<%@page import="com.entity.ApplyJob"%>
<%@page import="com.dao.ApplyJobDao"%>
<%@page import="com.DB.DBConnect"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=device-width, initial-scale=1.0">
<title>Job Applicants - HireHub</title>

<%@include file="../all_component/all_css.jsp"%>
</head>
<body>

	<!-- Authentication Guard -->
	<%-- <c:if test="${empty adminobj}">
		<c:redirect url="../login.jsp"/>
	</c:if> --%>

	<%@include file="../all_component/navbar.jsp"%>

	<div class="container my-5">
		
		<!-- Page Header & Search Bar -->
		<div class="row align-items-center mb-4">
			<div class="col-md-7 mb-3 mb-md-0">
				<div class="page-header mb-0">
					<h2>Job Applications</h2>
					<p>Monitor and review submissions received from candidates for active job openings.</p>
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
					<input type="text" id="applicantInputSearch" class="form-control border-left-0" 
						style="border: 1.5px solid var(--border-color); border-radius: 0 var(--radius-sm) var(--radius-sm) 0; height: 44px;" 
						placeholder="Search applicants, qualifications, job titles...">
				</div>
			</div>
		</div>

		<!-- Applicants Table Responsive Card -->
		<div class="table-responsive-custom">
			<table class="table table-custom text-left" id="applicantsTable">
				<thead>
					<tr>
						<th width="8%">App ID</th>
						<th width="22%">Applicant Name</th>
						<th width="22%">Email Address</th>
						<th width="15%">Qualification</th>
						<th width="20%">Applied For</th>
						<th width="13%">Apply Date</th>
					</tr>
				</thead>
				<tbody>
				<%
				ApplyJobDao dao = new ApplyJobDao(DBConnect.getConn());
				List<ApplyJob> list = dao.getAllApplicants();

				if (list == null || list.isEmpty()) {
				%>
					<tr>
						<td colspan="6" class="text-center py-5 text-muted">
							<i class="fa-solid fa-folder-open fa-3x mb-3 text-muted"></i>
							<h5>No applications received yet</h5>
						</td>
					</tr>
				<%
				} else {
					for (ApplyJob aj : list) {
				%>
					<tr>
						<td>
							<span class="font-weight-bold" style="color: var(--text-muted); font-size: 0.88rem;">#<%=aj.getId()%></span>
						</td>
						<td>
							<div class="d-flex align-items-center">
								<div class="rounded-circle bg-light d-flex align-items-center justify-content-center text-indigo mr-3" 
									style="width: 38px; height: 38px; font-weight: 700; background-color: rgba(79, 70, 229, 0.06) !important;">
									<%= aj.getUserName() != null && !aj.getUserName().isEmpty() ? aj.getUserName().substring(0,1).toUpperCase() : "A" %>
								</div>
								<div>
									<span class="font-weight-bold text-dark d-block mb-0" style="font-size: 0.95rem;"><%=aj.getUserName()%></span>
								</div>
							</div>
						</td>
						<td>
							<a href="mailto:<%=aj.getUserEmail()%>" class="text-decoration-none d-inline-flex align-items-center" style="color: var(--primary-color);">
								<i class="fa-solid fa-envelope mr-2 text-muted" style="font-size: 0.88rem;"></i>
								<span><%=aj.getUserEmail()%></span>
							</a>
						</td>
						<td>
							<span class="badge badge-pill badge-category py-2 px-3 m-0" style="font-size: 0.8rem;">
								<i class="fa-solid fa-graduation-cap mr-1"></i> <%=aj.getUserQualification()%>
							</span>
						</td>
						<td>
							<span class="font-weight-bold text-dark" style="font-size: 0.92rem;"><%=aj.getJobTitle()%></span>
						</td>
						<td>
							<span class="text-muted" style="font-size: 0.85rem;"><%=aj.getApplyDate() != null ? aj.getApplyDate().split(" ")[0] : ""%></span>
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
		document.getElementById('applicantInputSearch').addEventListener('keyup', function() {
			var filter = this.value.toLowerCase();
			var rows = document.querySelectorAll('#applicantsTable tbody tr');
			
			rows.forEach(function(row) {
				// Skip if empty record row
				if (row.cells.length < 6) return;
				
				var name = row.cells[1].textContent.toLowerCase();
				var email = row.cells[2].textContent.toLowerCase();
				var qualification = row.cells[3].textContent.toLowerCase();
				var jobTitle = row.cells[4].textContent.toLowerCase();
				
				if (name.indexOf(filter) > -1 || email.indexOf(filter) > -1 || qualification.indexOf(filter) > -1 || jobTitle.indexOf(filter) > -1) {
					row.style.display = "";
				} else {
					row.style.display = "none";
				}
			});
		});
	</script>
</body>
</html>
