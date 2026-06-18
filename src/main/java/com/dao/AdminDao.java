package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.Admin;

public class AdminDao {
	 private Connection conn;

	    public AdminDao(Connection conn) {
	        this.conn = conn;
	    }

	    public Admin login(String email, String password) {

	        Admin admin = null;

	        try {

	            String sql =
	                    "select * from admin where email=? and password=?";

	            PreparedStatement ps =
	                    conn.prepareStatement(sql);

	            ps.setString(1, email);
	            ps.setString(2, password);

	            ResultSet rs = ps.executeQuery();

	            if(rs.next())
	            {
	                admin = new Admin();

	                admin.setId(rs.getInt("id"));
	                admin.setEmail(rs.getString("email"));
	                admin.setPassword(rs.getString("password"));
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return admin;
	    }

	    public boolean changePassword(int id, String currentPassword, String newPassword) {
	        boolean f = false;
	        try {
	            String sql = "update admin set password=? where id=? and password=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, newPassword);
	            ps.setInt(2, id);
	            ps.setString(3, currentPassword);
	            int i = ps.executeUpdate();
	            if (i == 1) {
	                f = true;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return f;
	    }
}
