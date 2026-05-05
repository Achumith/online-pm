<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body class="auth-page">
    <div class="auth-card">
        <div class="auth-logo">
            <div class="auth-big-icon">PM</div>
            <h1>Welcome Back</h1>
            <p>Login to manage your projects</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="POST">
            <div class="form-group">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="name@company.com" required autofocus>
            </div>
            <div class="form-group">
                <div class="flex-between mb-2">
                    <label class="form-label mb-0">Password</label>
                    <a href="#" class="text-sm">Forgot?</a>
                </div>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 mt-2">Sign In</button>
        </form>

        <div class="divider"></div>
        <p class="text-center text-sm text-muted">
            Don't have an account? <a href="<%= request.getContextPath() %>/register">Create one</a>
        </p>
    </div>
</body>
</html>
