package com.pms.dao;

import com.pms.model.Project;
import com.pms.util.DBConnection;
import java.sql.*;
import java.util.*;

public class ProjectDAO {

    public List<Project> getAllProjects() throws SQLException {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT p.*, u.name AS creator_name, "
                   + "(SELECT COUNT(*) FROM tasks t WHERE t.project_id=p.id) AS task_count "
                   + "FROM projects p LEFT JOIN users u ON p.created_by=u.id "
                   + "ORDER BY p.created_at DESC";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Project getById(int id) throws SQLException {
        String sql = "SELECT p.*, u.name AS creator_name, "
                   + "(SELECT COUNT(*) FROM tasks t WHERE t.project_id=p.id) AS task_count "
                   + "FROM projects p LEFT JOIN users u ON p.created_by=u.id WHERE p.id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        }
        return null;
    }

    public int create(Project p) throws SQLException {
        String sql = "INSERT INTO projects(title,description,start_date,end_date,status,created_by)"
                   + " VALUES(?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getDescription());
            ps.setDate(3,   p.getStartDate());
            ps.setDate(4,   p.getEndDate());
            ps.setString(5, p.getStatus() != null ? p.getStatus() : "planning");
            ps.setInt(6,    p.getCreatedBy());
            ps.executeUpdate();
            ResultSet k = ps.getGeneratedKeys();
            return k.next() ? k.getInt(1) : -1;
        }
    }

    public boolean update(Project p) throws SQLException {
        String sql = "UPDATE projects SET title=?,description=?,start_date=?,end_date=?,status=?"
                   + " WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getDescription());
            ps.setDate(3,   p.getStartDate());
            ps.setDate(4,   p.getEndDate());
            ps.setString(5, p.getStatus());
            ps.setInt(6,    p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM projects WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public int countAll() throws SQLException {
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM projects")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int countByStatus(String status) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "SELECT COUNT(*) FROM projects WHERE status=?")) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private Project map(ResultSet rs) throws SQLException {
        Project p = new Project();
        p.setId(rs.getInt("id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        p.setStatus(rs.getString("status"));
        p.setStartDate(rs.getDate("start_date"));
        p.setEndDate(rs.getDate("end_date"));
        p.setCreatedBy(rs.getInt("created_by"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        try { p.setCreatorName(rs.getString("creator_name")); } catch (Exception ignored) {}
        try { p.setTaskCount(rs.getInt("task_count")); }         catch (Exception ignored) {}
        return p;
    }
}
