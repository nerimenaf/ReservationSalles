package com.example.reservationsalles.web.user;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.reservationsalles.dao.ReservationDao;
import com.example.reservationsalles.dao.impl.ReservationDaoImpl;
import com.example.reservationsalles.model.Reservation;
import com.example.reservationsalles.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/calendar")
public class UserCalendarServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDao reservationDao = new ReservationDaoImpl();

    private Utilisateur getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (Utilisateur) session.getAttribute("userSession") : null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 1) Déterminer la semaine à afficher
        String startDateParam = request.getParameter("startDate"); // format yyyy-MM-dd
        LocalDate startDate;

        try {
            if (startDateParam != null && !startDateParam.isEmpty()) {
                startDate = LocalDate.parse(startDateParam);
            } else {
                // Lundi de la semaine courante
                LocalDate today = LocalDate.now();
                startDate = today.with(DayOfWeek.MONDAY);
            }
        } catch (Exception e) {
            // En cas de format invalide, on retombe sur la semaine courante
            LocalDate today = LocalDate.now();
            startDate = today.with(DayOfWeek.MONDAY);
        }

        LocalDate endDate = startDate.plusDays(6);

        // 2) Récupérer toutes les réservations de l'utilisateur
        List<Reservation> allReservations;
        try {
            allReservations = reservationDao.findByUtilisateur(user.getId());
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }

        // 3) Ne garder que celles de la semaine affichée
        List<Reservation> reservations = new ArrayList<>();
        for (Reservation r : allReservations) {
            LocalDate d = r.getDateHeureDebut().toLocalDate();
            if (!d.isBefore(startDate) && !d.isAfter(endDate)) {
                reservations.add(r);
            }
        }

        // 4) Construire la liste des jours et des heures
        List<String> days = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            days.add(startDate.plusDays(i).toString()); // yyyy-MM-dd
        }

        List<Integer> hours = new ArrayList<>();
        for (int h = 8; h <= 18; h++) { // de 8h à 18h
            hours.add(h);
        }

        // 5) Construire une grille (Map) : key = "yyyy-MM-dd_HH" -> Reservation
        Map<String, Reservation> grid = new HashMap<>();
        for (Reservation r : reservations) {
            LocalDateTime deb = r.getDateHeureDebut();
            LocalDateTime fin = r.getDateHeureFin();

            LocalDate d = deb.toLocalDate();
            if (d.isBefore(startDate) || d.isAfter(endDate)) {
                continue;
            }

            int startHour = deb.getHour();
            int endHour = fin.getHour(); // on remplit de startHour à endHour - 1

            for (int h : hours) {
                if (h >= startHour && h < endHour) {
                    String key = d.toString() + "_" + h;
                    grid.put(key, r);
                }
            }
        }

        // 6) Attributs pour la JSP
        request.setAttribute("days", days);
        request.setAttribute("hours", hours);
        request.setAttribute("grid", grid);
        request.setAttribute("startDate", startDate.toString());
        request.setAttribute("endDate", endDate.toString());
        request.setAttribute("prevWeek", startDate.minusWeeks(1).toString());
        request.setAttribute("nextWeek", startDate.plusWeeks(1).toString());

        request.getRequestDispatcher("/WEB-INF/views/user/calendar.jsp")
               .forward(request, response);
    }
}