<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Job - HireHub</title>

<%@include file="all_component/all_css.jsp"%>

<style>
body{
    background-color: #f4f6f9;
}

.add-job-container{
    margin-top: 80px;
    margin-bottom: 50px;
}

.card{
    border-radius: 12px;
}

.form-control, .custom-select{
    height: 40px;
}

textarea{
    resize: none;
}
</style>

</head>
<body>

<%@include file="all_component/navbar.jsp"%>

<div class="container add-job-container">

    <div class="card shadow p-4">

        <!-- Header -->
        <div class="text-center mb-4">
            <i class="fa-solid fa-users fa-2x text-success"></i>
            <h4 class="mt-2 text-success font-weight-bold">Add Jobs</h4>
        </div>

        <!-- Form -->
        <form action="AddJobServlet" method="post">

            <!-- Job Title -->
            <div class="form-group">
                <label>Enter Title</label>
                <input type="text" name="title" class="form-control" required>
            </div>

            <!-- Row for dropdowns -->
            <div class="form-row">

                <div class="form-group col-md-4">
                    <label>Location</label>
                    <select name="location" class="custom-select" required>
                        <option value="">Choose...</option>
                        <option value="Ahmedabad">Ahmedabad</option>
                        <option value="Surat">Surat</option>
                        <option value="Rajkot">Rajkot</option>
                        <option value="Vadodara">Vadodara</option>
                        <option value="Remote">Remote</option>
                    </select>
                </div>

                <div class="form-group col-md-4">
                    <label>Category</label>
                    <select name="category" class="custom-select" required>
                        <option value="">Choose...</option>
                        <option value="IT">IT</option>
                        <option value="Banking">Banking</option>
                        <option value="Marketing">Marketing</option>
                        <option value="HR">HR</option>
                        <option value="Sales">Sales</option>
                    </select>
                </div>

                <div class="form-group col-md-4">
                    <label>Status</label>
                    <select name="status" class="custom-select">
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
            </div>

            <!-- Description -->
            <div class="form-group">
                <label>Enter Description</label>
                <textarea name="description" class="form-control" rows="5" required></textarea>
            </div>

            <!-- Button -->
            <div class="text-left">
                <button type="submit" class="btn btn-success px-4">
                    Publish Job
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>