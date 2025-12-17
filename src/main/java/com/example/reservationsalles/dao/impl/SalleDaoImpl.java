package com.example.reservationsalles.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.time.LocalDateTime;


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
    @Override
    public List<Salle> findAvailable(LocalDateTime debut, LocalDateTime fin,
                                     Integer capaciteMin, String equipementsContains) throws Exception {
        List<Salle> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM salle s WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (capaciteMin != null) {
            sql.append(" AND s.capacite >= ?");
            params.add(capaciteMin);
        }

        if (equipementsContains != null && !equipementsContains.trim().isEmpty()) {
            sql.append(" AND s.equipements LIKE ?");
            params.add("%" + equipementsContains.trim() + "%");
        }

        // Exclure les salles qui ont déjà une réservation qui chevauche le créneau
        sql.append(" AND s.id NOT IN (");
        sql.append("   SELECT r.id_salle FROM reservation r");
        sql.append("   WHERE r.statut IN ('EN_ATTENTE','VALIDEE')");
        sql.append("     AND r.date_heure_debut < ?"); // fin
        sql.append("     AND r.date_heure_fin   > ?"); // debut
        sql.append(" )");

        params.add(Timestamp.valueOf(fin));
        params.add(Timestamp.valueOf(debut));

        sql.append(" ORDER BY s.nom");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            for (Object p : params) {
                if (p instanceof Integer) {
                    ps.setInt(idx++, (Integer) p);
                } else if (p instanceof String) {
                    ps.setString(idx++, (String) p);
                } else if (p instanceof Timestamp) {
                    ps.setTimestamp(idx++, (Timestamp) p);
                }
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }

        return list;
    }
}