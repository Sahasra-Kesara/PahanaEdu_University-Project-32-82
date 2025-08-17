package org.web.pahanaedu.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/items/list")
public class ItemListServlet extends HttpServlet {

    static class Item {
        public int id;
        public String name;
        public double price;
        public int quantity;

        public Item(int id, String name, double price, int quantity) {
            this.id = id;
            this.name = name;
            this.price = price;
            this.quantity = quantity;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> itemList = new ArrayList<>();
        response.setContentType("application/json");

        try {
            // Load H2 Driver
            Class.forName("org.h2.Driver");

            // Connect to H2 Database
            Connection conn = DriverManager.getConnection(
                    "jdbc:h2:tcp://localhost/~/pahanaedu", "sa", "");

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, name, price, quantity FROM item");

            while (rs.next()) {
                itemList.add(new Item(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("quantity")));
            }

            rs.close();
            stmt.close();
            conn.close();

            ObjectMapper mapper = new ObjectMapper();
            response.getWriter().print(mapper.writeValueAsString(itemList));

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("{\"error\": \"" + e.getMessage().replace("\"", "") + "\"}");
        }
    }
}
