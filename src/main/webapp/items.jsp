<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.web.pahanaedu.model.Item" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Item Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3>Item Management</h3>

    <form action="items" method="post" class="row g-3">
        <input type="hidden" name="action" value="add">
        <div class="col-md-4">
            <input type="text" name="name" class="form-control" placeholder="Item Name" required>
        </div>
        <div class="col-md-3">
            <input type="number" step="0.01" name="price" class="form-control" placeholder="Price" required>
        </div>
        <div class="col-md-3">
            <input type="number" name="quantity" class="form-control" placeholder="Quantity" required>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-success w-100">Add Item</button>
        </div>
    </form>

    <table class="table mt-4 table-bordered">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price (Rs.)</th>
            <th>Quantity</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Item> itemList = (List<Item>) request.getAttribute("itemList");
            String editId = request.getParameter("editId");

            for (Item item : itemList) {
                boolean isEditing = String.valueOf(item.getId()).equals(editId);
        %>
        <tr>
            <td><%= item.getId() %></td>
            <% if (isEditing) { %>
            <form action="items" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <td><input type="text" name="name" value="<%= item.getName() %>" class="form-control"></td>
                <td><input type="number" step="0.01" name="price" value="<%= item.getPrice() %>" class="form-control"></td>
                <td><input type="number" name="quantity" value="<%= item.getQuantity() %>" class="form-control"></td>
                <td>
                    <button type="submit" class="btn btn-success btn-sm">Save</button>
                    <a href="items" class="btn btn-secondary btn-sm">Cancel</a>
                </td>
            </form>
            <% } else { %>
            <td><%= item.getName() %></td>
            <td><%= item.getPrice() %></td>
            <td><%= item.getQuantity() %></td>
            <td class="d-flex gap-1">
                <form method="get" action="items">
                    <input type="hidden" name="editId" value="<%= item.getId() %>">
                    <button class="btn btn-warning btn-sm" type="submit">Edit</button>
                </form>
                <form action="items" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= item.getId() %>">
                    <button class="btn btn-danger btn-sm" type="submit">Delete</button>
                </form>
            </td>
            <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
