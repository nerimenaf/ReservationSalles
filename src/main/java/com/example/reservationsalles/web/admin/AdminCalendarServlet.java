package com.example.reservationsalles.web.admin;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.reservationsalles.dao.ReservationDao;
import com.example.reservationsalles.dao.SalleDao;
import com.example.reservationsalles.dao.impl.ReservationDaoImpl;
import com.example.reservationsalles.dao.impl.SalleDaoImpl;
import com.example.reservationsalles.model.Reservation;
import com.example.reservationsalles.model.Salle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/calendar")
public class AdminCalendarServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDao reservationDao = new ReservationDaoImpl();
    private SalleDao salleDao = new SalleDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String startDateParam = request.getParameter("startDate");
        String salleIdParam = request.getParameter("salleId");

        // Récupérer toutes les salles pour le select
        List<Salle> salles;
        try {
            salles = salleDao.findAll();
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
        request.setAttribute("salles", salles);

        // S'il n'y a pas de salle sélectionnée, on affiche juste le formulaire
        if (salleIdParam == null || salleIdParam.isEmpty()) {
            request.getRequestDispatcher("/WEB-INF/views/admin/calendar.jsp")
                   .forward(request, response);
            return;
        }

        Long salleId;
        try {
            salleId = Long.parseLong(salleIdParam);
        } catch (NumberFormatException e) {
            request.getRequestDispatcher("/WEB-INF/views/admin/calendar.jsp")
                   .forward(request, response);
            return;
        }

        Salle salle;
        try {
            salle = salleDao.findById(salleId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
        if (salle == null) {
            request.getRequestDispatcher("/WEB-INF/views/admin/calendar.jsp")
                   .forward(request, response);
            return;
        }

        // Déterminer la semaine
        LocalDate startDate;
        try {
            if (startDateParam != null && !startDateParam.isEmpty()) {
                startDate = LocalDate.parse(startDateParam);
            } else {
                LocalDate today = LocalDate.now();
                startDate = today.with(DayOfWeek.MONDAY);
            }
        } catch (Exception e) {
            LocalDate today = LocalDate.now();
            startDate = today.with(DayOfWeek.MONDAY);
        }
        LocalDate endDate = startDate.plusDays(6);

        // Récupérer les réservations de la salle
        List<Reservation> allReservations;
        try {
            allReservations = reservationDao.findBySalle(salleId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }

        List<Reservation> reservations = new ArrayList<>();
        for (Reservation r : allReservations) {
            LocalDate d = r.getDateHeureDebut().toLocalDate();
            if (!d.isBefore(startDate) && !d.isAfter(endDate)) {
                reservations.add(r);
            }
        }

        // Construire jours + heures
        List<String> days = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            days.add(startDate.plusDays(i).toString());
        }

        List<Integer> hours = new ArrayList<>();
        for (int h = 8; h <= 18; h++) {
            hours.add(h);
        }

        Map<String, Reservation> grid = new HashMap<>();
        for (Reservation r : reservations) {
            LocalDateTime deb = r.getDateHeureDebut();
            LocalDateTime fin = r.getDateHeureFin();
            LocalDate d = deb.toLocalDate();

            if (d.isBefore(startDate) || d.isAfter(endDate)) {
                continue;
            }

            int startHour = deb.getHour();
            int endHour = fin.getHour();

            for (int h : hours) {
                if (h >= startHour && h < endHour) {
                    String key = d.toString() + "_" + h;
                    grid.put(key, r);
                }
            }
        }

        request.setAttribute("selectedSalle", salle);
        request.setAttribute("days", days);
        request.setAttribute("hours", hours);
        request.setAttribute("grid", grid);
        request.setAttribute("startDate", startDate.toString());
        request.setAttribute("endDate", endDate.toString());
        request.setAttribute("prevWeek", startDate.minusWeeks(1).toString());
        request.setAttribute("nextWeek", startDate.plusWeeks(1).toString());

        request.getRequestDispatcher("/WEB-INF/views/admin/calendar.jsp")
               .forward(request, response);
    }
}