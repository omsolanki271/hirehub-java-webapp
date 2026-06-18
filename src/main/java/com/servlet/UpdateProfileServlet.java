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

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("userobj");
		
		if (user == null) {
			session.setAttribute("failMsg", "Please login to update profile");
			response.sendRedirect("login.jsp");
			return;
		}
		
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			String fullname = request.getParameter("fullname");
			String qualification = request.getParameter("qualification");
			
			if (user.getId() != id) {
				session.setAttribute("failMsg", "Unauthorized access");
				response.sendRedirect("user/profile.jsp");
				return;
			}
			
			if (fullname == null || fullname.trim().isEmpty() || qualification == null || qualification.trim().isEmpty()) {
				session.setAttribute("failMsg", "All fields are required");
				response.sendRedirect("user/profile.jsp");
				return;
			}
			
			User u = new User();
			u.setId(id);
			u.setFullname(fullname.trim());
			u.setQualification(qualification.trim());
			
			UserDao dao = new UserDao(DBConnect.getConn());
			boolean f = dao.updateProfile(u);
			
			if (f) {
				user.setFullname(fullname.trim());
				user.setQualification(qualification.trim());
				session.setAttribute("userobj", user);
				session.setAttribute("sucMsg", "Profile Updated Successfully");
			} else {
				session.setAttribute("failMsg", "Something went wrong on server");
			}
			
			response.sendRedirect("user/profile.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("failMsg", "Invalid update parameters");
			response.sendRedirect("user/profile.jsp");
		}
	}
}
