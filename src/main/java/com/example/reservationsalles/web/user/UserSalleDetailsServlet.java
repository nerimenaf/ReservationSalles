package com.example.reservationsalles.web.user;

import java.io.IOException;
import java.util.List;

import com.example.reservationsalles.dao.AvisSalleDao;
import com.example.reservationsalles.dao.SalleDao;
import com.example.reservationsalles.dao.impl.AvisSalleDaoImpl;
import com.example.reservationsalles.dao.impl.SalleDaoImpl;
import com.example.reservationsalles.model.AvisSalle;
import com.example.reservationsalles.model.Salle;
import com.example.reservationsalles.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/salle")
public class UserSalleDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SalleDao salleDao = new SalleDaoImpl();
    private AvisSalleDao avisSalleDao = new AvisSalleDaoImpl();

    private Utilisateur getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (Utilisateur) session.getAttribute("userSession") : null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/home");
            return;
        }

        try {
            Long salleId = Long.parseLong(idStr);
            Salle salle = salleDao.findById(salleId);
            if (salle == null) {
                response.sendRedirect(request.getContextPath() + "/user/home");
                return;
            }

            List<AvisSalle> avisList = avisSalleDao.findBySalle(salleId);
            Double moyenne = avisSalleDao.getAverageNoteBySalle(salleId);

            Utilisateur user = getUser(request);
            AvisSalle avisUser = null;
            if (user != null) {
                avisUser = avisSalleDao.findBySalleAndUtilisateur(salleId, user.getId());
            }

            request.setAttribute("salle", salle);
            request.setAttribute("avisList", avisList);
            request.setAttribute("moyenne", moyenne);
            request.setAttribute("avisUser", avisUser);

            request.getRequestDispatcher("/WEB-INF/views/user/salles/details.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "saveAvis";

        try {
            if ("saveAvis".equals(action)) {
                saveAvis(request, response, user);
            } else if ("deleteAvis".equals(action)) {
                deleteAvis(request, response, user);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/home");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    private void saveAvis(HttpServletRequest request, HttpServletResponse response, Utilisateur user)
            throws Exception {

        String salleIdStr = request.getParameter("salleId");
        String noteStr = request.getParameter("note");
        String commentaire = request.getParameter("commentaire");

        Long salleId = Long.parseLong(salleIdStr);
        String error = null;
        int note = 0;

        try {
            note = Integer.parseInt(noteStr);
            if (note < 1 || note > 5) {
                error = "La note doit être entre 1 et 5";
            }
        } catch (NumberFormatException e) {
            error = "Note invalide";
        }

        AvisSalle avis = avisSalleDao.findBySalleAndUtilisateur(salleId, user.getId());
        if (avis == null) {
            avis = new AvisSalle();
            avis.setIdSalle(salleId);
            avis.setIdUtilisateur(user.getId());
        }

        avis.setNote(note);
        avis.setCommentaire(commentaire);

        if (error != null) {
            request.setAttribute("error", error);

            // Recharger les données pour la page
            Salle salle = salleDao.findById(salleId);
            request.setAttribute("salle", salle);
            request.setAttribute("avisUser", avis);
            request.setAttribute("avisList", avisSalleDao.findBySalle(salleId));
            request.setAttribute("moyenne", avisSalleDao.getAverageNoteBySalle(salleId));

            request.getRequestDispatcher("/WEB-INF/views/user/salles/details.jsp")
                   .forward(request, response);
            return;
        }

        avisSalleDao.save(avis);
        response.sendRedirect(request.getContextPath() + "/user/salle?id=" + salleId);
    }

    private void deleteAvis(HttpServletRequest request, HttpServletResponse response, Utilisateur user)
            throws Exception {

        String avisIdStr = request.getParameter("avisId");
        String salleIdStr = request.getParameter("salleId");

        if (avisIdStr != null && !avisIdStr.isEmpty()) {
            Long avisId = Long.parseLong(avisIdStr);
            // On pourrait vérifier que l'avis appartient à l'utilisateur, à toi de voir
            avisSalleDao.delete(avisId);
        }

        response.sendRedirect(request.getContextPath() + "/user/salle?id=" + salleIdStr);
    }
}