package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DB.DBConnect;
import com.dao.JobDao;
import com.entity.Jobs;

@WebServlet("/delete")
public class DeletePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeletePostServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		
		JobDao dao = new JobDao(DBConnect.getConn());
		boolean status = dao.getdel(id);
		
		
		HttpSession session = request.getSession(false);
		
		if(status)
		{
			session.setAttribute("sucMsg", "Job Post Delete sucessfully..");
			response.sendRedirect("view_jobs.jsp");
		}
		else
		{
			session.setAttribute("sucMsg", "Something Wrong on server..");
			response.sendRedirect("view_jobs.jsp");
		}
		
		
	}

}
