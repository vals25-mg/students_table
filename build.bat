@echo off
setlocal

REM ---------- CONFIG ----------
set WILDFLY_HOME=C:\wildfly-37.0.1.Final
set DEPLOY_DIR=%WILDFLY_HOME%\standalone\deployments
set WAR_NAME=eleve_major2.war

echo ========================================
echo    COMPILATION WAR + EJB - FINAL FIX
echo ========================================
echo.

REM 1. NETTOYER
if exist build rmdir /s /q build
if exist %WAR_NAME% del /f /q %WAR_NAME%
mkdir build\classes 2>nul
mkdir build\WEB-INF\classes 2>nul

REM 2. COMPILATION
echo [1/4] JAVA...
javac -cp "lib\jakarta.jakartaee-api-10.0.0.jar;lib\postgresql-42.2.6.jar;lib\jakarta.servlet-api-6.0.0.jar" -d build\classes @sources.txt
if errorlevel 1 (
    echo Erreur: compilation java a échoué.
    echo 📋 JARs disponibles:
    dir lib\*.jar
    pause
    exit /b 1
)
echo  JAVA OK

REM 3. COPIER CLASSES
xcopy "build\classes\*" "build\WEB-INF\classes\" /s /e /y >nul
echo  CLASSES OK

REM 4. COPIER WEB
xcopy "src\main\webapp\*" build\ /s /e /y >nul
echo  WEB OK

REM 5. CREER LE WAR
cd build
jar -cf ..\%WAR_NAME% *
if errorlevel 1 (
    echo Erreur: creation du WAR a echoue.
    cd ..
    pause
    exit /b 1
)
cd ..
echo  WAR OK

REM 6. COPIER VERS WILDFLY DEPLOYMENTS (cmd APPROACH)
echo.
echo [DEPLOIEMENT] Copie vers %DEPLOY_DIR% ...
if not exist "%DEPLOY_DIR%" (
    echo Erreur: repertoire de déploiement introuvable: %DEPLOY_DIR%
    pause
    exit /b 1
)

copy /Y "%WAR_NAME%" "%DEPLOY_DIR%\%WAR_NAME%" >nul
if errorlevel 1 (
    echo Erreur: impossible de copier %WAR_NAME% vers %DEPLOY_DIR%.
    echo - Possible causes: permissions requises, WildFly en cours d'utilisation par un autre processus.
    echo - Essayez d'exécuter ce script en tant qu'administrateur ou d'arrêter WildFly temporairement.
    pause
    exit /b 1
)

REM 7. CREER LE FICHIER .dodeploy POUR FORCER LE DEPLOIEMENT
echo. > "%DEPLOY_DIR%\%WAR_NAME%.dodeploy"
if errorlevel 1 (
    echo Erreur: impossible de créer le fichier .dodeploy
    pause
    exit /b 1
)

for %%F in (%WAR_NAME%) do set size=%%~zF
echo.
echo  SUCCES! %WAR_NAME% (%size% bytes) a ete copié dans %DEPLOY_DIR%
echo  Fichier de déploiement créé: %DEPLOY_DIR%\%WAR_NAME%.dodeploy
echo.
pause
endlocal
