package com.example.reservationsalles.dao;

import java.util.List;

import com.example.reservationsalles.model.Salle;

public interface SalleDao {
    Salle findById(Long id) throws Exception;

    List<Salle> findAll() throws Exception;

    void save(Salle salle) throws Exception; // insert ou update

    void delete(Long id) throws Exception;
}