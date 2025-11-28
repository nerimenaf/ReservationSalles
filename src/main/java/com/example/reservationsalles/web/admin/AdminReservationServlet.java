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

        List<Reservation> reservations = reservationDao.findAll();
        request.setAttribute("reservations", reservations);
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