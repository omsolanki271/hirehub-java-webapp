package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DB.DBConnect;
import com.dao.ApplyJobDao;

@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		com.entity.User user = (com.entity.User) session.getAttribute("userobj");
		
		if (user == null) {
			session.setAttribute("failMsg", "Please login to apply for a job");
			response.sendRedirect("login.jsp");
			return;
		}
		
		try {
			int userId = user.getId();
			int jobId = Integer.parseInt(request.getParameter("jid"));
			
			ApplyJobDao dao = new ApplyJobDao(DBConnect.getConn());
			
			if (dao.isAlreadyApplied(userId, jobId)) {
				session.setAttribute("failMsg", "Already Applied For This Job");
				response.sendRedirect("user/job_details.jsp?id=" + jobId);
			} else {
				boolean f = dao.applyJob(userId, jobId);
				if (f) {
					session.setAttribute("sucMsg", "Job Applied Successfully");
					response.sendRedirect("user/job_details.jsp?id=" + jobId);
				} else {
					session.setAttribute("failMsg", "Something went wrong on server");
					response.sendRedirect("user/job_details.jsp?id=" + jobId);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("failMsg", "Invalid Request parameters");
			response.sendRedirect("user/jobs.jsp");
		}
	}
}
