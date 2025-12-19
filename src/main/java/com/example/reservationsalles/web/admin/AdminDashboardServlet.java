package com.example.reservationsalles.web.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.example.reservationsalles.dao.SalleDao;
import com.example.reservationsalles.dao.UtilisateurDao;
import com.example.reservationsalles.dao.StatsDao;
import com.example.reservationsalles.dao.AvisSalleDao;
import com.example.reservationsalles.dao.ReservationDao;
import com.example.reservationsalles.dao.impl.SalleDaoImpl;
import com.example.reservationsalles.dao.impl.UtilisateurDaoImpl;
import com.example.reservationsalles.dao.impl.StatsDaoImpl;
import com.example.reservationsalles.dao.impl.AvisSalleDaoImpl;
import com.example.reservationsalles.dao.impl.ReservationDaoImpl;
import com.example.reservationsalles.model.Salle;
import com.example.reservationsalles.model.Utilisateur;
import com.example.reservationsalles.model.Reservation;
import com.example.reservationsalles.model.AvisSalle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SalleDao salleDao = new SalleDaoImpl();
    private UtilisateurDao utilisateurDao = new UtilisateurDaoImpl();
    private StatsDao statsDao = new StatsDaoImpl();
    private AvisSalleDao avisSalleDao = new AvisSalleDaoImpl();
    private ReservationDao reservationDao = new ReservationDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ====== Totaux simples ======
            List<Salle> salles = salleDao.findAll();
            long totalSalles = salles.size();

            List<Utilisateur> utilisateurs = utilisateurDao.findAll();
            long totalUsers = utilisateurs.size();

            List<AvisSalle> avis = avisSalleDao.findAll();
            long totalAvis = avis.size();

            // ====== Stats par statut ======
            // Map<String, Long> avec clés : EN_ATTENTE, VALIDEE, REFUSEE, ANNULEE
            Map<String, Long> statsByStatus = statsDao.countReservationsByStatus();
            long pending = statsByStatus.getOrDefault("EN_ATTENTE", 0L);
            long confirmed = statsByStatus.getOrDefault("VALIDEE", 0L); // ATTENTION: statut = VALIDEE

            // ====== Réservations récentes ======
            // findAll() est déjà trié par date_heure_debut DESC dans ton DAO
            List<Reservation> allReservations = reservationDao.findAll();
            List<Reservation> recentReservations = allReservations;
            if (recentReservations.size() > 5) {
                recentReservations = recentReservations.subList(0, 5);
            }

            // ====== Attributs pour la JSP ======
            request.setAttribute("totalSalles", totalSalles);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalAvis", totalAvis);
            request.setAttribute("pendingReservations", pending);
            request.setAttribute("confirmedReservations", confirmed);
            request.setAttribute("recentReservations", recentReservations);

            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}