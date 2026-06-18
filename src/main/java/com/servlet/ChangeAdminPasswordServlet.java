package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DB.DBConnect;
import com.dao.AdminDao;
import com.entity.Admin;

@WebServlet("/changeAdminPassword")
public class ChangeAdminPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			String currentPassword = request.getParameter("currentPassword");
			String newPassword = request.getParameter("newPassword");
			String confirmPassword = request.getParameter("confirmPassword");
			
			HttpSession session = request.getSession();
			
			if (newPassword == null || newPassword.trim().isEmpty()) {
				session.setAttribute("failMsg", "New password cannot be empty");
				response.sendRedirect("admin/admin_profile.jsp");
				return;
			}
			
			if (!newPassword.equals(confirmPassword)) {
				session.setAttribute("failMsg", "New Password and Confirm Password do not match");
				response.sendRedirect("admin/admin_profile.jsp");
				return;
			}
			
			AdminDao dao = new AdminDao(DBConnect.getConn());
			boolean f = dao.changePassword(id, currentPassword, newPassword);
			
			if (f) {
				Admin admin = (Admin) session.getAttribute("adminobj");
				if (admin != null) {
					admin.setPassword(newPassword);
					session.setAttribute("adminobj", admin);
				}
				session.setAttribute("sucMsg", "Password Changed Successfully");
			} else {
				session.setAttribute("failMsg", "Incorrect Current Password");
			}
			
			response.sendRedirect("admin/admin_profile.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			HttpSession session = request.getSession();
			session.setAttribute("failMsg", "Something went wrong on server");
			response.sendRedirect("admin/admin_profile.jsp");
		}
	}
}
