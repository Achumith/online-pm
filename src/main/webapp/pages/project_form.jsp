<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pms.model.*" %>
<%
    Project p = (Project) request.getAttribute("project");
    boolean isEdit = p != null && p.getId() > 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit Project" : "New Project" %> | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title"><%= isEdit ? "Edit Project" : "New Project" %></div>
                <div class="topbar-actions">
                    <a href="<%= request.getContextPath() %>/projects" class="btn btn-secondary btn-sm">Cancel</a>
                </div>
            </header>

            <div class="page-content">
                <div class="card" style="max-width: 700px; margin: 0 auto;">
                    <div class="card-header">
                        <h3 class="card-title">Project Details</h3>
                    </div>

                    <form action="<%= request.getContextPath() %>/projects" method="POST">
                        <input type="hidden" name="action" value="<%= isEdit ? "update" : "create" %>">
                        <% if(isEdit) { %><input type="hidden" name="id" value="<%= p.getId() %>"><% } %>

                        <div class="form-group">
                            <label class="form-label">Project Title</label>
                            <input type="text" name="title" class="form-control" placeholder="Enter project name" value="<%= isEdit ? p.getTitle() : "" %>" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" placeholder="What is this project about?"><%= isEdit ? p.getDescription() : "" %></textarea>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Start Date</label>
                                <input type="date" name="startDate" class="form-control" value="<%= isEdit ? p.getStartDate() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">End Date</label>
                                <input type="date" name="endDate" class="form-control" value="<%= isEdit ? p.getEndDate() : "" %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Status</label>
                            <select name="status" class="form-control">
                                <option value="Planning" <%= isEdit && "Planning".equals(p.getStatus()) ? "selected":"" %>>Planning</option>
                                <option value="Active" <%= isEdit && "Active".equals(p.getStatus()) ? "selected":"" %>>Active</option>
                                <option value="On Hold" <%= isEdit && "On Hold".equals(p.getStatus()) ? "selected":"" %>>On Hold</option>
                                <option value="Completed" <%= isEdit && "Completed".equals(p.getStatus()) ? "selected":"" %>>Completed</option>
                            </select>
                        </div>

                        <div class="divider"></div>
                        <div class="flex-end" style="display:flex; justify-content: flex-end; gap: 10px;">
                            <a href="<%= request.getContextPath() %>/projects" class="btn btn-secondary">Discard</a>
                            <button type="submit" class="btn btn-primary"><%= isEdit ? "Update Project" : "Create Project" %></button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
