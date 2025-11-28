package com.example.reservationsalles.model;

import java.time.LocalDateTime;

public class Utilisateur {
    private Long id;
    private String login;
    private String motDePasse;
    private String nomComplet;
    private String role;          // "ADMIN" ou "USER"
    private boolean actif;
    private LocalDateTime dateCreation;

    public Utilisateur() {
    }

    public Utilisateur(Long id, String login, String motDePasse, String nomComplet, String role, boolean actif,
            LocalDateTime dateCreation) {
        this.id = id;
        this.login = login;
        this.motDePasse = motDePasse;
        this.nomComplet = nomComplet;
        this.role = role;
        this.actif = actif;
        this.dateCreation = dateCreation;
    }

    // Getters et setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getNomComplet() {
        return nomComplet;
    }

    public void setNomComplet(String nomComplet) {
        this.nomComplet = nomComplet;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }

    public LocalDateTime getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }
}