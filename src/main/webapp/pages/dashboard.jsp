<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pms.model.*, java.util.*" %>
<%
    List<Project> projects = (List<Project>) request.getAttribute("projects");
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    List<User> allUsers = (List<User>) request.getAttribute("allUsers");
    
    long activeProjects = 0;
    long completedTasks = 0;
    
    if (projects != null) {
        activeProjects = projects.stream().filter(p -> !"Completed".equalsIgnoreCase(p.getStatus())).count();
    }
    
    if (tasks != null) {
        completedTasks = tasks.stream().filter(t -> "Completed".equalsIgnoreCase(t.getStatus()) || "Done".equalsIgnoreCase(t.getStatus())).count();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title">Overview</div>
                <div class="topbar-actions">
                    <a href="<%= request.getContextPath() %>/projects?action=new" class="btn btn-primary btn-sm">+ New Project</a>
                </div>
            </header>

            <div class="page-content">
                <div class="page-header">
                    <div>
                        <h1>Dashboard</h1>
                        <p>Welcome back! Here's what's happening with your projects.</p>
                    </div>
                </div>

                <div class="stat-grid">
                    <div class="stat-card c-blue">
                        <div class="stat-label">Active Projects</div>
                        <div class="stat-value"><%= activeProjects %></div>
                        <div class="stat-sub">Across all teams</div>
                    </div>
                    <div class="stat-card c-green">
                        <div class="stat-label">Tasks Completed</div>
                        <div class="stat-value"><%= completedTasks %></div>
                        <div class="stat-sub">Overall progress</div>
                    </div>
                    <div class="stat-card c-yellow">
                        <div class="stat-label">Pending Tasks</div>
                        <div class="stat-value"><%= tasks != null ? tasks.size() - completedTasks : 0 %></div>
                        <div class="stat-sub">Awaiting action</div>
                    </div>
                    <div class="stat-card c-pink">
                        <div class="stat-label">Total Users</div>
                        <div class="stat-value"><%= allUsers != null ? allUsers.size() : 0 %></div>
                        <div class="stat-sub">In the system</div>
                    </div>
                </div>

                <div class="grid-2" style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
                    <!-- Recent Projects -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Recent Projects</h3>
                            <a href="<%= request.getContextPath() %>/projects" class="text-sm">View All</a>
                        </div>
                        <div class="table-wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Project</th>
                                        <th>Status</th>
                                        <th>Tasks</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    if(projects != null && !projects.isEmpty()) {
                                        int count = 0;
                                        for(Project p : projects) {
                                            if(count++ >= 5) break;
                                    %>
                                    <tr>
                                        <td>
                                            <div class="fw-600"><%= p.getTitle() %></div>
                                            <div class="text-muted text-sm"><%= p.getStartDate() %></div>
                                        </td>
                                        <td><span class="badge badge-<%= p.getStatus() != null ? p.getStatus().toLowerCase().replace(" ", "_") : "unknown" %>"><%= p.getStatus() %></span></td>
                                        <td><%= p.getTaskCount() %></td>
                                    </tr>
                                    <% 
                                        }
                                    } else { %>
                                    <tr><td colspan="3" class="text-center text-muted">No projects found</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Upcoming Tasks -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Pending Tasks</h3>
                            <a href="<%= request.getContextPath() %>/tasks" class="text-sm">View All</a>
                        </div>
                        <div class="table-wrap">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Task</th>
                                        <th>Project</th>
                                        <th>Priority</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    if(tasks != null && !tasks.isEmpty()) {
                                        int count = 0;
                                        for(Task t : tasks) {
                                            if("Completed".equalsIgnoreCase(t.getStatus()) || "Done".equalsIgnoreCase(t.getStatus())) continue;
                                            if(count++ >= 5) break;
                                    %>
                                    <tr>
                                        <td>
                                            <div class="fw-600"><%= t.getTitle() %></div>
                                            <div class="text-muted text-sm"><%= t.getAssigneeName() %></div>
                                        </td>
                                        <td><div class="text-sm"><%= t.getProjectTitle() %></div></td>
                                        <td><span class="badge badge-<%= t.getPriority() != null ? t.getPriority().toLowerCase() : "medium" %>"><%= t.getPriority() %></span></td>
                                    </tr>
                                    <% 
                                        }
                                    } else { %>
                                    <tr><td colspan="3" class="text-center text-muted">No pending tasks</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
