package com.pms.servlet;

import com.pms.dao.MeetingDAO;
import com.pms.dao.ProjectDAO;
import com.pms.dao.TaskDAO;
import com.pms.dao.UserDAO;
import com.pms.model.Project;
import com.pms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

public class ProjectServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            String action = req.getParameter("action");
            ProjectDAO dao = new ProjectDAO();
            
            if ("view".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("project",  dao.getById(id));
                req.setAttribute("tasks",    new TaskDAO().getByProject(id));
                req.setAttribute("meetings", new MeetingDAO().getByProject(id));
                req.setAttribute("users",    new UserDAO().getAllUsers());
                req.getRequestDispatcher("/pages/project_detail.jsp").forward(req, res);
            } else if ("new".equals(action)) {
                req.setAttribute("users", new UserDAO().getAllUsers());
                req.getRequestDispatcher("/pages/project_form.jsp").forward(req, res);
            } else if ("edit".equals(action)) {
                req.setAttribute("project", dao.getById(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("/pages/project_form.jsp").forward(req, res);
            } else {
                req.setAttribute("projects", dao.getAllProjects());
                req.getRequestDispatcher("/pages/projects.jsp").forward(req, res);
            }
        } catch (Exception e) {
            log("Project error in doGet", e);
            res.sendRedirect(req.getContextPath() + "/projects");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            String action = req.getParameter("action");
            ProjectDAO dao = new ProjectDAO();
            
            if ("delete".equals(action)) {
                dao.delete(Integer.parseInt(req.getParameter("id")));
            } else {
                Project p = new Project();
                String idStr = req.getParameter("id");
                p.setTitle(req.getParameter("title"));
                p.setDescription(req.getParameter("description"));
                p.setStatus(req.getParameter("status"));
                p.setCreatedBy(user.getId());
                
                String sd = req.getParameter("startDate");
                String ed = req.getParameter("endDate");
                if (sd != null && !sd.isEmpty()) p.setStartDate(Date.valueOf(sd));
                if (ed != null && !ed.isEmpty()) p.setEndDate(Date.valueOf(ed));
                
                if (idStr != null && !idStr.isEmpty()) {
                    p.setId(Integer.parseInt(idStr));
                    dao.update(p);
                } else {
                    dao.create(p);
                }
            }
            res.sendRedirect(req.getContextPath() + "/projects");
        } catch (Exception e) {
            log("Project error in doPost", e);
            res.sendRedirect(req.getContextPath() + "/projects");
        }
    }
}
