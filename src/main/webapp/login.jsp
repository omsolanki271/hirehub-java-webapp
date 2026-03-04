<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>

<%@include file="all_component/all_css.jsp"%>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	<div class="container d-flex justify-content-center align-items-center" style="height:100vh;">

    <div class="card p-4 shadow-lg" style="width:400px;">
        
        <h3 class="text-center mb-4">Login to HireHub</h3>
        
        <form action="loginServlet" method="post">
            
            <div class="form-group">
                <label>Email address</label>
                <input type="email" class="form-control" placeholder="Enter email" name="email" required>
            </div>
            
            <div class="form-group">
                <label>Password</label>
                <input type="password" class="form-control" placeholder="Enter password" name="password" required>
            </div>
            
            <button type="submit" class="btn btn-primary btn-block">
                Login
            </button>
            
            <div class="text-center mt-3">
                <a href="signup.jsp">Don't have an account? Sign Up</a>
            </div>
            
        </form>
        
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
</body>

</html>

