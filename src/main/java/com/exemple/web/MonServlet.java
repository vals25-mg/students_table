package com.exemple.web;
import com.exemple.ejb.MonServiceEJB;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet(name="MonServlet", urlPatterns="/hello")
public class MonServlet extends HttpServlet {
    @EJB private MonServiceEJB serviceEJB;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String nom = req.getParameter("nom") != null ? req.getParameter("nom") : "Monde";
        String message = serviceEJB.direBonjour(nom);
        int somme = serviceEJB.calculer(5, 3);
        out.println("<!DOCTYPE html><html><head><title>EJB Test</title></head><body>");
        out.println("<h1>" + message + "</h1><p>Somme: " + somme + "</p>");
        out.println("<a href='index.jsp'>Accueil</a></body></html>");
    }
}