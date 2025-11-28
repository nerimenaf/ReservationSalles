package com.example.reservationsalles.web;

import java.io.IOException;

import com.example.reservationsalles.dao.UtilisateurDao;
import com.example.reservationsalles.dao.impl.UtilisateurDaoImpl;
import com.example.reservationsalles.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/login", "/logout"})
public class AuthServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UtilisateurDao utilisateurDao = new UtilisateurDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String servletPath = request.getServletPath();

        if ("/logout".equals(servletPath)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // /login GET => afficher le formulaire
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("login");
        String motDePasse = request.getParameter("motDePasse");

        try {
            Utilisateur u = utilisateurDao.findByLoginAndPassword(login, motDePasse);
            if (u == null) {
                request.setAttribute("error", "Login ou mot de passe incorrect");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            // Authentification OK
            HttpSession session = request.getSession(true);
            session.setAttribute("userSession", u);

            if ("ADMIN".equals(u.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/home");
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}