package org.web.pahanaedu.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.web.pahanaedu.dao.ItemDAO;
import org.web.pahanaedu.model.Item;

import java.io.IOException;
import java.util.List;

public class ItemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> itemList = ItemDAO.getAllItems();
        request.setAttribute("itemList", itemList);
        request.getRequestDispatcher("items.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ItemDAO.deleteItem(id);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Item item = new Item();
            item.setId(id);
            item.setName(name);
            item.setPrice(price);
            item.setQuantity(quantity);

            ItemDAO.updateItem(item);
        } else {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Item item = new Item();
            item.setName(name);
            item.setPrice(price);
            item.setQuantity(quantity);

            ItemDAO.addItem(item);
        }

        response.sendRedirect("items");
    }
}
