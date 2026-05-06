package com.pms.servlet;

import com.pms.dao.UserDAO;
import com.pms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            User user = new UserDAO().login(req.getParameter("email"), req.getParameter("password"));
            if (user != null) {
                req.getSession().setAttribute("user", user);
                res.sendRedirect(req.getContextPath() + "/dashboard");
            } else {
                res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=1");
            }
        } catch (Exception e) {
            log("Login error", e);
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=2");
        }
    }
}
