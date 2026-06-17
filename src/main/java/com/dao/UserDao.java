package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}