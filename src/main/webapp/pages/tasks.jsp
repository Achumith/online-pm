<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pms.model.*, java.util.*" %>
<%
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tasks | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title">Tasks</div>
                <div class="topbar-actions">
                    <a href="<%= request.getContextPath() %>/tasks?action=new" class="btn btn-primary btn-sm">+ New Task</a>
                </div>
            </header>

            <div class="page-content">
                <div class="page-header">
                    <div>
                        <h1>Tasks</h1>
                        <p>Track your assignments and team responsibilities.</p>
                    </div>
                </div>

                <div class="card">
                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>Task</th>
                                    <th>Project</th>
                                    <th>Assignee</th>
                                    <th>Priority</th>
                                    <th>Status</th>
                                    <th>Due Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if(tasks != null && !tasks.isEmpty()) {
                                    for(Task t : tasks) { 
                                %>
                                <tr>
                                    <td>
                                        <div class="fw-600"><%= t.getTitle() %></div>
                                        <div class="text-sm text-muted">ID: #<%= t.getId() %></div>
                                    </td>
                                    <td><a href="<%= request.getContextPath() %>/projects?action=view&id=<%= t.getProjectId() %>" class="text-sm"><%= t.getProjectTitle() %></a></td>
                                    <td>
                                        <div class="flex items-center gap-2">
                                            <div class="avatar sm"><%= t.getAssigneeName() != null ? t.getAssigneeName().substring(0,1) : "?" %></div>
                                            <span class="text-sm"><%= t.getAssigneeName() %></span>
                                        </div>
                                    </td>
                                    <td><span class="badge badge-<%= t.getPriority().toLowerCase() %>"><%= t.getPriority() %></span></td>
                                    <td><span class="badge badge-<%= t.getStatus().toLowerCase().replace(" ", "_") %>"><%= t.getStatus() %></span></td>
                                    <td class="text-sm"><%= t.getEndDate() %></td>
                                    <td>
                                        <a href="<%= request.getContextPath() %>/tasks?action=edit&id=<%= t.getId() %>" class="btn btn-secondary btn-xs">Edit</a>
                                    </td>
                                </tr>
                                <% 
                                    }
                                } else { %>
                                <tr><td colspan="7" class="text-center text-muted">No tasks found</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
