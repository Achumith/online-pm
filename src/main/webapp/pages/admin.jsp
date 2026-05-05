<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pms.model.*, java.util.*" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title">Admin Panel</div>
                <div class="topbar-actions">
                    <button class="btn btn-secondary btn-sm">System Logs</button>
                    <button class="btn btn-primary btn-sm">+ Add User</button>
                </div>
            </header>

            <div class="page-content">
                <div class="page-header">
                    <div>
                        <h1>User Management</h1>
                        <p>Manage system users, roles, and permissions.</p>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">All Users</h3>
                        <div class="flex gap-2">
                            <input type="text" class="form-control" placeholder="Search users..." style="width: 200px; padding: 4px 10px; font-size: 0.8rem;">
                        </div>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if(users != null) {
                                    for(User u : users) { 
                                %>
                                <tr>
                                    <td>
                                        <div class="flex items-center gap-3">
                                            <div class="avatar"><%= u.getAvatar() %></div>
                                            <div class="fw-600"><%= u.getName() %></div>
                                        </div>
                                    </td>
                                    <td class="text-sm"><%= u.getEmail() %></td>
                                    <td><span class="badge badge-<%= u.getRole().toLowerCase() %>"><%= u.getRole() %></span></td>
                                    <td><span class="badge badge-active">Active</span></td>
                                    <td>
                                        <div class="flex gap-2">
                                            <a href="#" class="btn btn-secondary btn-xs">Edit</a>
                                            <a href="<%= request.getContextPath() %>/admin?action=deleteUser&id=<%= u.getId() %>" class="btn btn-danger btn-xs" onclick="return confirm('Remove user?')">×</a>
                                        </div>
                                    </td>
                                </tr>
                                <% 
                                    }
                                } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
