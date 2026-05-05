package com.pms.servlet;

import com.pms.dao.*;
import jakarta.servlet.http.*;
import java.io.IOException;


public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            req.setAttribute("projects",  new ProjectDAO().getAllProjects());
            req.setAttribute("tasks",     new TaskDAO().getAll());
            req.setAttribute("meetings",  new MeetingDAO().getAll());
            req.setAttribute("allUsers",  new UserDAO().getAllUsers());
            req.getRequestDispatcher("/pages/dashboard.jsp").forward(req, res);
        } catch (Exception e) {
            System.err.println("Dashboard error: " + e.getMessage());
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
