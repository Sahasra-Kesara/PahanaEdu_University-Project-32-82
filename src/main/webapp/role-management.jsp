<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.web.pahanaedu.model.Admin" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Role Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3>Role Management</h3>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            Add New Admin/Staff
        </div>
        <div class="card-body">
            <form action="role-management" method="post" class="row g-3">
                <input type="hidden" name="action" value="add">
                <div class="col-md-4">
                    <label class="form-label">Username</label>
                    <input type="text" name="newUsername" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Password</label>
                    <input type="password" name="newPassword" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Role</label>
                    <select name="newRole" class="form-select" required>
                        <option value="admin">Admin</option>
                        <option value="staff">Staff</option>
                    </select>
                </div>
                <div class="col-md-1 d-flex align-items-end">
                    <button type="submit" class="btn btn-success w-100">Add</button>
                </div>
            </form>
        </div>
    </div>

    <table class="table table-bordered">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Current Role</th>
            <th>Change Role</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Admin> admins = (List<Admin>) request.getAttribute("adminList");
            for (Admin admin : admins) {
        %>
        <tr>
            <td><%= admin.getId() %></td>
            <td><%= admin.getUsername() %></td>
            <td><%= admin.getRole() %></td>
            <td>
                <form method="post" action="role-management" class="d-flex">
                    <input type="hidden" name="username" value="<%= admin.getUsername() %>">
                    <input type="hidden" name="action" value="update">
                    <select name="role" class="form-select me-2">
                        <option value="admin" <%= "admin".equals(admin.getRole()) ? "selected" : "" %>>Admin</option>
                        <option value="staff" <%= "staff".equals(admin.getRole()) ? "selected" : "" %>>Staff</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
