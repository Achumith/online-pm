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
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">All Tasks</h3>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>Task</th>
                                    <th>Project</th>
                                    <th>Status</th>
                                    <th>Priority</th>
                                    <th>Deadline</th>
                                    <th class="text-right">Actions</th>
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
                                        <div class="text-xs text-muted">👤 <%= t.getAssigneeName() %></div>
                                    </td>
                                    <td><div class="text-sm"><%= t.getProjectTitle() %></div></td>
                                    <td><span class="badge badge-<%= t.getStatus() != null ? t.getStatus().toLowerCase().replace(" ", "_") : "todo" %>"><%= t.getStatus() %></span></td>
                                    <td><span class="badge badge-<%= t.getPriority() != null ? t.getPriority().toLowerCase() : "medium" %>"><%= t.getPriority() %></span></td>
                                    <td class="text-sm"><%= t.getEndDate() %></td>
                                    <td class="text-right">
                                        <div class="flex gap-2" style="justify-content: flex-end;">
                                            <a href="<%= request.getContextPath() %>/tasks?action=edit&id=<%= t.getId() %>" class="btn btn-secondary btn-xs">Edit</a>
                                            <form action="<%= request.getContextPath() %>/tasks" method="POST" onsubmit="return confirm('Delete this task?')" style="display:inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="<%= t.getId() %>">
                                                <button type="submit" class="btn btn-outline btn-xs" style="color:var(--danger); border-color:var(--danger)">Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <% 
                                    }
                                } else { 
                                %>
                                <tr><td colspan="6" class="text-center text-muted py-5">No tasks found. Create one to get started!</td></tr>
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
