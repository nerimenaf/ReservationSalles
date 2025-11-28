package com.example.reservationsalles.web.admin;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import com.example.reservationsalles.dao.UtilisateurDao;
import com.example.reservationsalles.dao.impl.UtilisateurDaoImpl;
import com.example.reservationsalles.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UtilisateurDao utilisateurDao = new UtilisateurDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "edit":
                    showForm(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                case "list":
                default:
                    listUsers(request, response);
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

        try {
            saveUser(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List<Utilisateur> utilisateurs = utilisateurDao.findAll();
        request.setAttribute("utilisateurs", utilisateurs);
        request.getRequestDispatcher("/WEB-INF/views/admin/users/list.jsp")
               .forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Long id = Long.parseLong(idStr);
            Utilisateur u = utilisateurDao.findById(id);
            request.setAttribute("utilisateur", u);
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/users/form.jsp")
               .forward(request, response);
    }

    private void saveUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String idStr = request.getParameter("id");
        String login = request.getParameter("login");
        String motDePasse = request.getParameter("motDePasse");
        String nomComplet = request.getParameter("nomComplet");
        String role = request.getParameter("role");
        String actifStr = request.getParameter("actif");

        String error = null;
        boolean actif = (actifStr != null);

        if (login == null || login.trim().isEmpty()) {
            error = "Le login est obligatoire";
        } else if (nomComplet == null || nomComplet.trim().isEmpty()) {
            error = "Le nom complet est obligatoire";
        } else if (role == null || (!"ADMIN".equals(role) && !"USER".equals(role))) {
            error = "Rôle invalide";
        }

        Utilisateur u = new Utilisateur();
        if (idStr != null && !idStr.isEmpty()) {
            u.setId(Long.parseLong(idStr));
        }
        u.setLogin(login);
        u.setNomComplet(nomComplet);
        u.setRole(role);
        u.setActif(actif);

        // Gestion du mot de passe :
        if (u.getId() == null) {
            // Nouveau compte : mot de passe obligatoire
            if (motDePasse == null || motDePasse.trim().isEmpty()) {
                error = "Le mot de passe est obligatoire pour un nouvel utilisateur";
            } else {
                u.setMotDePasse(motDePasse);
            }
        } else {
            // Edition : si motDePasse vide => garder l'ancien
            if (motDePasse == null || motDePasse.trim().isEmpty()) {
                Utilisateur existing = utilisateurDao.findById(u.getId());
                if (existing != null) {
                    u.setMotDePasse(existing.getMotDePasse());
                }
            } else {
                u.setMotDePasse(motDePasse);
            }
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("utilisateur", u);
            request.getRequestDispatcher("/WEB-INF/views/admin/users/form.jsp")
                   .forward(request, response);
            return;
        }

        try {
            utilisateurDao.save(u);
        } catch (SQLIntegrityConstraintViolationException ex) {
            // login unique violé
            request.setAttribute("error", "Ce login est déjà utilisé");
            request.setAttribute("utilisateur", u);
            request.getRequestDispatcher("/WEB-INF/views/admin/users/form.jsp")
                   .forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Long id = Long.parseLong(idStr);
            utilisateurDao.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}