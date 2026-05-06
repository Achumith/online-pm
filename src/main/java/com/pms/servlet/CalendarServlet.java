package com.pms.servlet;

import com.pms.dao.HolidayDAO;
import com.pms.dao.MeetingDAO;
import com.pms.dao.ProjectDAO;
import com.pms.model.Meeting;
import com.pms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;

public class CalendarServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            req.setAttribute("holidays", new HolidayDAO().getAll());
            req.setAttribute("meetings", new MeetingDAO().getAll());
            req.setAttribute("projects", new ProjectDAO().getAllProjects());
            req.getRequestDispatcher("/pages/calendar.jsp").forward(req, res);
        } catch (Exception e) {
            log("Calendar error in doGet", e);
            res.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            Meeting m = new Meeting();
            m.setTitle(req.getParameter("title"));
            m.setDescription(req.getParameter("description"));
            m.setLocation(req.getParameter("location"));
            
            String pid = req.getParameter("projectId");
            if (pid != null && !pid.isEmpty()) {
                m.setProjectId(Integer.parseInt(pid));
            }
            
            String dateStr = req.getParameter("meetingDate"); // format: 2026-05-12T14:30
            if (dateStr != null && !dateStr.isEmpty()) {
                dateStr = dateStr.replace("T", " ") + ":00";
                m.setMeetingDate(Timestamp.valueOf(dateStr));
            }
            
            m.setCreatedBy(user.getId());
            new MeetingDAO().create(m);
            
            res.sendRedirect(req.getContextPath() + "/calendar");
        } catch (Exception e) {
            log("Calendar error in doPost", e);
            res.sendRedirect(req.getContextPath() + "/calendar?error=1");
        }
    }
}
