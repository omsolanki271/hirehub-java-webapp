<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<%@include file="all_component/all_css.jsp"%>

<style type="text/css">
.back-img {
	background: url("img/heroadmin.jpg");
	height: 98vh;
	width: 100%;
	background-repeat: no-repeat;
	background-size: cover;
}

.back-img h1 {
	color: white;
	padding-top: 200px;
}
</style>

</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="container-fluid back-img">
		<div class="container-fluid back-img d-flex justify-content-center align-items-center ">
			<h1 class="text-dark">Welcome Admin</h1>
		</div>
	</div>

</body>
</html>