<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pms.model.*, java.util.*" %>
<%
    List<Project> projects = (List<Project>) request.getAttribute("projects");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projects | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title">Projects</div>
                <div class="topbar-actions">
                    <a href="<%= request.getContextPath() %>/projects?action=new" class="btn btn-primary btn-sm">+ Create Project</a>
                </div>
            </header>

            <div class="page-content">
                <div class="page-header">
                    <div>
                        <h1>All Projects</h1>
                        <p>Manage and track your project progress.</p>
                    </div>
                </div>

                <% String msg = (String) request.getSession().getAttribute("msg"); %>
                <% if (msg != null) { %>
                    <div class="alert alert-success"><%= msg %></div>
                    <% request.getSession().removeAttribute("msg"); %>
                <% } %>

                <div class="project-grid">
                    <% 
                    if(projects != null && !projects.isEmpty()) {
                        for(Project p : projects) { 
                    %>
                    <a href="<%= request.getContextPath() %>/projects?action=view&id=<%= p.getId() %>" class="project-card">
                        <div class="project-card-header">
                            <span class="badge badge-<%= p.getStatus().toLowerCase().replace(" ", "_") %>"><%= p.getStatus() %></span>
                            <div class="text-sm text-muted">ID: #<%= p.getId() %></div>
                        </div>
                        <h3 class="project-title"><%= p.getTitle() %></h3>
                        <p class="project-desc"><%= p.getDescription() != null && p.getDescription().length() > 80 ? p.getDescription().substring(0, 77) + "..." : p.getDescription() %></p>
                        
                        <div class="mb-3">
                            <div class="flex-between text-sm mb-1">
                                <span>Progress</span>
                                <span class="fw-600">65%</span>
                            </div>
                            <div class="progress"><div class="progress-bar" style="width: 65%"></div></div>
                        </div>

                        <div class="project-meta">
                            <span>📅 <%= p.getEndDate() %></span>
                            <span>✓ <%= p.getTaskCount() %> Tasks</span>
                            <span>👤 <%= p.getCreatorName() %></span>
                        </div>
                    </a>
                    <% 
                        }
                    } else { %>
                    <div class="empty-state" style="grid-column: 1/-1;">
                        <div class="icon">◈</div>
                        <h3>No projects found</h3>
                        <p>Start by creating your first project.</p>
                        <a href="<%= request.getContextPath() %>/projects?action=new" class="btn btn-primary mt-2">Get Started</a>
                    </div>
                    <% } %>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
