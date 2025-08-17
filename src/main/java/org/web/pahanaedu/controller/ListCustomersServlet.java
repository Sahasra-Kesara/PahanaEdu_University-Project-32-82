package org.web.pahanaedu.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.web.pahanaedu.dao.CustomerDAO;
import org.web.pahanaedu.model.Customer;

import java.io.IOException;
import java.util.List;

@WebServlet("/customer/list")
public class ListCustomersServlet extends HttpServlet {
    private final ObjectMapper mapper = new ObjectMapper();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        List<Customer> customers = CustomerDAO.getAllCustomers();

        res.setContentType("application/json");
        mapper.writeValue(res.getWriter(), customers);
    }
}
