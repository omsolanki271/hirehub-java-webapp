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
}
</style>

</head>
<body>

<%@ include file="all_component/navbar.jsp" %>

<div class="container mt-4">

    <div class="row">
        <div class="col-md-12">

            <h5 class="text-center text-primary">All Jobs</h5>

			<%
			JobDao dao = new JobDao(DBConnect.getConn());
			List<Jobs> list = dao.getAlljobs();
			for(Jobs j:list)
			{
			
			%>
			
			
			
            <!-- Job Card -->
            <div class="card mt-3 job-card">
                <div class="card-body">

                    <div class="text-center text-primary">
                        <i class="fa fa-clipboard fa-2x"></i>
                    </div>

                    <br>

                    <div class="form-row">

                        <div class="form-group col-md-3">
                            <input type="text"
                                   class="form-control form-control-sm"
                                   value="<%=j.getLocation() %>"
                                   readonly>
                        </div>

                        <div class="form-group col-md-3">
                            <input type="text"
                                   class="form-control form-control-sm"
                                   value="<%=j.getCategory() %>"
                                   readonly>
                        </div>

                        <div class="form-group col-md-3">
                            <input type="text"
                                   class="form-control form-control-sm"
                                   value="<%=j.getStatus() %>"
                                   readonly>
                        </div>

                    </div>

                    <h6>Publish Date: <%=j.getPdate() %></h6>

                    <div class="text-center mt-2">
                        <a href="#" class="btn btn-sm btn-success text-white">Edit</a>
                        <a href="#" class="btn btn-sm btn-danger text-white">Delete</a>
                    </div>

                </div>
            </div>

            <%	
			}
			%>
        </div>
    </div>

</div>

</body>
</html>