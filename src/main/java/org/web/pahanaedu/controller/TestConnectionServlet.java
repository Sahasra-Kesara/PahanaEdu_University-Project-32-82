package org.web.pahanaedu.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.web.pahanaedu.util.DatabaseUtil;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/test")
public class TestConnectionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try (Connection conn = DatabaseUtil.getConnection()) {
            res.getWriter().write("✅ H2 database file created successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().write("❌ Failed: " + e.getMessage());
        }
    }
}
