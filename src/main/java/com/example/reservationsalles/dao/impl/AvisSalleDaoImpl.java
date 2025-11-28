package com.example.reservationsalles.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import com.example.reservationsalles.config.DBConnection;
import com.example.reservationsalles.dao.AvisSalleDao;
import com.example.reservationsalles.model.AvisSalle;

public class AvisSalleDaoImpl implements AvisSalleDao {

    private AvisSalle map(ResultSet rs) throws Exception {
        AvisSalle a = new AvisSalle();
        a.setId(rs.getLong("id"));
        a.setIdSalle(rs.getLong("id_salle"));
        a.setIdUtilisateur(rs.getLong("id_utilisateur"));
        a.setNote(rs.getInt("note"));
        a.setCommentaire(rs.getString("commentaire"));

        Timestamp ts = rs.getTimestamp("date_creation");
        if (ts != null) {
            a.setDateCreation(ts.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
        }

        // Champs optionnels de jointure
        try {
            a.setSalleNom(rs.getString("salle_nom"));
        } catch (Exception ignore) {}
        try {
            a.setUtilisateurLogin(rs.getString("utilisateur_login"));
        } catch (Exception ignore) {}

        return a;
    }

    @Override
    public List<AvisSalle> findBySalle(Long idSalle) throws Exception {
        List<AvisSalle> list = new ArrayList<>();
        String sql = "SELECT a.*, u.login AS utilisateur_login " +
                     "FROM avis_salle a " +
                     "JOIN utilisateur u ON a.id_utilisateur = u.id " +
                     "WHERE a.id_salle = ? " +
                     "ORDER BY a.date_creation DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, idSalle);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    @Override
    public AvisSalle findBySalleAndUtilisateur(Long idSalle, Long idUtilisateur) throws Exception {
        String sql = "SELECT * FROM avis_salle WHERE id_salle = ? AND id_utilisateur = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, idSalle);
            ps.setLong(2, idUtilisateur);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    @Override
    public Double getAverageNoteBySalle(Long idSalle) throws Exception {
        String sql = "SELECT AVG(note) AS avg_note FROM avis_salle WHERE id_salle = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, idSalle);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double avg = rs.getDouble("avg_note");
                    if (rs.wasNull()) {
                        return null;
                    }
                    return avg;
                }
            }
        }
        return null;
    }

    @Override
    public void save(AvisSalle avis) throws Exception {
        if (avis.getId() == null) {
            String sql = "INSERT INTO avis_salle (id_salle, id_utilisateur, note, commentaire) " +
                         "VALUES (?, ?, ?, ?)";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

                ps.setLong(1, avis.getIdSalle());
                ps.setLong(2, avis.getIdUtilisateur());
                ps.setInt(3, avis.getNote());
                ps.setString(4, avis.getCommentaire());
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        avis.setId(rs.getLong(1));
                    }
                }
            }
        } else {
            String sql = "UPDATE avis_salle SET note = ?, commentaire = ? WHERE id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setInt(1, avis.getNote());
                ps.setString(2, avis.getCommentaire());
                ps.setLong(3, avis.getId());
                ps.executeUpdate();
            }
        }
    }

    @Override
    public void delete(Long id) throws Exception {
        String sql = "DELETE FROM avis_salle WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public List<AvisSalle> findAll() throws Exception {
        List<AvisSalle> list = new ArrayList<>();
        String sql = "SELECT a.*, s.nom AS salle_nom, u.login AS utilisateur_login " +
                     "FROM avis_salle a " +
                     "JOIN salle s ON a.id_salle = s.id " +
                     "JOIN utilisateur u ON a.id_utilisateur = u.id " +
                     "ORDER BY a.date_creation DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
}