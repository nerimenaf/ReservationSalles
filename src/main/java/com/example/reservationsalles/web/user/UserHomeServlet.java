package com.example.reservationsalles.web.user;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.List;

import com.example.reservationsalles.dao.SalleDao;
import com.example.reservationsalles.dao.impl.SalleDaoImpl;
import com.example.reservationsalles.model.Salle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/user/home")
public class UserHomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SalleDao salleDao = new SalleDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dateStr = request.getParameter("date");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String capaciteMinStr = request.getParameter("capaciteMin");
        String equipements = request.getParameter("equipements");

        // Pour ré-afficher les valeurs dans le formulaire
        request.setAttribute("date", dateStr);
        request.setAttribute("startTime", startTimeStr);
        request.setAttribute("endTime", endTimeStr);
        request.setAttribute("capaciteMin", capaciteMinStr);
        request.setAttribute("equipements", equipements);

        List<Salle> salles = null;
        String error = null;

        // On ne recherche que si la date et les heures sont renseignées
        if (dateStr != null && !dateStr.isEmpty()
                && startTimeStr != null && !startTimeStr.isEmpty()
                && endTimeStr != null && !endTimeStr.isEmpty()) {

            try {
                LocalDate date = LocalDate.parse(dateStr); // format yyyy-MM-dd
                LocalTime startTime = LocalTime.parse(startTimeStr); // HH:mm
                LocalTime endTime = LocalTime.parse(endTimeStr);

                LocalDateTime debut = LocalDateTime.of(date, startTime);
                LocalDateTime fin = LocalDateTime.of(date, endTime);

                if (!fin.isAfter(debut)) {
                    error = "L'heure de fin doit être après l'heure de début.";
                } else if (debut.isBefore(LocalDateTime.now())) {
                    error = "Le créneau doit être dans le futur.";
                } else {
                    Integer capaciteMin = null;
                    if (capaciteMinStr != null && !capaciteMinStr.isEmpty()) {
                        try {
                            capaciteMin = Integer.parseInt(capaciteMinStr);
                        } catch (NumberFormatException e) {
                            error = "La capacité minimale doit être un entier.";
                        }
                    }

                    if (error == null) {
                        salles = salleDao.findAvailable(debut, fin, capaciteMin, equipements);
                        // pour pré-remplir le formulaire de réservation
                        request.setAttribute("searchDebut", debut.toString());
                        request.setAttribute("searchFin", fin.toString());
                    }
                }

            } catch (DateTimeParseException e) {
                error = "Format de date ou d'heure invalide.";
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }

        request.setAttribute("salles", salles);
        request.setAttribute("error", error);

        request.getRequestDispatcher("/WEB-INF/views/user/home.jsp")
               .forward(request, response);
    }
}