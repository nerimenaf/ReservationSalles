package com.example.reservationsalles.dao;

import java.util.List;

import com.example.reservationsalles.model.Utilisateur;

public interface UtilisateurDao {
    Utilisateur findById(Long id) throws Exception;

    Utilisateur findByLoginAndPassword(String login, String motDePasse) throws Exception;

    List<Utilisateur> findAll() throws Exception;

    void save(Utilisateur utilisateur) throws Exception; // insert ou update

    void delete(Long id) throws Exception;
}