package com.example.reservationsalles.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import com.example.reservationsalles.config.DBConnection;
import com.example.reservationsalles.dao.UtilisateurDao;
import com.example.reservationsalles.model.Utilisateur;

public class UtilisateurDaoImpl implements UtilisateurDao {

    private Utilisateur map(ResultSet rs) throws SQLException {
        Utilisateur u = new Utilisateur();
        u.setId(rs.getLong("id"));
        u.setLogin(rs.getString("login"));
        u.setMotDePasse(rs.getString("mot_de_passe"));
        u.setNomComplet(rs.getString("nom_complet"));
        u.setRole(rs.getString("role"));
        u.setActif(rs.getBoolean("actif"));

        if (rs.getTimestamp("date_creation") != null) {
            LocalDateTime ldt = rs.getTimestamp("date_creation")
                    .toInstant()
                    .atZone(ZoneId.systemDefault())
                    .toLocalDateTime();
            u.setDateCreation(ldt);
        }

        return u;
    }

    @Override
    public Utilisateur findById(Long id) throws Exception {
        String sql = "SELECT * FROM utilisateur WHERE id = ?";
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
    public Utilisateur findByLoginAndPassword(String login, String motDePasse) throws Exception {
        String sql = "SELECT * FROM utilisateur WHERE login = ? AND mot_de_passe = ? AND actif = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, login);
            ps.setString(2, motDePasse);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<Utilisateur> findAll() throws Exception {
        List<Utilisateur> list = new ArrayList<>();
        String sql = "SELECT * FROM utilisateur ORDER BY login";
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
    public void save(Utilisateur u) throws Exception {
        if (u.getId() == null) {
            // INSERT
            String sql = "INSERT INTO utilisateur (login, mot_de_passe, nom_complet, role, actif) "
                       + "VALUES (?, ?, ?, ?, ?)";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, u.getLogin());
                ps.setString(2, u.getMotDePasse());
                ps.setString(3, u.getNomComplet());
                ps.setString(4, u.getRole());
                ps.setBoolean(5, u.isActif());

                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        u.setId(rs.getLong(1));
                    }
                }
            }
        } else {
            // UPDATE
            String sql = "UPDATE utilisateur SET login = ?, mot_de_passe = ?, nom_complet = ?, role = ?, actif = ? "
                       + "WHERE id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, u.getLogin());
                ps.setString(2, u.getMotDePasse());
                ps.setString(3, u.getNomComplet());
                ps.setString(4, u.getRole());
                ps.setBoolean(5, u.isActif());
                ps.setLong(6, u.getId());

                ps.executeUpdate();
            }
        }
    }

    @Override
    public void delete(Long id) throws Exception {
        String sql = "DELETE FROM utilisateur WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }
}