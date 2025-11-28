package com.example.reservationsalles.dao;

import java.util.List;

import com.example.reservationsalles.model.AvisSalle;

public interface AvisSalleDao {

    List<AvisSalle> findBySalle(Long idSalle) throws Exception;

    AvisSalle findBySalleAndUtilisateur(Long idSalle, Long idUtilisateur) throws Exception;

    Double getAverageNoteBySalle(Long idSalle) throws Exception;

    void save(AvisSalle avis) throws Exception; // insert ou update selon avis.getId()

    void delete(Long id) throws Exception;

    List<AvisSalle> findAll() throws Exception; // pour l'admin
}