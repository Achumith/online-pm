package com.pms.filter;

import com.pms.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;
        String uri = request.getRequestURI();

        boolean isPublic = uri.endsWith("/login")
                        || uri.endsWith("/register")
                        || uri.contains("login.jsp")
                        || uri.contains("register.jsp")
                        || uri.contains("/css/")
                        || uri.contains("/js/");

        if (isPublic) { chain.doFilter(req, res); return; }

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            chain.doFilter(req, res);
        }
    }

    public void init(FilterConfig fc) {}
    public void destroy() {}
}
