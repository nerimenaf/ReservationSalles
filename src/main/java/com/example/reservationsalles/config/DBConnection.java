package com.example.reservationsalles.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3308/reservation_salles?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";      
    private static final String PASSWORD = "nerimen";     

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // charge le driver MySQL
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Dans un vrai projet : logger proprement
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}