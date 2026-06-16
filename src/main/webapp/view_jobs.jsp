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
    border:none;
    border-radius:12px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
    transition:0.3s;
}

.job-card:hover{
    transform:translateY(-3px);
    box-shadow:0 4px 15px rgba(0,0,0,0.15);
}

.job-title{
    font-size:24px;
    font-weight:600;
    color:#0d6efd;
}

.job-desc{
    color:#555;
    font-size:15px;
}

.badge-box{
    font-size:14px;
    padding:8px 12px;
    border-radius:20px;
    margin-right:10px;
}

.publish-date{
    color:#6c757d;
    font-size:14px;
}

.btn-action{
    width:100px;
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
%><div class="card mt-4 job-card">
    <div class="card-body">

        <div class="text-center mb-3">
            <i class="fa fa-briefcase fa-2x text-primary"></i>
        </div>

        <h3 class="text-center job-title">
            <%=j.getTitle()%>
        </h3>

        <p class="text-center job-desc">
            <%=j.getDescription()%>
        </p>

        <div class="text-center mt-3">

            <span class="badge badge-primary badge-box">
                <i class="fa fa-layer-group"></i>
                <%=j.getCategory()%>
            </span>

            <span class="badge badge-success badge-box">
                <i class="fa fa-check-circle"></i>
                <%=j.getStatus()%>
            </span>

            <span class="badge badge-warning badge-box">
                <i class="fa fa-map-marker-alt"></i>
                <%=j.getLocation()%>
            </span>

        </div>

        <hr>

        <div class="d-flex justify-content-between align-items-center">

            <span class="publish-date">
                <i class="fa fa-calendar"></i>
                Published: <%=j.getPdate()%>
            </span>

            <div>

                <a href="edit_job.jsp?id=<%=j.getId()%>"
                   class="btn btn-success btn-sm btn-action">
                    Edit
                </a>

                <a href="delete?id=<%=j.getId()%>"
                   class="btn btn-danger btn-sm btn-action"
                   onclick="return confirm('Are you sure?')">
                    Delete
                </a>

            </div>

        </div>

    </div>
</div>
		<%
}
%>

</div>

</body>
</html>
