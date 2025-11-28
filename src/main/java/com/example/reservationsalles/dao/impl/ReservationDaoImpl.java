package com.example.reservationsalles.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import com.example.reservationsalles.config.DBConnection;
import com.example.reservationsalles.dao.ReservationDao;
import com.example.reservationsalles.model.Reservation;

public class ReservationDaoImpl implements ReservationDao {

    private Reservation mapBasic(ResultSet rs) throws Exception {
        Reservation r = new Reservation();
        r.setId(rs.getLong("id"));
        r.setIdSalle(rs.getLong("id_salle"));
        r.setIdUtilisateur(rs.getLong("id_utilisateur"));

        Timestamp tsDebut = rs.getTimestamp("date_heure_debut");
        Timestamp tsFin = rs.getTimestamp("date_heure_fin");
        Timestamp tsCreation = rs.getTimestamp("date_creation");

        if (tsDebut != null) {
            r.setDateHeureDebut(tsDebut.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
        }
        if (tsFin != null) {
            r.setDateHeureFin(tsFin.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
        }
        if (tsCreation != null) {
            r.setDateCreation(tsCreation.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
        }

        r.setStatut(rs.getString("statut"));
        r.setCommentaire(rs.getString("commentaire"));
        return r;
    }

    @Override
    public Reservation findById(Long id) throws Exception {
        String sql = "SELECT r.*, s.nom AS salle_nom, u.login AS utilisateur_login " +
                     "FROM reservation r " +
                     "JOIN salle s ON r.id_salle = s.id " +
                     "JOIN utilisateur u ON r.id_utilisateur = u.id " +
                     "WHERE r.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Reservation r = mapBasic(rs);
                    r.setSalleNom(rs.getString("salle_nom"));
                    r.setUtilisateurLogin(rs.getString("utilisateur_login"));
                    return r;
                }
            }
        }
        return null;
    }

    @Override
    public List<Reservation> findByUtilisateur(Long idUtilisateur) throws Exception {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT r.*, s.nom AS salle_nom " +
                     "FROM reservation r " +
                     "JOIN salle s ON r.id_salle = s.id " +
                     "WHERE r.id_utilisateur = ? " +
                     "ORDER BY r.date_heure_debut DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, idUtilisateur);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reservation r = mapBasic(rs);
                    r.setSalleNom(rs.getString("salle_nom"));
                    list.add(r);
                }
            }
        }
        return list;
    }

    @Override
    public List<Reservation> findAll() throws Exception {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT r.*, s.nom AS salle_nom, u.login AS utilisateur_login " +
                     "FROM reservation r " +
                     "JOIN salle s ON r.id_salle = s.id " +
                     "JOIN utilisateur u ON r.id_utilisateur = u.id " +
                     "ORDER BY r.date_heure_debut DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reservation r = mapBasic(rs);
                r.setSalleNom(rs.getString("salle_nom"));
                r.setUtilisateurLogin(rs.getString("utilisateur_login"));
                list.add(r);
            }
        }
        return list;
    }

    @Override
    public void create(Reservation r) throws Exception {
        String sql = "INSERT INTO reservation " +
                     "(id_salle, id_utilisateur, date_heure_debut, date_heure_fin, statut, commentaire) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setLong(1, r.getIdSalle());
            ps.setLong(2, r.getIdUtilisateur());
            ps.setTimestamp(3, Timestamp.valueOf(r.getDateHeureDebut()));
            ps.setTimestamp(4, Timestamp.valueOf(r.getDateHeureFin()));
            ps.setString(5, r.getStatut());
            ps.setString(6, r.getCommentaire());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    r.setId(rs.getLong(1));
                }
            }
        }
    }

    @Override
    public void updateStatus(Long id, String statut, String commentaire) throws Exception {
        String sql = "UPDATE reservation SET statut = ?, commentaire = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, statut);
            ps.setString(2, commentaire);
            ps.setLong(3, id);
            ps.executeUpdate();
        }
    }

    @Override
    public boolean existsConflictForSalle(Long idSalle, LocalDateTime debut, LocalDateTime fin, Long excludeId)
            throws Exception {

        String sql = "SELECT COUNT(*) FROM reservation " +
                     "WHERE id_salle = ? " +
                     "AND statut IN ('EN_ATTENTE', 'VALIDEE') " +
                     "AND date_heure_debut < ? " +
                     "AND date_heure_fin > ?";

        if (excludeId != null) {
            sql += " AND id <> ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, idSalle);
            ps.setTimestamp(2, Timestamp.valueOf(fin));
            ps.setTimestamp(3, Timestamp.valueOf(debut));
            if (excludeId != null) {
                ps.setLong(4, excludeId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong(1) > 0;
                }
            }
        }
        return false;
    }

    @Override
    public boolean existsConflictForUtilisateur(Long idUtilisateur, LocalDateTime debut, LocalDateTime fin,
                                                Long excludeId) throws Exception {

        String sql = "SELECT COUNT(*) FROM reservation " +
                     "WHERE id_utilisateur = ? " +
                     "AND statut IN ('EN_ATTENTE', 'VALIDEE') " +
                     "AND date_heure_debut < ? " +
                     "AND date_heure_fin > ?";

        if (excludeId != null) {
            sql += " AND id <> ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, idUtilisateur);
            ps.setTimestamp(2, Timestamp.valueOf(fin));
            ps.setTimestamp(3, Timestamp.valueOf(debut));
            if (excludeId != null) {
                ps.setLong(4, excludeId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong(1) > 0;
                }
            }
        }
        return false;
    }
    @Override
    public List<Reservation> findBySalle(Long idSalle) throws Exception {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT r.*, u.login AS utilisateur_login " +
                     "FROM reservation r " +
                     "JOIN utilisateur u ON r.id_utilisateur = u.id " +
                     "WHERE r.id_salle = ? " +
                     "ORDER BY r.date_heure_debut DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, idSalle);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reservation r = mapBasic(rs);
                    r.setUtilisateurLogin(rs.getString("utilisateur_login"));
                    list.add(r);
                }
            }
        }
        return list;
    }
}