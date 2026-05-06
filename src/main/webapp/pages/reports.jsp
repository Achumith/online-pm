<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.pms.model.*, java.util.*" %>
<% 
    // Defensive data retrieval
    Object projectsObj = request.getAttribute("projects");
    List<Project> projects = null;
    if (projectsObj instanceof List) {
        projects = (List<Project>) projectsObj;
    } else {
        projects = new ArrayList<Project>();
    }

    Object countsObj = request.getAttribute("statusCounts");
    Map<String, Integer> statusCounts = null;
    if (countsObj instanceof Map) {
        statusCounts = (Map<String, Integer>) countsObj;
    } else {
        statusCounts = new HashMap<String, Integer>();
    }

    // Prepare JSON strings for data attributes (using double quotes for JSON compatibility)
    StringBuilder labelsSb = new StringBuilder("[");
    StringBuilder dataSb = new StringBuilder("[");
    if (statusCounts != null && !statusCounts.isEmpty()) {
        boolean first = true;
        for (Map.Entry<String, Integer> entry : statusCounts.entrySet()) {
            if (!first) {
                labelsSb.append(",");
                dataSb.append(",");
            }
            String key = entry.getKey() != null ? entry.getKey().replace("\"", "\\\"") : "Unknown";
            labelsSb.append("\"").append(key).append("\"");
            dataSb.append(entry.getValue());
            first = false;
        }
    }
    labelsSb.append("]");
    dataSb.append("]");
    String labelsJson = labelsSb.toString();
    String dataJson = dataSb.toString();
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
                            <!-- Hidden data element for JavaScript -->
                            <div id="chartData" 
                                 data-labels='<%= labelsJson %>' 
                                 data-values='<%= dataJson %>' 
                                 style="display:none;"></div>
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
                                <div class="stat-value" style="font-size: 1.5rem;">
                                    <%= projects.size() %>
                                </div>
                            </div>
                            <div class="stat-card c-green" style="padding: 12px 16px;">
                                <div class="stat-label">Active Projects</div>
                                <div class="stat-value" style="font-size: 1.5rem;">
                                    <% 
                                        int activeCount = 0; 
                                        for(Project p : projects) {
                                            if(p.getStatus() != null && !"Completed".equalsIgnoreCase(p.getStatus())) {
                                                activeCount++;
                                            }
                                        }
                                    %>
                                    <%= activeCount %>
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
                                    <th>Tasks</th>
                                    <th>Start Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if(!projects.isEmpty()) { 
                                    for(Project p : projects) { 
                                        String status = p.getStatus() != null ? p.getStatus() : "Unknown";
                                        String statusClass = status.toLowerCase().replace(" ", "_");
                                %>
                                    <tr>
                                        <td>
                                            <div class="fw-600"><%= p.getTitle() != null ? p.getTitle() : "Untitled" %></div>
                                            <div class="text-xs text-muted">ID: #<%= p.getId() %></div>
                                        </td>
                                        <td><span class="badge badge-<%= statusClass %>"><%= status %></span></td>
                                        <td><%= p.getTaskCount() %></td>
                                        <td class="text-sm"><%= p.getStartDate() != null ? p.getStartDate().toString() : "N/A" %></td>
                                    </tr>
                                <% 
                                    } 
                                } else { 
                                %>
                                    <tr>
                                        <td colspan="4" class="text-center text-muted">No data available</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const ctx = document.getElementById('statusChart').getContext('2d');
                    const dataEl = document.getElementById('chartData');
                    
                    if (!dataEl) return;

                    let labels = [];
                    let data = [];

                    try {
                        labels = JSON.parse(dataEl.dataset.labels);
                        data = JSON.parse(dataEl.dataset.values);
                    } catch (e) {
                        console.error("Error parsing chart data", e);
                    }

                    if (!labels || labels.length === 0) {
                        ctx.font = "14px DM Sans";
                        ctx.fillStyle = "#8b91a8";
                        ctx.textAlign = "center";
                        ctx.fillText("No status data available", ctx.canvas.width/2, ctx.canvas.height/2);
                        return;
                    }

                    new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: labels,
                            datasets: [{
                                data: data,
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