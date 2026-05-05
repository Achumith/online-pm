<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pms.model.*, java.util.*" %>
<%
    Task t = (Task) request.getAttribute("task");
    List<Project> projects = (List<Project>) request.getAttribute("projects");
    List<User> users = (List<User>) request.getAttribute("users");
    boolean isEdit = t != null && t.getId() > 0;
    int preselectedProjectId = request.getParameter("projectId") != null ? Integer.parseInt(request.getParameter("projectId")) : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit Task" : "New Task" %> | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title"><%= isEdit ? "Edit Task" : "New Task" %></div>
                <div class="topbar-actions">
                    <a href="<%= request.getContextPath() %>/tasks" class="btn btn-secondary btn-sm">Cancel</a>
                </div>
            </header>

            <div class="page-content">
                <div class="card" style="max-width: 700px; margin: 0 auto;">
                    <div class="card-header">
                        <h3 class="card-title">Task Details</h3>
                    </div>

                    <form action="<%= request.getContextPath() %>/tasks" method="POST">
                        <input type="hidden" name="action" value="<%= isEdit ? "update" : "create" %>">
                        <% if(isEdit) { %><input type="hidden" name="id" value="<%= t.getId() %>"><% } %>

                        <div class="form-group">
                            <label class="form-label">Task Title</label>
                            <input type="text" name="title" class="form-control" placeholder="What needs to be done?" value="<%= isEdit ? t.getTitle() : "" %>" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" placeholder="Provide more details about the task"><%= isEdit ? t.getDescription() : "" %></textarea>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Project</label>
                                <select name="projectId" class="form-control" required>
                                    <option value="">Select Project</option>
                                    <% if(projects != null) for(Project p : projects) { %>
                                        <option value="<%= p.getId() %>" <%= (isEdit && t.getProjectId() == p.getId()) || (preselectedProjectId == p.getId()) ? "selected":"" %>><%= p.getTitle() %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Assigned To</label>
                                <select name="assignedTo" class="form-control" required>
                                    <option value="">Select Member</option>
                                    <% if(users != null) for(User u : users) { %>
                                        <option value="<%= u.getId() %>" <%= isEdit && t.getAssignedTo() == u.getId() ? "selected":"" %>><%= u.getName() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Priority</label>
                                <select name="priority" class="form-control">
                                    <option value="Low" <%= isEdit && "Low".equals(t.getPriority()) ? "selected":"" %>>Low</option>
                                    <option value="Medium" <%= isEdit && "Medium".equals(t.getPriority()) ? "selected":"" %>>Medium</option>
                                    <option value="High" <%= isEdit && "High".equals(t.getPriority()) ? "selected":"" %>>High</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Status</label>
                                <select name="status" class="form-control">
                                    <option value="Todo" <%= isEdit && "Todo".equals(t.getStatus()) ? "selected":"" %>>Todo</option>
                                    <option value="In Progress" <%= isEdit && "In Progress".equals(t.getStatus()) ? "selected":"" %>>In Progress</option>
                                    <option value="In Review" <%= isEdit && "In Review".equals(t.getStatus()) ? "selected":"" %>>In Review</option>
                                    <option value="Completed" <%= isEdit && "Completed".equals(t.getStatus()) ? "selected":"" %>>Completed</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Start Date</label>
                                <input type="date" name="startDate" class="form-control" value="<%= isEdit ? t.getStartDate() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">End Date (Due Date)</label>
                                <input type="date" name="endDate" class="form-control" value="<%= isEdit ? t.getEndDate() : "" %>" required>
                            </div>
                        </div>

                        <div class="divider"></div>
                        <div class="flex-end" style="display:flex; justify-content: flex-end; gap: 10px;">
                            <a href="<%= request.getContextPath() %>/tasks" class="btn btn-secondary">Discard</a>
                            <button type="submit" class="btn btn-primary"><%= isEdit ? "Update Task" : "Create Task" %></button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
