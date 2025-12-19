package com.example.reservationsalles.model;

public class Salle {
    private Long id;
    private String nom;
    private int capacite;
    private String localisation;
    private String equipements;
    private boolean active; 

    public Salle() {
    }

    public Salle(Long id, String nom, int capacite, String localisation, String equipements,boolean active) {
        this.id = id;
        this.nom = nom;
        this.capacite = capacite;
        this.localisation = localisation;
        this.equipements = equipements;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public int getCapacite() {
        return capacite;
    }

    public void setCapacite(int capacite) {
        this.capacite = capacite;
    }

    public String getLocalisation() {
        return localisation;
    }

    public void setLocalisation(String localisation) {
        this.localisation = localisation;
    }

    public String getEquipements() {
        return equipements;
    }

    public void setEquipements(String equipements) {
        this.equipements = equipements;
    }

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}
}