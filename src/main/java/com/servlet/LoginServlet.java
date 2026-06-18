package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.attribute.UserDefinedFileAttributeView;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DB.DBConnect;
import com.dao.AdminDao;
import com.dao.UserDao;
import com.entity.Admin;
import com.entity.User;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();

		try {
			String email = request.getParameter("email");
			String pw = request.getParameter("password");

			AdminDao dao = new AdminDao(DBConnect.getConn());

			Admin admin = dao.login(email, pw);

			HttpSession session = request.getSession(true);
			if (admin != null) 
			{
				session.setAttribute("adminobj", admin);

				response.sendRedirect("admin/admin.jsp");
			} 
			else 
			{
				UserDao userDao = new UserDao(DBConnect.getConn());

				User user = userDao.login(email, pw);
				if (user != null) {
					session.setAttribute("userobj", user);
					response.sendRedirect("user/user_home.jsp");
				} else {
					session.setAttribute("failMsg", "Invalid Email or Password");

					response.sendRedirect("login.jsp");
				}
			}

			/*
			 * out.println(email); out.print(pw);
			 *
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
