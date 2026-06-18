package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DB.DBConnect;
import com.dao.UserDao;
import com.entity.User;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("userobj");
		
		if (user == null) {
			session.setAttribute("failMsg", "Please login to change password");
			response.sendRedirect("login.jsp");
			return;
		}
		
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			String currentPassword = request.getParameter("currentPassword");
			String newPassword = request.getParameter("newPassword");
			String confirmPassword = request.getParameter("confirmPassword");
			
			if (user.getId() != id) {
				session.setAttribute("failMsg", "Unauthorized access");
				response.sendRedirect("user/profile.jsp");
				return;
			}
			
			if (currentPassword == null || currentPassword.isEmpty() ||
				newPassword == null || newPassword.isEmpty() ||
				confirmPassword == null || confirmPassword.isEmpty()) {
				session.setAttribute("failMsg", "All password fields are required");
				response.sendRedirect("user/profile.jsp");
				return;
			}
			
			if (!newPassword.equals(confirmPassword)) {
				session.setAttribute("failMsg", "New Password and Confirm Password do not match");
				response.sendRedirect("user/profile.jsp");
				return;
			}
			
			UserDao dao = new UserDao(DBConnect.getConn());
			boolean f = dao.changePassword(id, currentPassword, newPassword);
			
			if (f) {
				user.setPassword(newPassword);
				session.setAttribute("userobj", user);
				session.setAttribute("sucMsg", "Password Changed Successfully");
			} else {
				session.setAttribute("failMsg", "Incorrect Current Password");
			}
			
			response.sendRedirect("user/profile.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("failMsg", "Invalid password change parameters");
			response.sendRedirect("user/profile.jsp");
		}
	}
}
