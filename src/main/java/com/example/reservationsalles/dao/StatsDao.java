package com.example.reservationsalles.dao;

import java.util.List;
import java.util.Map;

import com.example.reservationsalles.model.SalleStats;

public interface StatsDao {

    long countTotalReservations() throws Exception;

    Map<String, Long> countReservationsByStatus() throws Exception;

    List<SalleStats> topSalles(int limit) throws Exception;
}