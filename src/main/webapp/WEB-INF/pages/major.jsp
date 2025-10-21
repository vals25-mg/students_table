<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.exemple.ejb.InscriptionService" %>
<%@ page import="com.exemple.model.VInscription" %>
<jsp:useBean id="service" class="com.exemple.ejb.InscriptionService"/>

<!DOCTYPE html>
<html><head>
    <title>🏆 MAJOR DES MAJORS</title>
    <style>body{font-family:Arial; text-align:center; background:#f0f8ff}</style>
</head>
<body>
    <h1>🏆 MAJOR DES MAJORS 2025 !</h1>
    <%
        try {
            VInscription major = service.getMajorDesMajors();
            if (major != null) {
    %>
                <div style="background:gold; padding:20px; margin:20px; border-radius:10px">
                    <h2>🥇 #1 ABSOLU !</h2>
                    <p><strong><%= major.getNom() %></strong></p>
                    <p><strong>Moyenne :</strong> <%= String.format("%.2f", major.getMoyenne()) %> / 20</p>
                    <p><strong>Filière :</strong> <%= major.getFiliereNom() %></p>
                    <p><strong>Année :</strong> <%= major.getAnneeDebut() %>-<%= major.getAnneeFin() %></p>
                </div>
    <%
            } else {
    %>
                <p>❌ Aucun élève trouvé !</p>
    <%
            }
        } catch(Exception e) {
    %>
            <p style="color:red">❌ ERREUR: <%= e.getMessage() %></p>
    <%
        }
    %>
    <p><a href="index">← Accueil</a></p>
</body>
</html>