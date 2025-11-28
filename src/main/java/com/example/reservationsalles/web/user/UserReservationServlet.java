package com.example.reservationsalles.web.user;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

import com.example.reservationsalles.dao.ReservationDao;
import com.example.reservationsalles.dao.SalleDao;
import com.example.reservationsalles.dao.impl.ReservationDaoImpl;
import com.example.reservationsalles.dao.impl.SalleDaoImpl;
import com.example.reservationsalles.model.Reservation;
import com.example.reservationsalles.model.Salle;
import com.example.reservationsalles.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/reservations")
public class UserReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDao reservationDao = new ReservationDaoImpl();
    private SalleDao salleDao = new SalleDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    showForm(request, response);
                    break;
                case "cancel":
                    cancelReservation(request, response);
                    break;
                case "list":
                default:
                    listReservations(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "create";

        try {
            switch (action) {
                case "create":
                default:
                    createReservation(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    private Utilisateur getUserFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (Utilisateur) session.getAttribute("userSession") : null;
    }

    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Utilisateur user = getUserFromSession(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Reservation> reservations = reservationDao.findByUtilisateur(user.getId());
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/WEB-INF/views/user/reservations/list.jsp")
               .forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Utilisateur user = getUserFromSession(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Salle> salles = salleDao.findAll();
        request.setAttribute("salles", salles);
        request.getRequestDispatcher("/WEB-INF/views/user/reservations/form.jsp")
               .forward(request, response);
    }

    private void createReservation(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Utilisateur user = getUserFromSession(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String salleIdStr = request.getParameter("salleId");
        String debutStr = request.getParameter("dateHeureDebut");
        String finStr = request.getParameter("dateHeureFin");

        String error = null;
        Long salleId = null;
        LocalDateTime debut = null;
        LocalDateTime fin = null;

        // Validation de base
        try {
            salleId = Long.parseLong(salleIdStr);
        } catch (Exception e) {
            error = "Salle invalide";
        }

        try {
            if (debutStr == null || finStr == null) {
                error = "Les dates sont obligatoires";
            } else {
                // Format attendu : 2025-12-20T09:00 (input type="datetime-local")
                debut = LocalDateTime.parse(debutStr);
                fin = LocalDateTime.parse(finStr);
            }
        } catch (DateTimeParseException e) {
            error = "Format de date/heure invalide";
        }

        if (error == null) {
            if (fin.isBefore(debut) || fin.isEqual(debut)) {
                error = "La date de fin doit être après la date de début";
            } else if (debut.isBefore(LocalDateTime.now())) {
                error = "La date de début doit être dans le futur";
            }
        }

        if (error == null) {
            // Vérifier non chevauchement salle
            if (reservationDao.existsConflictForSalle(salleId, debut, fin, null)) {
                error = "Cette salle est déjà réservée sur ce créneau";
            }
        }

        if (error == null) {
            // Vérifier non chevauchement utilisateur
            if (reservationDao.existsConflictForUtilisateur(user.getId(), debut, fin, null)) {
                error = "Vous avez déjà une réservation sur ce créneau";
            }
        }

        if (error != null) {
            // Réafficher le formulaire avec erreur
            List<Salle> salles = salleDao.findAll();
            request.setAttribute("salles", salles);
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/user/reservations/form.jsp")
                   .forward(request, response);
            return;
        }

        // Création de la réservation
        Reservation r = new Reservation();
        r.setIdSalle(salleId);
        r.setIdUtilisateur(user.getId());
        r.setDateHeureDebut(debut);
        r.setDateHeureFin(fin);
        r.setStatut("EN_ATTENTE");
        r.setCommentaire(null);

        reservationDao.create(r);

        response.sendRedirect(request.getContextPath() + "/user/reservations");
    }

    private void cancelReservation(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Utilisateur user = getUserFromSession(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/reservations");
            return;
        }

        Long id = Long.parseLong(idStr);
        Reservation r = reservationDao.findById(id);
        if (r == null || !r.getIdUtilisateur().equals(user.getId())) {
            // soit pas trouvée, soit ne lui appartient pas
            response.sendRedirect(request.getContextPath() + "/user/reservations");
            return;
        }

        // Règle : les réservations passées ne peuvent plus être modifiées
        if (r.getDateHeureDebut().isBefore(LocalDateTime.now())) {
            // on pourrait mettre un message d'erreur, pour l'instant on redirige
            response.sendRedirect(request.getContextPath() + "/user/reservations");
            return;
        }

        // Si déjà annulée / refusée, inutile
        if ("ANNULEE".equals(r.getStatut()) || "REFUSEE".equals(r.getStatut())) {
            response.sendRedirect(request.getContextPath() + "/user/reservations");
            return;
        }

        reservationDao.updateStatus(id, "ANNULEE", "Annulée par l'utilisateur");
        response.sendRedirect(request.getContextPath() + "/user/reservations");
    }
}