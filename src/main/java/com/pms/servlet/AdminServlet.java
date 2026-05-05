package com.pms.servlet;

import com.pms.dao.*;
import com.pms.model.*;
import jakarta.servlet.http.*;
import java.io.IOException;


public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            if (!"admin".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/dashboard"); return;
            }
            req.setAttribute("users",          new UserDAO().getAllUsers());
            req.setAttribute("totalProjects",   new ProjectDAO().countAll());
            req.setAttribute("activeProjects",  new ProjectDAO().countByStatus("active"));
            req.setAttribute("section", req.getParameter("section") != null
                                       ? req.getParameter("section") : "overview");
            req.getRequestDispatcher("/pages/admin.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            if (!"admin".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/dashboard"); return;
            }
            String action = req.getParameter("action");
            if ("deleteUser".equals(action))
                new UserDAO().deleteUser(Integer.parseInt(req.getParameter("id")));
            res.sendRedirect(req.getContextPath() + "/admin");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/admin");
        }
    }
}
