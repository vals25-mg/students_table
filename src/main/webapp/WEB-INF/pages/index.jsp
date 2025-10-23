<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>🏆 ÉLÈVES - MAJOR</title>
            <style>
                body {
                    font-family: Arial;
                    margin: 20px;
                    background: #f0f8ff
                }

                .major {
                    background: gold !important;
                    font-weight: bold;
                    color: #000 !important
                }

                table {
                    border-collapse: collapse;
                    width: 100%
                }

                th,
                td {
                    border: 1px solid #ddd;
                    padding: 8px;
                    text-align: left
                }

                th {
                    background: #4CAF50;
                    color: white
                }

                .majors-container {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 20px;
                    justify-content: center;
                    margin: 20px 0;
                }

                .major-card {
                    background: gold;
                    padding: 20px;
                    border-radius: 10px;
                    text-align: center;
                    flex: 1;
                    min-width: 250px;
                    max-width: 400px;
                }
            </style>
        </head>

        <body>
            <h1>📊 CLASSEMENT ÉLÈVES</h1>

            <!-- 🔥 MAJOR DES MAJORS EN HAUT ! -->
            <c:if test="${not empty majors}">
                <div class="majors-container">
                    <c:forEach var="major" items="${majors}">
                        <div class="major-card">
                            <h2>🥇 MAJOR ABSOLU !</h2>
                            <p><strong>${major.nom}</strong> - <strong>${major.moyenne}/20</strong></p>
                            <p><small>Filière: ${major.filiereNom} | ${major.anneeDebut}-${major.anneeFin}</small></p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <!-- MESSAGE ERREUR -->
            <c:if test="${not empty erreur}">
                <p style="color:red"> ${erreur}</p>
            </c:if>

            <!-- 🔥 TABLEAU CLASSMENT -->
            <table>
                <tr>
                    <!-- <th>Rang</th> -->
                    <th>Nom</th>
                    <th>Filière</th>
                    <th>Année</th>
                    <th>Moyenne</th>
                    <th>Redoublement</th>
                </tr>
                <c:forEach var="item" items="${resultats}" varStatus="status">
                    <tr <c:if test="${majors.stream().anyMatch(m -> m.id == item.id)}">class="major"</c:if>>
                        <td>${item.nom}</td>
                        <td>${item.filiereNom}</td>
                        <td>${item.anneeDebut}-${item.anneeFin}</td>
                        <td>${item.moyenne}</td>
                        <td>${item.redoublement}</td>
                    </tr>
                </c:forEach>
            </table>

            <!-- <p><a href="hello?nom=Alice">👋 Test EJB</a> | <a href="major.jsp">🏆 Major Seul</a></p> -->
        </body>

        </html>