package com.pms.dao;

import com.pms.model.Holiday;
import com.pms.util.DBConnection;
import java.sql.*;
import java.util.*;

public class HolidayDAO {

    public List<Holiday> getAll() throws SQLException {
        List<Holiday> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(
                     "SELECT * FROM holidays ORDER BY holiday_date")) {
            while (rs.next()) {
                Holiday h = new Holiday();
                h.setId(rs.getInt("id"));
                h.setName(rs.getString("name"));
                h.setType(rs.getString("type"));
                h.setHolidayDate(rs.getDate("holiday_date"));
                list.add(h);
            }
        }
        return list;
    }

    public boolean create(Holiday h) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "INSERT INTO holidays(name,holiday_date,type) VALUES(?,?,?)")) {
            ps.setString(1, h.getName());
            ps.setDate(2,   h.getHolidayDate());
            ps.setString(3, h.getType());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "DELETE FROM holidays WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
