<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pms.model.*, java.util.*" %>
<%
    List<Meeting> meetings = (List<Meeting>) request.getAttribute("meetings");
    List<Holiday> holidays = (List<Holiday>) request.getAttribute("holidays");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar | ProjectManager</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="layout">
        <jsp:include page="navbar.jsp" />
        
        <main class="main">
            <header class="topbar">
                <div class="topbar-title">Calendar</div>
                <div class="topbar-actions">
                    <button class="btn btn-primary btn-sm" onclick="openModal()">+ Add Event</button>
                </div>
            </header>

            <div class="page-content">
                <div class="cal-wrapper">
                    <div class="card">
                        <div class="cal-grid-header">
                            <h3 class="cal-month-title">May 2026</h3>
                            <div class="flex gap-2">
                                <button class="btn btn-secondary btn-xs">‹</button>
                                <button class="btn btn-secondary btn-xs">Today</button>
                                <button class="btn btn-secondary btn-xs">›</button>
                            </div>
                        </div>
                        <div class="cal-days-header">
                            <div class="cal-day-name">Sun</div>
                            <div class="cal-day-name">Mon</div>
                            <div class="cal-day-name">Tue</div>
                            <div class="cal-day-name">Wed</div>
                            <div class="cal-day-name">Thu</div>
                            <div class="cal-day-name">Fri</div>
                            <div class="cal-day-name">Sat</div>
                        </div>
                        <div class="cal-grid">
                            <%-- Simple mock calendar grid --%>
                            <% for(int i=26; i<=30; i++) { %><div class="cal-day other-month"><%= i %></div><% } %>
                            <% for(int i=1; i<=31; i++) { 
                                String classNames = "cal-day";
                                if(i == 5) classNames += " today";
                                if(i == 10) classNames += " holiday";
                                if(i == 12 || i == 15) classNames += " has-meeting";
                            %>
                                <div class="<%= classNames %>">
                                    <%= i %>
                                    <% if(classNames.contains("has-meeting") || classNames.contains("holiday")) { %>
                                        <div class="cal-dot"></div>
                                    <% } %>
                                </div>
                            <% } %>
                            <% for(int i=1; i<=6; i++) { %><div class="cal-day other-month"><%= i %></div><% } %>
                        </div>
                    </div>

                    <div class="card">
                        <h3 class="card-title mb-4">Upcoming Events</h3>
                        <div class="event-list">
                            <% 
                            if(meetings != null && !meetings.isEmpty()) {
                                for(Meeting m : meetings) { 
                            %>
                            <div class="flex gap-3 mb-4">
                                <div class="badge badge-completed" style="height:fit-content;"><%= m.getMeetingDate().toString().substring(11,16) %></div>
                                <div>
                                    <div class="fw-600"><%= m.getTitle() %></div>
                                    <div class="text-sm text-muted">Project: <%= m.getProjectTitle() %></div>
                                    <div class="text-sm text-muted">📍 <%= m.getLocation() %></div>
                                </div>
                            </div>
                            <% 
                                }
                            } else { %>
                                <div class="empty-state">
                                    <div class="icon">▦</div>
                                    <p>No upcoming meetings</p>
                                </div>
                            <% } %>

                            <div class="divider"></div>
                            <h4 class="text-sm fw-700 text-muted mb-3">Holidays</h4>
                            <% if(holidays != null) for(Holiday h : holidays) { %>
                                <div class="flex items-center gap-3 mb-2">
                                    <span class="badge badge-high" style="width: 8px; height: 8px; padding: 0; border-radius: 50%;"></span>
                                    <span class="text-sm"><%= h.getName() %> — <%= h.getHolidayDate() %></span>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <div class="modal-overlay" id="eventModal">
        <div class="modal-card">
            <div class="modal-header">
                <h3 class="card-title">Add New Event</h3>
                <button class="btn btn-secondary btn-xs" onclick="closeModal()">×</button>
            </div>
            <form action="<%= request.getContextPath() %>/calendar" method="POST">
                <div class="form-group">
                    <label class="form-label">Event Title</label>
                    <input type="text" name="title" class="form-control" placeholder="e.g. Weekly Sync" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Project</label>
                    <select name="projectId" class="form-control">
                        <option value="">No Project (General)</option>
                        <% 
                        List<Project> projs = (List<Project>) request.getAttribute("projects");
                        if(projs != null) for(Project p : projs) { 
                        %>
                        <option value="<%= p.getId() %>"><%= p.getTitle() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Date & Time</label>
                    <input type="datetime-local" name="meetingDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Location</label>
                    <input type="text" name="location" class="form-control" placeholder="e.g. Zoom, Conference Room B">
                </div>
                <div class="form-group">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control"></textarea>
                </div>
                <div style="display:flex; gap:10px; margin-top:20px;">
                    <button type="submit" class="btn btn-primary w-100">Create Event</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal() { document.getElementById('eventModal').classList.add('active'); }
        function closeModal() { document.getElementById('eventModal').classList.remove('active'); }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            if (event.target == document.getElementById('eventModal')) closeModal();
        }
    </script>
</body>
</html>
