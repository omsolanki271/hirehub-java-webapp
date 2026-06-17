<%@page import="com.entity.Jobs"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.dao.JobDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Job - HireHub</title>

<%@include file="../all_component/all_css.jsp"%>

<style>
body {
	background-color: #f4f6f9;
}

.add-job-container {
	margin-top: 80px;
	margin-bottom: 50px;
}

.card {
	border-radius: 12px;
}

.form-control, .custom-select {
	height: 40px;
}

textarea {
	resize: none;
}
</style>

</head>
<body>

	<%@include file="../all_component/navbar.jsp"%>
<c:if test="${empty adminobj}">
    <c:redirect url="login.jsp"/>
</c:if>
	<div class="container add-job-container">

		<div class="card shadow p-4">

			<c:if test="${not empty sucMsg}">
				<div class="alert alert-success" role="alert">${sucMsg}</div>
				<c:remove var="sucMsg" />
			</c:if>

			<!-- Header -->
			<div class="text-center mb-4">
				<i class="fa-solid fa-users fa-2x text-success"></i>
				<h4 class="mt-2 text-success font-weight-bold">Edit Jobs</h4>
			</div>


			<%
			int id = Integer.parseInt(request.getParameter("id"));
			JobDao dao = new JobDao(DBConnect.getConn());
			Jobs j = dao.getEditbyId(id);
			%>

			<!-- Form -->
			<form action="Updatejob" method="post">
				<input type="hidden" name="id" value="<%=j.getId()%>">
				<!-- Job Title -->
				<div class="form-group">
					<label>Enter Title</label> <input type="text" name="title"
						class="form-control" value="<%=j.getTitle()%>" required>
				</div>

				<!-- Row for dropdowns -->
				<div class="form-row">

					<div class="form-group col-md-4">
						<label>Location</label> <select name="location"
							class="custom-select" required>
							<option value="<%=j.getLocation()%>"><%=j.getLocation()%></option>
							<option value="Ahmedabad">Ahmedabad</option>
							<option value="Surat">Surat</option>
							<option value="Rajkot">Rajkot</option>
							<option value="Vadodara">Vadodara</option>
							<option value="Remote">Remote</option>
						</select>
					</div>

					<div class="form-group col-md-4">
						<label>Category</label> <select name="category"
							class="custom-select" required>
							<option value="<%=j.getCategory()%>"><%=j.getCategory()%></option>
							<option value="IT">IT</option>
							<option value="Banking">Banking</option>
							<option value="Marketing">Marketing</option>
							<option value="HR">HR</option>
							<option value="Sales">Sales</option>
						</select>
					</div>

					<div class="form-group col-md-4">
						<label>Status</label> <select name="status" class="custom-select">

							<option value="<%=j.getStatus()%>"><%=j.getStatus()%></option>
							<option value="Active">Active</option>
							<option value="Inactive">Inactive</option>
						</select>
					</div>
				</div>

				<!-- Description -->
				<div class="form-group">
					<label>Enter Description</label>
					<textarea name="description" class="form-control" rows="5" required><%=j.getDescription()%></textarea>
				</div>

				<!-- Button -->
				<div class="text-left">
					<button type="submit" class="btn btn-success px-4">Update
						Job</button>
				</div>

			</form>

		</div>

	</div>

</body>
</html>