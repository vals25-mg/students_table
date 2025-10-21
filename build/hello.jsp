<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.ejb.EJB" %>
<%@ page import="com.exemple.ejb.MonServiceEJB" %>
<jsp:useBean id="service" class="com.exemple.ejb.MonServiceEJB" scope="request"/>

<!DOCTYPE html>
<html><head><title>JSP + EJB OK !</title></head>
<body>
<h1>🌟 JSP + EJB DIRECT !</h1>
<%
    String nom = request.getParameter("nom") != null ? request.getParameter("nom") : "Monde";
    String message = service.direBonjour(nom);
    int somme = service.calculer(10, 20);
%>
<h2><%= message %></h2>
<p>🎯 Somme: <%= somme %></p>
<p><a href="index.jsp">← Accueil</a></p>
</body>
</html>