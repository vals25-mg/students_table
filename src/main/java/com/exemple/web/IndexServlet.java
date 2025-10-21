package com.exemple.web;

import com.exemple.ejb.InscriptionService;
import com.exemple.model.VInscription;
import jakarta.ejb.EJB;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {

    @EJB
    private InscriptionService service;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Maintenant on récupère List<VInscription>
            List<VInscription> resultats = service.getClassements();
            req.setAttribute("resultats", resultats);

            VInscription major = service.getMajorDesMajors();
            req.setAttribute("major", major);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erreur", e.getMessage());
        }

        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/pages/index.jsp");
        rd.forward(req, resp);
    }
}
