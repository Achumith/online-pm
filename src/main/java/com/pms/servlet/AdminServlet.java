package com.pms.servlet;

import com.pms.dao.ProjectDAO;
import com.pms.dao.UserDAO;
import com.pms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class AdminServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            if (user == null || !"admin".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/dashboard");
                return;
            }
            
            req.setAttribute("users",          new UserDAO().getAllUsers());
            req.setAttribute("totalProjects",   new ProjectDAO().countAll());
            req.setAttribute("activeProjects",  new ProjectDAO().countByStatus("active"));
            req.setAttribute("section", req.getParameter("section") != null ? req.getParameter("section") : "overview");
            
            req.getRequestDispatcher("/pages/admin.jsp").forward(req, res);
        } catch (Exception e) {
            log("Admin error in doGet", e);
            res.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            if (user == null || !"admin".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/dashboard");
                return;
            }
            
            String action = req.getParameter("action");
            if ("deleteUser".equals(action)) {
                new UserDAO().deleteUser(Integer.parseInt(req.getParameter("id")));
            }
            
            res.sendRedirect(req.getContextPath() + "/admin");
        } catch (Exception e) {
            log("Admin error in doPost", e);
            res.sendRedirect(req.getContextPath() + "/admin");
        }
    }
}
