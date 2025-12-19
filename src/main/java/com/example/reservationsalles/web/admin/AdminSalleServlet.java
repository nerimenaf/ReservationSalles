package com.example.reservationsalles.web.admin;

import java.io.IOException;
import java.util.List;

import com.example.reservationsalles.dao.SalleDao;
import com.example.reservationsalles.dao.impl.SalleDaoImpl;
import com.example.reservationsalles.model.Salle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/salles")
public class AdminSalleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SalleDao salleDao = new SalleDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "edit":
                    showForm(request, response);
                    break;
                case "delete":
                    deleteSalle(request, response);
                    break;
                case "list":
                default:
                    listSalles(request, response);
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

        // pour sauvegarder (ajout/modification)
        try {
            saveSalle(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    private void listSalles(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List<Salle> salles = salleDao.findAll();
        request.setAttribute("salles", salles);
        request.getRequestDispatcher("/WEB-INF/views/admin/salles/list.jsp")
               .forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Long id = Long.parseLong(idStr);
            Salle salle = salleDao.findById(id);
            request.setAttribute("salle", salle);
        }
        // sinon, formulaire vide (ajout)
        request.getRequestDispatcher("/WEB-INF/views/admin/salles/form.jsp")
               .forward(request, response);
    }

    private void saveSalle(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String idStr = request.getParameter("id");
        String nom = request.getParameter("nom");
        String capaciteStr = request.getParameter("capacite");
        String localisation = request.getParameter("localisation");
        String equipements = request.getParameter("equipements");
        String activeStr = request.getParameter("active"); // <<< CHECKBOX

        String error = null;
        int capacite = 0;

        if (nom == null || nom.trim().isEmpty()) {
            error = "Le nom est obligatoire";
        } else if (capaciteStr == null || capaciteStr.trim().isEmpty()) {
            error = "La capacité est obligatoire";
        } else {
            try {
                capacite = Integer.parseInt(capaciteStr);
                if (capacite <= 0) {
                    error = "La capacité doit être positive";
                }
            } catch (NumberFormatException e) {
                error = "La capacité doit être un entier";
            }
        }

        Salle salle = new Salle();
        if (idStr != null && !idStr.isEmpty()) {
            salle.setId(Long.parseLong(idStr));
        }
        salle.setNom(nom);
        salle.setCapacite(capacite);
        salle.setLocalisation(localisation);
        salle.setEquipements(equipements);

        boolean active = (activeStr != null);   // checkbox => présent si cochée
        salle.setActive(active);                // <<< CRUCIAL

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("salle", salle);
            request.getRequestDispatcher("/WEB-INF/views/admin/salles/form.jsp")
                   .forward(request, response);
            return;
        }

        salleDao.save(salle);
        response.sendRedirect(request.getContextPath() + "/admin/salles");
    }
    private void deleteSalle(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Long id = Long.parseLong(idStr);
            salleDao.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/admin/salles");
    }
}