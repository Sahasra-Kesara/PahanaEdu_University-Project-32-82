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

@WebServlet("/billing/calculate")
public class BillingServlet extends HttpServlet {

    private final ObjectMapper mapper = new ObjectMapper();
    private static final double RATE_PER_UNIT = 50.0;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        String accountNo = req.getParameter("accountNo");

        if (accountNo == null || accountNo.isEmpty()) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(res.getWriter(), new Error("Account number is required."));
            return;
        }

        Customer customer = CustomerDAO.getCustomerByAccountNo(accountNo);

        if (customer == null) {
            res.setStatus(HttpServletResponse.SC_NOT_FOUND);
            mapper.writeValue(res.getWriter(), new Error("Customer not found."));
            return;
        }

        double totalBill = customer.getUnits() * RATE_PER_UNIT;

        BillingResponse response = new BillingResponse(
                customer.getName(),
                customer.getUnits(),
                RATE_PER_UNIT,
                totalBill);

        res.setStatus(HttpServletResponse.SC_OK);
        mapper.writeValue(res.getWriter(), response);
    }

    // Response DTO
    private static class BillingResponse {
        public String customerName;
        public int units;
        public double ratePerUnit;
        public double total;

        public BillingResponse(String customerName, int units, double ratePerUnit, double total) {
            this.customerName = customerName;
            this.units = units;
            this.ratePerUnit = ratePerUnit;
            this.total = total;
        }
    }

    // Error DTO
    private static class Error {
        public String message;

        public Error(String message) {
            this.message = message;
        }
    }
}
