package com.pms.servlet;

import com.pms.dao.ProjectDAO;
import com.pms.dao.TaskDAO;
import com.pms.dao.MeetingDAO;
import com.pms.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            req.setAttribute("projects",  new ProjectDAO().getAllProjects());
            req.setAttribute("tasks",     new TaskDAO().getAll());
            req.setAttribute("meetings",  new MeetingDAO().getAll());
            req.setAttribute("allUsers",  new UserDAO().getAllUsers());
            req.getRequestDispatcher("/pages/dashboard.jsp").forward(req, res);
        } catch (Exception e) {
            log("Dashboard error", e);
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
