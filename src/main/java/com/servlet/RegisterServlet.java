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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fullname =
                request.getParameter("fullname");

        String qualification =
                request.getParameter("qualification");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        User u = new User();

        u.setFullname(fullname);
        u.setQualification(qualification);
        u.setEmail(email);
        u.setPassword(password);

        UserDao dao =
                new UserDao(DBConnect.getConn());

        HttpSession session =
                request.getSession();

        boolean f = dao.register(u);

        if(f)
        {
            session.setAttribute(
                    "sucMsg",
                    "Registration Successfully");

            response.sendRedirect("signup.jsp");
        }
        else
        {
            session.setAttribute(
                    "failMsg",
                    "Something went wrong");

            response.sendRedirect("signup.jsp");
        }
    }
}