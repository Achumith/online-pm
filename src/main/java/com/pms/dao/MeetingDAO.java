package com.pms.dao;

import com.pms.model.Meeting;
import com.pms.util.DBConnection;
import java.sql.*;
import java.util.*;

public class MeetingDAO {

    private static final String BASE =
        "SELECT m.*, p.title AS project_title, u.name AS creator_name "
      + "FROM meetings m "
      + "LEFT JOIN projects p ON m.project_id=p.id "
      + "LEFT JOIN users u ON m.created_by=u.id ";

    public List<Meeting> getAll() throws SQLException {
        List<Meeting> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(BASE + "ORDER BY m.meeting_date DESC")) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<Meeting> getByProject(int pid) throws SQLException {
        List<Meeting> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     BASE + "WHERE m.project_id=? ORDER BY m.meeting_date DESC")) {
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public boolean create(Meeting m) throws SQLException {
        String sql = "INSERT INTO meetings(project_id,title,description,location,meeting_date,created_by)"
                   + " VALUES(?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1,       m.getProjectId());
            ps.setString(2,    m.getTitle());
            ps.setString(3,    m.getDescription());
            ps.setString(4,    m.getLocation());
            ps.setTimestamp(5, m.getMeetingDate());
            ps.setInt(6,       m.getCreatedBy());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM meetings WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Meeting map(ResultSet rs) throws SQLException {
        Meeting m = new Meeting();
        m.setId(rs.getInt("id"));
        m.setProjectId(rs.getInt("project_id"));
        m.setTitle(rs.getString("title"));
        m.setDescription(rs.getString("description"));
        m.setLocation(rs.getString("location"));
        m.setMeetingDate(rs.getTimestamp("meeting_date"));
        m.setCreatedBy(rs.getInt("created_by"));
        try { m.setProjectTitle(rs.getString("project_title")); } catch (Exception ignored) {}
        try { m.setCreatorName(rs.getString("creator_name")); }   catch (Exception ignored) {}
        return m;
    }
}
