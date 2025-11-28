package com.example.reservationsalles.dao;

import java.time.LocalDateTime;
import java.util.List;

import com.example.reservationsalles.model.Reservation;

public interface ReservationDao {

    Reservation findById(Long id) throws Exception;

    List<Reservation> findByUtilisateur(Long idUtilisateur) throws Exception;

    List<Reservation> findAll() throws Exception; // pour l'admin plus tard

    void create(Reservation reservation) throws Exception;

    void updateStatus(Long id, String statut, String commentaire) throws Exception;

    boolean existsConflictForSalle(Long idSalle, LocalDateTime debut, LocalDateTime fin, Long excludeId) throws Exception;

    boolean existsConflictForUtilisateur(Long idUtilisateur, LocalDateTime debut, LocalDateTime fin, Long excludeId) throws Exception;
    
    List<Reservation> findBySalle(Long idSalle) throws Exception;
}