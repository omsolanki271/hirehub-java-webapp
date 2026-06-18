package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.User;

public class UserDao {

    private Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    public boolean register(User u) {

        boolean f = false;

        try {

            String sql =
            "insert into users(fullname,email,pass,qualification) values(?,?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, u.getFullname());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getQualification());

            int i = ps.executeUpdate();

            if(i > 0)
            {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    public User login(String email, String password)
    {
        User user = null;

        try
        {
            String sql =
                "select * from users where email=? and pass=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next())
            {
                user = new User();

                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setQualification(rs.getString("qualification"));
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        return user;
    }
    public List<User> getAllUsers()
	{
	    List<User> list = new ArrayList<User>();

	    User u = null;

	    try
	    {
	        String sql = "select * from users order by id desc";

	        PreparedStatement ps =
	                conn.prepareStatement(sql);

	        ResultSet rs = ps.executeQuery();

	        while(rs.next())
	        {
	            u = new User();

	            u.setId(rs.getInt("id"));
	            u.setFullname(rs.getString("fullname"));
	            u.setEmail(rs.getString("email"));
	            u.setQualification(rs.getString("qualification"));
	            u.setRegDate(rs.getString("created_at"));

	            list.add(u);
	        }
	    }
	    catch(Exception e)
	    {
	        e.printStackTrace();
	    }

	    return list;
	}

	public List<User> getRecentUsers() {
		List<User> list = new ArrayList<User>();
		User u = null;
		try {
			String sql = "select * from users order by id desc limit 5";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setFullname(rs.getString("fullname"));
				u.setEmail(rs.getString("email"));
				u.setQualification(rs.getString("qualification"));
				u.setRegDate(rs.getString("created_at"));
				list.add(u);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean deleteUser(int id) {
		boolean f = false;
		try {
			String sql = "delete from users where id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			int i = ps.executeUpdate();
			if (i > 0) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public User getUserById(int id) {
		User u = null;
		try {
			String sql = "select * from users where id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setFullname(rs.getString("fullname"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("pass"));
				u.setQualification(rs.getString("qualification"));
				u.setRegDate(rs.getString("created_at"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return u;
	}

	public boolean updateProfile(User u) {
		boolean f = false;
		try {
			String sql = "update users set fullname = ?, qualification = ? where id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, u.getFullname());
			ps.setString(2, u.getQualification());
			ps.setInt(3, u.getId());
			int i = ps.executeUpdate();
			if (i > 0) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean changePassword(int id, String currentPassword, String newPassword) {
		boolean f = false;
		try {
			String sql = "update users set pass = ? where id = ? and pass = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, newPassword);
			ps.setInt(2, id);
			ps.setString(3, currentPassword);
			int i = ps.executeUpdate();
			if (i > 0) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

}