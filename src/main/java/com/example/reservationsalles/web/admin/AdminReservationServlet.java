package com.example.reservationsalles.web.admin;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import com.example.reservationsalles.dao.ReservationDao;
import com.example.reservationsalles.dao.impl.ReservationDaoImpl;
import com.example.reservationsalles.model.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/reservations")
public class AdminReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDao reservationDao = new ReservationDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "validate":
                    changeStatus(request, response, "VALIDEE", "Validée par l'administrateur");
                    break;
                case "refuse":
                    changeStatus(request, response, "REFUSEE", "Refusée par l'administrateur");
                    break;
                case "cancel":
                    changeStatus(request, response, "ANNULEE", "Annulée par l'administrateur");
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

    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // 1) Récupérer toutes les réservations (déjà triées par date si ton DAO le fait)
        List<Reservation> allReservations = reservationDao.findAll();

        // 2) Compter par statut
        int allCount = allReservations.size();
        int pendingCount = 0;
        int confirmedCount = 0;
        int refusedCount = 0;
        int cancelledCount = 0;

        for (Reservation r : allReservations) {
            String statut = r.getStatut();
            if ("EN_ATTENTE".equals(statut)) {
                pendingCount++;
            } else if ("VALIDEE".equals(statut)) { // statut en base = VALIDEE
                confirmedCount++;
            } else if ("REFUSEE".equals(statut)) {
                refusedCount++;
            } else if ("ANNULEE".equals(statut)) {
                cancelledCount++;
            }
        }

        // 3) Lire le filtre demandé
        String statusFilter = request.getParameter("status");
        if (statusFilter == null || statusFilter.isEmpty()) {
            statusFilter = "ALL";
        }

        // 4) Filtrer la liste selon statusFilter
        List<Reservation> filteredReservations = new java.util.ArrayList<>();
        if ("ALL".equals(statusFilter)) {
            filteredReservations = allReservations;
        } else {
            for (Reservation r : allReservations) {
                if (statusFilter.equals(r.getStatut())) {
                    filteredReservations.add(r);
                }
            }
        }

        // 5) Passer les données à la JSP
        request.setAttribute("reservations", filteredReservations);
        request.setAttribute("statusFilter", statusFilter);

        request.setAttribute("allCount", allCount);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("confirmedCount", confirmedCount);
        request.setAttribute("refusedCount", refusedCount);
        request.setAttribute("cancelledCount", cancelledCount);

        request.getRequestDispatcher("/WEB-INF/views/admin/reservations/list.jsp")
               .forward(request, response);
    }

    private void changeStatus(HttpServletRequest request, HttpServletResponse response,
                              String newStatus, String defaultComment)
            throws Exception {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
            return;
        }

        Long id = Long.parseLong(idStr);
        Reservation r = reservationDao.findById(id);
        if (r == null) {
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
            return;
        }

        // Règle : pas de modification si réservation déjà passée
        if (r.getDateHeureDebut().isBefore(LocalDateTime.now())) {
            // on pourrait mettre un message, pour l'instant simple redirection
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
            return;
        }

        // Si déjà annulée ou refusée, on ne fait rien
        if ("ANNULEE".equals(r.getStatut()) || "REFUSEE".equals(r.getStatut())) {
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
            return;
        }

        reservationDao.updateStatus(id, newStatus, defaultComment);
        response.sendRedirect(request.getContextPath() + "/admin/reservations");
    }
}