package com.pms.servlet;

import com.pms.dao.ProjectDAO;
import com.pms.dao.TaskDAO;
import com.pms.model.Project;
import com.pms.model.Task;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReportServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            ProjectDAO projectDAO = new ProjectDAO();
            TaskDAO taskDAO = new TaskDAO();
            
            List<Project> allProjects = projectDAO.getAllProjects();
            req.setAttribute("projects", allProjects);
            
            // Calculate status distribution for the chart
            Map<String, Integer> statusCounts = new HashMap<>();
            if (allProjects != null) {
                for (Project p : allProjects) {
                    String status = p.getStatus() != null ? p.getStatus() : "Unknown";
                    statusCounts.put(status, statusCounts.getOrDefault(status, 0) + 1);
                }
            }
            req.setAttribute("statusCounts", statusCounts);
            
            String pid = req.getParameter("projectId");
            if (pid != null && !pid.isEmpty()) {
                int projectId = Integer.parseInt(pid);
                List<Task> tasks = taskDAO.getByProject(projectId);
                
                long total = tasks.size();
                long done  = tasks.stream().filter(t -> "done".equalsIgnoreCase(t.getStatus()) || "completed".equalsIgnoreCase(t.getStatus())).count();
                long inProg = tasks.stream().filter(t -> "in_progress".equalsIgnoreCase(t.getStatus())).count();
                long todo   = tasks.stream().filter(t -> "todo".equalsIgnoreCase(t.getStatus())).count();
                
                req.setAttribute("selectedProject", projectDAO.getById(projectId));
                req.setAttribute("tasks",           tasks);
                req.setAttribute("totalTasks",      total);
                req.setAttribute("doneTasks",       done);
                req.setAttribute("inProgressTasks", inProg);
                req.setAttribute("todoTasks",       todo);
                req.setAttribute("percent",         total > 0 ? (int)(done * 100 / total) : 0);
            }
            
            req.getRequestDispatcher("/pages/reports.jsp").forward(req, res);
        } catch (Exception e) {
            log("Report error", e);
            res.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }
}
