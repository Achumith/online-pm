package com.pms.servlet;

import com.pms.dao.*;
import com.pms.model.*;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;


public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            List<Project> allProjects = new ProjectDAO().getAllProjects();
            req.setAttribute("projects", allProjects);
            
            // Calculate status distribution for the chart
            Map<String, Integer> statusCounts = new HashMap<>();
            for (Project p : allProjects) {
                String status = p.getStatus();
                statusCounts.put(status, statusCounts.getOrDefault(status, 0) + 1);
            }
            req.setAttribute("statusCounts", statusCounts);
            String pid = req.getParameter("projectId");
            if (pid != null && !pid.isEmpty()) {
                int projectId = Integer.parseInt(pid);
                List<Task> tasks = new TaskDAO().getByProject(projectId);
                long total = tasks.size();
                long done  = tasks.stream().filter(t -> "done".equals(t.getStatus())).count();
                long inProg = tasks.stream().filter(t -> "in_progress".equals(t.getStatus())).count();
                long todo   = tasks.stream().filter(t -> "todo".equals(t.getStatus())).count();
                req.setAttribute("selectedProject", new ProjectDAO().getById(projectId));
                req.setAttribute("tasks",           tasks);
                req.setAttribute("totalTasks",      total);
                req.setAttribute("doneTasks",       done);
                req.setAttribute("inProgressTasks", inProg);
                req.setAttribute("todoTasks",       todo);
                req.setAttribute("percent",         total > 0 ? (int)(done * 100 / total) : 0);
            }
            req.getRequestDispatcher("/pages/reports.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }
}
