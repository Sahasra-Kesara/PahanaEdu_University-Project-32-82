<%--
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: url('https://www.yellowbrickroadbenefitshop.org/wp-content/uploads/2023/08/Yellow-Brick-Road-Carmel-Thrift-Store-Benefit-Shop-By-The-Sea-Monterey-California-Peninsula-Charity-53.jpg') no-repeat center center/cover;
            position: relative;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }

        /* Dark overlay */
        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.6);
            z-index: 0;
        }

        .login-card {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 30px;
            width: 100%;
            max-width: 380px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
            color: white;
        }

        .login-card h4 {
            font-weight: 600;
            margin-bottom: 20px;
        }

        .form-label {
            color: #f5f5f5;
            font-size: 14px;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.15);
            border: none;
            border-radius: 12px;
            color: white;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: none;
            outline: none;
        }

        .btn-login {
            background: #0071e3;
            border: none;
            border-radius: 12px;
            font-weight: 500;
            padding: 10px;
            transition: background 0.3s ease;
        }

        .btn-login:hover {
            background: #005bb5;
        }

        .alert-danger {
            border-radius: 12px;
            background: rgba(255, 0, 0, 0.7);
            border: none;
            color: white;
        }
    </style>
</head>
<body>
<div class="login-card">
    <h4 class="text-center">Admin Login</h4>
    <form method="post" action="login">
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <button type="submit" class="btn btn-login w-100">Login</button>
    </form>
</div>
</body>
</html>
