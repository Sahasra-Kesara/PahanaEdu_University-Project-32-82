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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Role Management - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f7;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            color: #1d1d1f;
        }
        h3 {
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }
        .card-header {
            font-weight: 600;
            font-size: 1rem;
            background: #fff !important;
            color: #1d1d1f !important;
            border-bottom: 1px solid #e5e5e7;
        }
        .form-control, .form-select {
            border-radius: 0.8rem;
            padding: 0.6rem 1rem;
            border: 1px solid #d2d2d7;
        }
        .btn {
            border-radius: 2rem;
            font-weight: 500;
            padding: 0.5rem 1.4rem;
        }
        .btn-success {
            background-color: #0071e3;
            border: none;
        }
        .btn-success:hover {
            background-color: #005bb5;
        }
        .btn-primary {
            background-color: #0071e3;
            border: none;
        }
        .btn-primary:hover {
            background-color: #005bb5;
        }
        .btn-secondary {
            background-color: #e5e5e7;
            border: none;
            color: #1d1d1f;
        }
        .btn-secondary:hover {
            background-color: #d2d2d7;
        }
        table {
            border-radius: 1rem;
            overflow: hidden;
        }
        thead {
            background: #f5f5f7;
            font-weight: 600;
        }
        .alert {
            border-radius: 0.8rem;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h3>Role Management</h3>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success text-center"><%= request.getAttribute("success") %></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger text-center"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="row g-4">
        <!-- Left Column: Form -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    Add New Admin / Staff
                </div>
                <div class="card-body">
                    <form action="role-management" method="post" class="row g-3">
                        <input type="hidden" name="action" value="add">
                        <div class="col-12">
                            <label class="form-label">Username</label>
                            <input type="text" name="newUsername" class="form-control" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Password</label>
                            <input type="password" name="newPassword" class="form-control" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Role</label>
                            <select name="newRole" class="form-select" required>
                                <option value="admin">Admin</option>
                                <option value="staff">Staff</option>
                            </select>
                        </div>
                        <div class="col-12 d-grid">
                            <button type="submit" class="btn btn-success">➕ Add User</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Right Column: Data Table -->
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    Admin / Staff List
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
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
                </div>
            </div>
            <div class="mt-3 text-end">
                <a href="admin-dashboard.jsp" class="btn btn-secondary">← Back to Dashboard</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
