package com.pms.servlet;

import com.pms.dao.*;
import com.pms.model.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;


public class TaskServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            String action = req.getParameter("action");
            if ("new".equals(action) || "edit".equals(action)) {
                if ("edit".equals(action))
                    req.setAttribute("task", new TaskDAO().getById(Integer.parseInt(req.getParameter("id"))));
                req.setAttribute("projects", new ProjectDAO().getAllProjects());
                req.setAttribute("users",    new UserDAO().getAllUsers());
                req.getRequestDispatcher("/pages/task_form.jsp").forward(req, res);
            } else {
                req.setAttribute("tasks", new TaskDAO().getAll());
                req.getRequestDispatcher("/pages/tasks.jsp").forward(req, res);
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/tasks");
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            String action = req.getParameter("action");
            TaskDAO dao = new TaskDAO();
            if ("delete".equals(action)) {
                dao.delete(Integer.parseInt(req.getParameter("id")));
            } else {
                Task t = new Task();
                String idStr = req.getParameter("id");
                t.setProjectId(Integer.parseInt(req.getParameter("projectId")));
                t.setTitle(req.getParameter("title"));
                t.setDescription(req.getParameter("description"));
                t.setAssignedTo(Integer.parseInt(req.getParameter("assignedTo")));
                t.setStatus(req.getParameter("status"));
                t.setPriority(req.getParameter("priority"));
                String sd = req.getParameter("startDate");
                String ed = req.getParameter("endDate");
                if (sd != null && !sd.isEmpty()) t.setStartDate(Date.valueOf(sd));
                if (ed != null && !ed.isEmpty()) t.setEndDate(Date.valueOf(ed));
                if (idStr != null && !idStr.isEmpty()) {
                    t.setId(Integer.parseInt(idStr)); dao.update(t);
                } else {
                    dao.create(t);
                }
            }
            res.sendRedirect(req.getContextPath() + "/tasks");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/tasks");
        }
    }
}
