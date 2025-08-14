package org.web.pahanaedu.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.web.pahanaedu.util.DatabaseUtil;
import org.web.pahanaedu.model.Admin;

public class AdminDAO {

    public static boolean validateAdmin(String username, String password) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM admin WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password); // In production, hash this
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Admin getAdminByUsername(String username) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM admin WHERE username=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
                admin.setRole(rs.getString("role"));
                return admin;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM admin";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
                admin.setRole(rs.getString("role"));
                admins.add(admin);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admins;
    }

    public static boolean addAdmin(String username, String password, String role) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "INSERT INTO admin (username, password, role) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password); // You should hash this in production
            stmt.setString(3, role);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateRole(String username, String newRole) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "UPDATE admin SET role=? WHERE username=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newRole);
            stmt.setString(2, username);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
