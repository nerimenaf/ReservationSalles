package com.example.reservationsalles.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.example.reservationsalles.config.DBConnection;
import com.example.reservationsalles.dao.StatsDao;
import com.example.reservationsalles.model.SalleStats;

public class StatsDaoImpl implements StatsDao {

    @Override
    public long countTotalReservations() throws Exception {
        String sql = "SELECT COUNT(*) FROM reservation";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getLong(1);
            }
        }
        return 0L;
    }

    @Override
    public Map<String, Long> countReservationsByStatus() throws Exception {
        Map<String, Long> map = new LinkedHashMap<>();

        // Initialiser à 0 pour chaque statut attendu
        map.put("EN_ATTENTE", 0L);
        map.put("VALIDEE", 0L);
        map.put("REFUSEE", 0L);
        map.put("ANNULEE", 0L);

        String sql = "SELECT statut, COUNT(*) AS nb FROM reservation GROUP BY statut";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String statut = rs.getString("statut");
                long nb = rs.getLong("nb");
                map.put(statut, nb);
            }
        }
        return map;
    }

    @Override
    public List<SalleStats> topSalles(int limit) throws Exception {
        List<SalleStats> list = new ArrayList<>();

        String sql = "SELECT s.nom AS nom_salle, COUNT(*) AS nb " +
                     "FROM reservation r " +
                     "JOIN salle s ON r.id_salle = s.id " +
                     "WHERE r.statut IN ('EN_ATTENTE', 'VALIDEE') " +
                     "GROUP BY s.id, s.nom " +
                     "ORDER BY nb DESC " +
                     "LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String nom = rs.getString("nom_salle");
                    long nb = rs.getLong("nb");
                    list.add(new SalleStats(nom, nb));
                }
            }
        }
        return list;
    }
}