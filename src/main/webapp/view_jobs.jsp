<%@page import="com.entity.Jobs"%>
<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.dao.JobDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>View Jobs</title>

<%@ include file="all_component/all_css.jsp" %>

<style>
body{
    background-color:#f4f6f9;
}

.job-card{
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
}

.job-title{
    font-size:20px;
    font-weight:bold;
}

.job-desc{
    color:#555;
}

.info-box{
    background:#f8f9fa;
    padding:8px;
    border-radius:5px;
    text-align:center;
}

.btn{
    min-width:80px;
}
</style>

</head>
<body>

<%@ include file="all_component/navbar.jsp" %>

<div class="container mt-4">

<h3 class="text-center text-primary mb-4">All Jobs</h3>

<%
JobDao dao = new JobDao(DBConnect.getConn());
List<Jobs> list = dao.getAlljobs();

for(Jobs j : list)
{
%>

<div class="card mt-3 job-card">
    <div class="card-body">

        <div class="text-center text-primary">
            <i class="fa fa-clipboard fa-2x"></i>
        </div>

        <h4 class="text-center mt-3 job-title">
            <%= j.getTitle() %>
        </h4>

        <p class="text-center job-desc">
            <%= j.getDescription() %>
        </p>

        <div class="row mt-3">

            <div class="col-md-4">
                <div class="info-box">
                    <b>Category</b><br>
                    <%= j.getCategory() %>
                </div>
            </div>

            <div class="col-md-4">
                <div class="info-box">
                    <b>Status</b><br>
                    <%= j.getStatus() %>
                </div>
            </div>

            <div class="col-md-4">
                <div class="info-box">
                    <b>Location</b><br>
                    <%= j.getLocation() %>
                </div>
            </div>

        </div>

        <div class="mt-3">
            <b>Publish Date:</b> <%= j.getPdate() %>
        </div>

        <div class="text-center mt-3">
            <a href="edit_job.jsp?id=<%=j.getId()%>"
               class="btn btn-sm btn-success">
               Edit
            </a>

            <a href="delete?id=<%=j.getId()%>"
               class="btn btn-sm btn-danger"
               onclick="return confirm('Are you sure?')">
               Delete
            </a>
        </div>

    </div>
</div>

<%
}
%>

</div>

</body>
</html>
