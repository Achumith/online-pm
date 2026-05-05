<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pms.model.*, java.util.*" %>
<%
    Project p = (Project) request.getAttribute("project");
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= p.getTitle() %> | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title">Project Detail</div>
                <div class="topbar-actions">
                    <a href="<%= request.getContextPath() %>/projects?action=edit&id=<%= p.getId() %>" class="btn btn-secondary btn-sm">Edit</a>
                    <a href="<%= request.getContextPath() %>/tasks?action=new&projectId=<%= p.getId() %>" class="btn btn-primary btn-sm">+ Add Task</a>
                </div>
            </header>

            <div class="page-content">
                <div class="detail-grid">
                    <div>
                        <div class="detail-header">
                            <div class="flex-between items-center mb-2">
                                <span class="badge badge-<%= p.getStatus().toLowerCase().replace(" ", "_") %>"><%= p.getStatus() %></span>
                                <span class="text-sm text-muted">Created on <%= p.getCreatedAt() %></span>
                            </div>
                            <h1><%= p.getTitle() %></h1>
                            <p class="mt-2" style="font-size: 1.1rem; color: var(--text2);"><%= p.getDescription() %></p>
                        </div>

                        <div class="card mb-4">
                            <div class="card-header">
                                <h3 class="card-title">Project Tasks (<%= tasks != null ? tasks.size() : 0 %>)</h3>
                            </div>
                            <div class="table-wrap">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Task Name</th>
                                            <th>Assignee</th>
                                            <th>Priority</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                        if(tasks != null && !tasks.isEmpty()) {
                                            for(Task t : tasks) { 
                                        %>
                                        <tr>
                                            <td>
                                                <a href="<%= request.getContextPath() %>/tasks?action=view&id=<%= t.getId() %>" class="fw-600"><%= t.getTitle() %></a>
                                            </td>
                                            <td><%= t.getAssigneeName() %></td>
                                            <td><span class="badge badge-<%= t.getPriority().toLowerCase() %>"><%= t.getPriority() %></span></td>
                                            <td><span class="badge badge-<%= t.getStatus().toLowerCase().replace(" ", "_") %>"><%= t.getStatus() %></span></td>
                                        </tr>
                                        <% 
                                            }
                                        } else { %>
                                        <tr><td colspan="4" class="text-center text-muted">No tasks assigned to this project.</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <aside>
                        <div class="card mb-4">
                            <h3 class="card-title mb-3">Project Overview</h3>
                            <div class="mb-3">
                                <div class="text-sm text-muted mb-1">Owner</div>
                                <div class="flex items-center gap-2">
                                    <div class="avatar sm"><%= p.getCreatorName().substring(0,1) %></div>
                                    <div class="fw-600"><%= p.getCreatorName() %></div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <div class="text-sm text-muted mb-1">Timeline</div>
                                <div class="fw-600"><%= p.getStartDate() %> — <%= p.getEndDate() %></div>
                            </div>
                            <div class="mb-3">
                                <div class="text-sm text-muted mb-1">Progress</div>
                                <div class="flex-between text-sm mb-1">
                                    <span>Completion</span>
                                    <span>65%</span>
                                </div>
                                <div class="progress"><div class="progress-bar" style="width: 65%"></div></div>
                            </div>
                        </div>

                        <div class="card">
                            <h3 class="card-title mb-3">Quick Actions</h3>
                            <div class="flex flex-column gap-2" style="display: flex; flex-direction: column;">
                                <a href="<%= request.getContextPath() %>/reports?projectId=<%= p.getId() %>" class="btn btn-secondary w-100">Generate Report</a>
                                <a href="<%= request.getContextPath() %>/storage?projectId=<%= p.getId() %>" class="btn btn-secondary w-100">Files & Docs</a>
                                <a href="<%= request.getContextPath() %>/projects?action=delete&id=<%= p.getId() %>" class="btn btn-danger w-100" onclick="return confirm('Are you sure?')">Delete Project</a>
                            </div>
                        </div>
                    </aside>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
