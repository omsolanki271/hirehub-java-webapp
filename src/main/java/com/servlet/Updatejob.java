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

@WebServlet("/Updatejob")
public class Updatejob extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Updatejob() {
        super();
   
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String location = request.getParameter("location");
		String category = request.getParameter("category");
		String status = request.getParameter("status");
		String dest = request.getParameter("description");

		Jobs j = new Jobs();
		j.setId(id);
		j.setTitle(title);
		j.setLocation(location);
		j.setCategory(category);
		j.setStatus(status);
		j.setDescription(dest);
		
		HttpSession session = request.getSession(false);
		
		JobDao dao = new JobDao(DBConnect.getConn());
		boolean jobs = dao.getUpdate(j);
		if(jobs)
		{
			session.setAttribute("sucMsg", "Job Post update sucessfully..");
			response.sendRedirect("admin/view_jobs.jsp");
		}
		else
		{
			session.setAttribute("sucMsg", "Something Wrong on server..");
			response.sendRedirect("admin/view_jobs.jsp");
		}
		
	}

}
