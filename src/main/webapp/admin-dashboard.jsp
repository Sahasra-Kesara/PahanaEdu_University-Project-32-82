<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Apple-like design */
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #fff;
            position: relative;
        }

        /* Background image with dark overlay */
        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url("https://thumbs.dreamstime.com/b/modern-spacious-bookshop-natural-color-29821239.jpg") no-repeat center center/cover;
            filter: brightness(0.4); /* dim background */
            z-index: -1;
        }

        .navbar {
            background: rgba(0, 0, 0, 0.85) !important;
            backdrop-filter: saturate(180%) blur(20px);
        }
        .navbar-brand {
            font-weight: 600;
            font-size: 1.3rem;
            color: #fff !important;
            letter-spacing: 0.5px;
        }
        .btn-outline-danger {
            border-radius: 20px;
            padding: 5px 15px;
        }

        h2, h5, p {
            color: #fff !important;
        }

        .dashboard-card {
            border-radius: 1rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: rgba(255, 255, 255, 0.1) !important;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.25);
        }
        .icon-wrapper {
            width: 72px;
            height: 72px;
            margin: 0 auto 1rem auto;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .icon-svg {
            width: 36px;
            height: 36px;
            fill: #fff;
        }
        .card-title {
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }
        .card-text {
            color: #e0e0e0;
            font-size: 0.95rem;
        }
        footer {
            margin-top: auto;
            padding: 1rem 0;
            background: rgba(0, 0, 0, 0.85);
            color: #bbb;
            text-align: center;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<nav class="navbar shadow-sm mb-5">
    <div class="container">
        <a class="navbar-brand" href="#"> Admin Dashboard</a>
        <a href="logout" class="btn btn-outline-danger btn-sm">Logout</a>
    </div>
</nav>

<div class="container">
    <div class="text-center mb-4">
        <h2 class="fw-bold">Welcome, Admin</h2>
        <p class="lead">Manage user accounts and roles efficiently</p>
    </div>

    <div class="row g-4 justify-content-center">

        <!-- Customer Management -->
        <div class="col-sm-8 col-md-6 col-lg-4">
            <a href="add-customer.html" class="text-decoration-none text-white">
                <div class="card dashboard-card p-4 text-center">
                    <div class="icon-wrapper mb-3">
                        <svg class="icon-svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path d="M15 14c2.67 0 8 1.34 8 4v2H7v-2c0-2.66 5.33-4 8-4zm-6-2c1.66 0 3-1.34 3-3S10.66 6 9 6 6 7.34 6 9s1.34 3 3 3zm9-7v2h-2v2h-2V7h-2V5h2V3h2v2h2z"/>
                        </svg>
                    </div>
                    <h5 class="card-title">Customer Management</h5>
                    <p class="card-text">Create, edit or delete customer accounts.</p>
                </div>
            </a>
        </div>

        <!-- Role Management -->
        <div class="col-sm-8 col-md-6 col-lg-4">
            <a href="role-management" class="text-decoration-none text-white">
                <div class="card dashboard-card p-4 text-center">
                    <div class="icon-wrapper mb-3">
                        <svg class="icon-svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path d="M12 1C9.79 1 8 2.79 8 5v3H7c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h10c1.1 0 2-.9 2-2v-8c0-1.1-.9-2-2-2h-1V5c0-2.21-1.79-4-4-4zM10 8V5c0-1.1.9-2 2-2s2 .9 2 2v3h-4zm2 7c-.83 0-1.5-.67-1.5-1.5S13.17 12 14 12s1.5.67 1.5 1.5S14.83 15 14 15z"/>
                        </svg>
                    </div>
                    <h5 class="card-title">Role Management</h5>
                    <p class="card-text">Change roles or add new admin/staff.</p>
                </div>
            </a>
        </div>

        <!-- Items Management -->
        <div class="col-sm-8 col-md-6 col-lg-4">
            <a href="items" class="text-decoration-none text-white">
                <div class="card dashboard-card p-4 text-center">
                    <div class="icon-wrapper mb-3">
                        <svg class="icon-svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path d="M18 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12V2zm-6 17v-5H8v-2h4v-5h2v5h4v2h-4v5h-2z"/>
                        </svg>
                    </div>
                    <h5 class="card-title">Items Management</h5>
                    <p class="card-text">Add, update or delete items.</p>
                </div>
            </a>
        </div>

    </div>
</div>

<footer>
    &copy; 2025 PahanaEdu. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
