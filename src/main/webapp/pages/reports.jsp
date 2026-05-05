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
    <title>Reports | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title">Reports</div>
                <div class="topbar-actions">
                    <button class="btn btn-secondary btn-sm" onclick="window.print()">⎙ Export PDF</button>
                </div>
            </header>

            <div class="page-content">
                <div class="page-header">
                    <div>
                        <h1>Project Summary Report</h1>
                        <p>Detailed overview of all active and completed projects.</p>
                    </div>
                </div>

                <div class="grid-2" style="display: grid; grid-template-columns: 1fr 350px; gap: 20px; margin-bottom: 24px;">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Project Status Distribution</h3>
                        </div>
                        <div style="height: 250px; display: flex; align-items: center; justify-content: center;">
                            <canvas id="statusChart"></canvas>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Summary Metrics</h3>
                        </div>
                        <div class="stat-grid" style="grid-template-columns: 1fr; gap: 12px;">
                            <div class="stat-card c-blue" style="padding: 12px 16px;">
                                <div class="stat-label">Total Projects</div>
                                <div class="stat-value" style="font-size: 1.5rem;"><%= projects != null ? projects.size() : 0 %></div>
                            </div>
                            <div class="stat-card c-green" style="padding: 12px 16px;">
                                <div class="stat-label">Active Projects</div>
                                <div class="stat-value" style="font-size: 1.5rem;">
                                    <% 
                                    long active = 0;
                                    if(projects != null) active = projects.stream().filter(p -> !"Completed".equals(p.getStatus())).count();
                                    %>
                                    <%= active %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Detailed Project List</h3>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>Project</th>
                                    <th>Status</th>
                                    <th>Progress</th>
                                    <th>Tasks</th>
                                    <th>Created At</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if(projects != null && !projects.isEmpty()) {
                                    for(Project p : projects) { 
                                %>
                                <tr>
                                    <td>
                                        <div class="fw-600"><%= p.getTitle() %></div>
                                        <div class="text-xs text-muted">ID: #<%= p.getId() %></div>
                                    </td>
                                    <td><span class="badge badge-<%= p.getStatus().toLowerCase().replace(" ", "_") %>"><%= p.getStatus() %></span></td>
                                    <td>
                                        <div class="flex items-center gap-3">
                                            <div class="progress" style="width: 80px;"><div class="progress-bar" style="width: 65%"></div></div>
                                            <span class="text-sm">65%</span>
                                        </div>
                                    </td>
                                    <td><%= p.getTaskCount() %></td>
                                    <td class="text-sm"><%= p.getStartDate() %></td>
                                </tr>
                                <% 
                                    }
                                } else { %>
                                <tr><td colspan="5" class="text-center text-muted">No data available</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    const ctx = document.getElementById('statusChart').getContext('2d');
                    <%
                    Map<String, Integer> counts = (Map<String, Integer>) request.getAttribute("statusCounts");
                    StringBuilder labels = new StringBuilder("[");
                    StringBuilder data = new StringBuilder("[");
                    if (counts != null) {
                        for (Map.Entry<String, Integer> entry : counts.entrySet()) {
                            labels.append("'").append(entry.getKey()).append("',");
                            data.append(entry.getValue()).append(",");
                        }
                    }
                    if (labels.length() > 1) {
                        labels.setLength(labels.length() - 1);
                        data.setLength(data.length() - 1);
                    }
                    labels.append("]");
                    data.append("]");
                    %>
                    
                    new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: <%= labels.toString() %>,
                            datasets: [{
                                data: <%= data.toString() %>,
                                backgroundColor: ['#4f7cff', '#2dd4bf', '#fbbf24', '#f87171', '#e879f9', '#fb923c'],
                                borderWidth: 0,
                                hoverOffset: 10
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'right',
                                    labels: {
                                        color: '#8b91a8',
                                        font: { size: 11, family: "'DM Sans', sans-serif" },
                                        padding: 20,
                                        usePointStyle: true
                                    }
                                }
                            },
                            cutout: '70%'
                        }
                    });
                });
            </script>
        </main>
    </div>
</body>
</html>
