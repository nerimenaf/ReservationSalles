package com.example.reservationsalles.model;

public class SalleStats {
    private String nomSalle;
    private long nombreReservations;

    public SalleStats() {
    }

    public SalleStats(String nomSalle, long nombreReservations) {
        this.nomSalle = nomSalle;
        this.nombreReservations = nombreReservations;
    }

    public String getNomSalle() {
        return nomSalle;
    }

    public void setNomSalle(String nomSalle) {
        this.nomSalle = nomSalle;
    }

    public long getNombreReservations() {
        return nombreReservations;
    }

    public void setNombreReservations(long nombreReservations) {
        this.nombreReservations = nombreReservations;
    }
}