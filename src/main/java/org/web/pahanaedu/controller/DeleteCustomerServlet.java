package org.web.pahanaedu.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.web.pahanaedu.dao.CustomerDAO;

import java.io.IOException;

@WebServlet("/customer/delete")
public class DeleteCustomerServlet extends HttpServlet {
    private final ObjectMapper mapper = new ObjectMapper();

    protected void doDelete(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String accountNo = req.getParameter("accountNo");

        boolean success = false;
        if (accountNo != null && !accountNo.isEmpty()) {
            success = CustomerDAO.deleteCustomer(accountNo);
        }

        res.setContentType("application/json");
        mapper.writeValue(res.getWriter(),
                success ? new Response("Customer deleted successfully") : new Response("Failed to delete customer"));
    }

    private static class Response {
        public String message;

        public Response(String msg) {
            this.message = msg;
        }
    }
}
