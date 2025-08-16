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

@WebServlet("/customer/edit")
public class EditCustomerServlet extends HttpServlet {
    private final ObjectMapper mapper = new ObjectMapper();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Customer customer = mapper.readValue(req.getReader(), Customer.class);
        boolean success = CustomerDAO.updateCustomer(customer);

        res.setContentType("application/json");
        mapper.writeValue(res.getWriter(),
                success ? new Response("Customer updated successfully") : new Response("Failed to update customer"));
    }

    private static class Response {
        public String message;

        public Response(String msg) {
            this.message = msg;
        }
    }
}
