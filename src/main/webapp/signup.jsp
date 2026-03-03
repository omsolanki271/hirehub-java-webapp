<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration - HireHub</title>

<%@include file="all_component/all_css.jsp"%>

<style>
body{
    background-color: white;
}

/* Center container properly */
.register-container{
    margin-top: 80px;
    margin-bottom: 50px;
}

/* Card styling */
.register-card{
    width: 380px;
    border-radius: 12px;
}

/* Compact input */
.form-control{
    height: 38px;
    font-size: 14px;
}
</style>

</head>
<body>

<%@include file="all_component/navbar.jsp"%>

<div class="container register-container d-flex justify-content-center">

    <div class="card register-card p-3 shadow">

        <!-- Title -->
        <div class="text-center mb-3">
            <i class="fa-solid fa-user-plus fa-lg mb-2"></i>
            <h4 class="font-weight-bold">Registration</h4>
        </div>

        <!-- Form -->
        <form action="registerServlet" method="post">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullname" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Qualification</label>
                <input type="text" name="qualification" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary btn-block">
                Register
            </button>

            <div class="text-center mt-3">
                <a href="login.jsp">Already have an account? Login</a>
            </div>

        </form>

    </div>

</div>

</body>
</html>