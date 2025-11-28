package com.example.reservationsalles.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.reservationsalles.config.DBConnection;
import com.example.reservationsalles.dao.SalleDao;
import com.example.reservationsalles.model.Salle;

public class SalleDaoImpl implements SalleDao {

    private Salle map(ResultSet rs) throws SQLException {
        Salle s = new Salle();
        s.setId(rs.getLong("id"));
        s.setNom(rs.getString("nom"));
        s.setCapacite(rs.getInt("capacite"));
        s.setLocalisation(rs.getString("localisation"));
        s.setEquipements(rs.getString("equipements"));
        return s;
    }

    @Override
    public Salle findById(Long id) throws Exception {
        String sql = "SELECT * FROM salle WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<Salle> findAll() throws Exception {
        List<Salle> list = new ArrayList<>();
        String sql = "SELECT * FROM salle ORDER BY nom";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    @Override
    public void save(Salle s) throws Exception {
        if (s.getId() == null) {
            // INSERT
            String sql = "INSERT INTO salle (nom, capacite, localisation, equipements) "
                       + "VALUES (?, ?, ?, ?)";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, s.getNom());
                ps.setInt(2, s.getCapacite());
                ps.setString(3, s.getLocalisation());
                ps.setString(4, s.getEquipements());

                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        s.setId(rs.getLong(1));
                    }
                }
            }
        } else {
            // UPDATE
            String sql = "UPDATE salle SET nom = ?, capacite = ?, localisation = ?, equipements = ? "
                       + "WHERE id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, s.getNom());
                ps.setInt(2, s.getCapacite());
                ps.setString(3, s.getLocalisation());
                ps.setString(4, s.getEquipements());
                ps.setLong(5, s.getId());

                ps.executeUpdate();
            }
        }
    }

    @Override
    public void delete(Long id) throws Exception {
        String sql = "DELETE FROM salle WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }
}