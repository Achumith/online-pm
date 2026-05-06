package com.pms.servlet;

import com.pms.dao.UserDAO;
import com.pms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        res.sendRedirect(req.getContextPath() + "/pages/register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            UserDAO dao = new UserDAO();
            String email = req.getParameter("email");
            
            if (dao.emailExists(email)) {
                res.sendRedirect(req.getContextPath() + "/pages/register.jsp?error=exists");
                return;
            }
            
            User u = new User();
            u.setName(req.getParameter("name"));
            u.setEmail(email);
            u.setPassword(req.getParameter("password"));
            u.setRole(req.getParameter("role"));
            
            if (dao.register(u)) {
                res.sendRedirect(req.getContextPath() + "/pages/login.jsp?registered=1");
            } else {
                res.sendRedirect(req.getContextPath() + "/pages/register.jsp?error=fail");
            }
        } catch (Exception e) {
            log("Register error", e);
            res.sendRedirect(req.getContextPath() + "/pages/register.jsp?error=fail");
        }
    }
}
