<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pms.model.User" %>
<%
    User nu = (User) session.getAttribute("user");
    String role = nu != null ? nu.getRole() : "";
    String ctx  = request.getContextPath();
    String uri  = request.getRequestURI();
%>
<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-icon">PM</div>
        <div>
            <div class="logo-text">ProjectManager</div>
            <div class="logo-sub">Enterprise</div>
        </div>
    </div>
    <div class="sidebar-user">
        <div class="avatar"><%= nu != null ? nu.getAvatar() : "??" %></div>
        <div class="user-info">
            <div class="user-name"><%= nu != null ? nu.getName() : "Guest" %></div>
            <div class="user-role"><%= role %></div>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section">Main</div>
        <a href="<%= ctx %>/dashboard" class="nav-link <%= uri.contains("dashboard") ? "active":"" %>"><span class="icon">&#8862;</span> Dashboard</a>
        <a href="<%= ctx %>/projects"  class="nav-link <%= uri.contains("projects") ? "active":"" %>"><span class="icon">&#9672;</span> Projects</a>
        <a href="<%= ctx %>/tasks"     class="nav-link <%= uri.contains("tasks") ? "active":"" %>"><span class="icon">&#10003;</span> Tasks</a>
        
        <div class="nav-section">Tools</div>
        <a href="<%= ctx %>/reports"   class="nav-link <%= uri.contains("reports") ? "active":"" %>"><span class="icon">&#9681;</span> Reports</a>
        <a href="<%= ctx %>/calendar"  class="nav-link <%= uri.contains("calendar") ? "active":"" %>"><span class="icon">&#9638;</span> Calendar</a>
        
        <% if ("admin".equalsIgnoreCase(role)) { %>
            <div class="nav-section">Admin</div>
            <a href="<%= ctx %>/admin" class="nav-link <%= uri.contains("admin") ? "active":"" %>"><span class="icon">&#9881;</span> Admin Panel</a>
        <% } %>
    </nav>
    <div class="sidebar-footer">
        <a href="<%= ctx %>/logout" class="btn btn-secondary w-100" style="justify-content:center">&#9099; Sign Out</a>
    </div>
</aside>