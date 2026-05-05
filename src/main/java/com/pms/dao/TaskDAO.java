package com.pms.dao;

import com.pms.model.Task;
import com.pms.util.DBConnection;
import java.sql.*;
import java.util.*;

public class TaskDAO {

    private static final String BASE =
        "SELECT t.*, u.name AS assignee_name, p.title AS project_title "
      + "FROM tasks t "
      + "LEFT JOIN users u ON t.assigned_to=u.id "
      + "LEFT JOIN projects p ON t.project_id=p.id ";

    public List<Task> getAll() throws SQLException {
        List<Task> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(BASE + "ORDER BY t.created_at DESC")) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<Task> getByProject(int projectId) throws SQLException {
        List<Task> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     BASE + "WHERE t.project_id=? ORDER BY t.created_at DESC")) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Task getById(int id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(BASE + "WHERE t.id=?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        }
        return null;
    }

    public int create(Task t) throws SQLException {
        String sql = "INSERT INTO tasks(project_id,title,description,assigned_to,"
                   + "start_date,end_date,status,priority) VALUES(?,?,?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1,    t.getProjectId());
            ps.setString(2, t.getTitle());
            ps.setString(3, t.getDescription());
            ps.setInt(4,    t.getAssignedTo());
            ps.setDate(5,   t.getStartDate());
            ps.setDate(6,   t.getEndDate());
            ps.setString(7, t.getStatus()   != null ? t.getStatus()   : "todo");
            ps.setString(8, t.getPriority() != null ? t.getPriority() : "medium");
            ps.executeUpdate();
            ResultSet k = ps.getGeneratedKeys();
            return k.next() ? k.getInt(1) : -1;
        }
    }

    public boolean update(Task t) throws SQLException {
        String sql = "UPDATE tasks SET title=?,description=?,assigned_to=?,"
                   + "start_date=?,end_date=?,status=?,priority=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, t.getTitle());
            ps.setString(2, t.getDescription());
            ps.setInt(3,    t.getAssignedTo());
            ps.setDate(4,   t.getStartDate());
            ps.setDate(5,   t.getEndDate());
            ps.setString(6, t.getStatus());
            ps.setString(7, t.getPriority());
            ps.setInt(8,    t.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM tasks WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public int countByStatus(String status) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "SELECT COUNT(*) FROM tasks WHERE status=?")) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private Task map(ResultSet rs) throws SQLException {
        Task t = new Task();
        t.setId(rs.getInt("id"));
        t.setProjectId(rs.getInt("project_id"));
        t.setTitle(rs.getString("title"));
        t.setDescription(rs.getString("description"));
        t.setAssignedTo(rs.getInt("assigned_to"));
        t.setStatus(rs.getString("status"));
        t.setPriority(rs.getString("priority"));
        t.setStartDate(rs.getDate("start_date"));
        t.setEndDate(rs.getDate("end_date"));
        t.setCreatedAt(rs.getTimestamp("created_at"));
        try { t.setAssigneeName(rs.getString("assignee_name")); }  catch (Exception ignored) {}
        try { t.setProjectTitle(rs.getString("project_title")); }  catch (Exception ignored) {}
        return t;
    }
}
