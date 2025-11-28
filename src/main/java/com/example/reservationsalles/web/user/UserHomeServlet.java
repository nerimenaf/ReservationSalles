package com.example.reservationsalles.web.user;

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

@WebServlet("/user/home")
public class UserHomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SalleDao salleDao = new SalleDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Salle> salles = salleDao.findAll();
            request.setAttribute("salles", salles);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/views/user/home.jsp")
               .forward(request, response);
    }
}