package com.example.reservationsalles.web.filter;

import java.io.IOException;

import com.example.reservationsalles.model.Utilisateur;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // rien
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        Utilisateur user = (session != null) ? (Utilisateur) session.getAttribute("userSession") : null;

        if (user == null || !"ADMIN".equals(user.getRole())) {
            // pas admin => on le renvoie à l'accueil utilisateur ou login
            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/login");
            } else {
                res.sendRedirect(req.getContextPath() + "/user/home");
            }
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // rien
    }
}