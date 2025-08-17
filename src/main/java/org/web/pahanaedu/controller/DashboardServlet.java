package org.web.pahanaedu.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure only logged-in admin can access
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin-dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
