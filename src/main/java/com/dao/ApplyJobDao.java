package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.ApplyJob;

public class ApplyJobDao {
	private Connection conn;

	public ApplyJobDao(Connection conn) {
		super();
		this.conn = conn;
	}

	public List<ApplyJob> getAllApplicants() {
		List<ApplyJob> list = new ArrayList<ApplyJob>();
		ApplyJob aj = null;
		
		try {
			String sql = "select aj.id, aj.user_id, aj.job_id, aj.apply_date, u.fullname, u.email, u.qualification, j.title "
					+ "from apply_job aj "
					+ "inner join users u on aj.user_id = u.id "
					+ "inner join jobs j on aj.job_id = j.id "
					+ "order by aj.id desc";
					
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				aj = new ApplyJob();
				aj.setId(rs.getInt("id"));
				aj.setUserId(rs.getInt("user_id"));
				aj.setJobId(rs.getInt("job_id"));
				aj.setApplyDate(rs.getString("apply_date"));
				aj.setUserName(rs.getString("fullname"));
				aj.setUserEmail(rs.getString("email"));
				aj.setUserQualification(rs.getString("qualification"));
				aj.setJobTitle(rs.getString("title"));
				list.add(aj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public boolean applyJob(int userId, int jobId) {
		boolean f = false;
		try {
			String sql = "insert into apply_job(user_id, job_id) values(?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setInt(2, jobId);
			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean isAlreadyApplied(int userId, int jobId) {
		boolean f = false;
		try {
			String sql = "select * from apply_job where user_id=? and job_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setInt(2, jobId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<ApplyJob> getApplicationsByUser(int userId) {
		List<ApplyJob> list = new ArrayList<ApplyJob>();
		try {
			String sql = "select aj.id, aj.user_id, aj.job_id, aj.apply_date, j.title, j.category, j.location, j.status "
					+ "from apply_job aj "
					+ "inner join jobs j on aj.job_id = j.id "
					+ "where aj.user_id = ? "
					+ "order by aj.id desc";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ApplyJob aj = new ApplyJob();
				aj.setId(rs.getInt("id"));
				aj.setUserId(rs.getInt("user_id"));
				aj.setJobId(rs.getInt("job_id"));
				aj.setApplyDate(rs.getString("apply_date"));
				aj.setJobTitle(rs.getString("title"));
				aj.setJobCategory(rs.getString("category"));
				aj.setJobLocation(rs.getString("location"));
				aj.setJobStatus(rs.getString("status"));
				list.add(aj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
