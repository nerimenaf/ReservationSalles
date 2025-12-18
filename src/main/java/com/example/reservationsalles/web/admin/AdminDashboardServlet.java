package com.example.reservationsalles.web.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.example.reservationsalles.dao.SalleDao;
import com.example.reservationsalles.dao.UtilisateurDao;
import com.example.reservationsalles.dao.StatsDao;
import com.example.reservationsalles.dao.impl.SalleDaoImpl;
import com.example.reservationsalles.dao.impl.UtilisateurDaoImpl;
import com.example.reservationsalles.dao.impl.StatsDaoImpl;
import com.example.reservationsalles.model.Salle;
import com.example.reservationsalles.model.Utilisateur;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Total salles
            List<Salle> salles = salleDao.findAll();
            long totalSalles = salles.size();

            // Total utilisateurs
            List<Utilisateur> utilisateurs = utilisateurDao.findAll();
            long totalUsers = utilisateurs.size();

            // Réservations en attente
            Map<String, Long> statsByStatus = statsDao.countReservationsByStatus();
            Long pending = statsByStatus.get("EN_ATTENTE");
            if (pending == null) pending = 0L;

            request.setAttribute("totalSalles", totalSalles);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("pendingReservations", pending);

            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}