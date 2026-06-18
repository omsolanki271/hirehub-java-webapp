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

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			
			UserDao dao = new UserDao(DBConnect.getConn());
			boolean f = dao.deleteUser(id);
			
			HttpSession session = request.getSession();
			if (f) {
				session.setAttribute("sucMsg", "User Deleted Successfully");
			} else {
				session.setAttribute("failMsg", "Something went wrong on server");
			}
			
			response.sendRedirect("admin/view_users.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("admin/view_users.jsp");
		}
	}
}
