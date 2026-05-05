package com.pms.servlet;

import com.pms.dao.UserDAO;
import com.pms.model.User;
import jakarta.servlet.http.*;
import java.io.IOException;


public class LoginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            User user = new UserDAO().login(req.getParameter("email"), req.getParameter("password"));
            if (user != null) {
                req.getSession().setAttribute("user", user);
                res.sendRedirect(req.getContextPath() + "/dashboard");
            } else {
                res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=1");
            }
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=2");
        }
    }
}
