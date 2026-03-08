package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DB.DBConnect;
import com.dao.JobDao;
import com.entity.Jobs;

@WebServlet("/AddPostServlet")
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddPostServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String title = request.getParameter("title");
		String location = request.getParameter("location");
		String category = request.getParameter("category");
		String status = request.getParameter("status");
		String dest = request.getParameter("description");

		Jobs j = new Jobs();
		
		j.setTitle(title);
		j.setLocation(location);
		j.setCategory(category);
		j.setStatus(status);
		j.setDescription(dest);
		
		JobDao dao = new JobDao(DBConnect.getConn());
		boolean jobs = dao.addJobs(j);
		if(jobs)
		{
			
		}
		else
		{
			
		}
		
	}

}


