@echo off
echo ========================================
echo     EJB XML JAKARTA EE 10 - CORRIGÉ !
echo ========================================

REM COPIER EJB XML CORRIGÉ
copy src\main\webapp\WEB-INF\ejb-jar.xml build\WEB-INF\ejb-jar.xml

.\build.bat
Copy-Item eleve_major2.war "C:\wildfly-37.0.1.Final\standalone\deployments\"
echo ✅ EJB XML OK ! http://localhost:8080/eleve_major2/
pause