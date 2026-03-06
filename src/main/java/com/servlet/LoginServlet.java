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

import com.entity.User;


@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
		
		try
		{
			String email = request.getParameter("email");
			String pw = request.getParameter("password");
			
			
			if("admin@gmail.com".equals(email) && "123".equals(pw))
			{
			    User u = new User();
			    u.setRole("admin");

			    HttpSession session = request.getSession();
			    session.setAttribute("userobj", u);

			    response.sendRedirect("admin.jsp");
			}
			else
			{
				response.sendRedirect("login.jsp");
			}
			
			/*
			 * out.println(email); out.print(pw);
			 */
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
