@echo off
set PROJECT_PATH=%~dp0
set BUILD_PATH="%PROJECT_PATH%build"
set WEBAPP_PATH="%PROJECT_PATH%src\main\webapp"
set CATALINA_HOME="C:\apache-tomcat-10.1.28"
set LIB_PATH="%PROJECT_PATH%lib"

rem Vérifier si le dossier "build" existe et le supprimer
if exist %BUILD_PATH% (
    echo Suppression du dossier build...
    rmdir /s /q %BUILD_PATH%
)

rem Créer la structure de dossiers
echo Création de la structure des dossiers...
mkdir %BUILD_PATH%
mkdir %BUILD_PATH%\WEB-INF
mkdir %BUILD_PATH%\WEB-INF\classes

rem Compilation des fichiers .java et sortie dans le répertoire classes
echo Compilation des fichiers Java...
for /R "%PROJECT_PATH%src\main\java" %%f in (*.java) do (
javac -d %BUILD_PATH%\WEB-INF\classes -classpath %LIB_PATH%\jakarta.servlet-api.jar;%LIB_PATH%\* %%f
)

rem Copier le contenu de webapp dans build de manière récursive
echo Copie récursive des fichiers webapp...
xcopy %WEBAPP_PATH% %BUILD_PATH% /S /Y

rem Copier les jars de lib vers build/WEB-INF/lib
echo Copie des jars de lib...
if not exist %BUILD_PATH%\WEB-INF\lib mkdir %BUILD_PATH%\WEB-INF\lib
xcopy %LIB_PATH% %BUILD_PATH%\WEB-INF\lib /Y

rem Créer le fichier .war de ce qui se trouve dans build
echo Création du fichier WAR...
cd %BUILD_PATH%
jar -cvf HelloServlet.war *

rem Déplacer le fichier .war dans le répertoire webapps de Tomcat
echo Déploiement du fichier WAR dans Tomcat...
move %BUILD_PATH%\HelloServlet.war %CATALINA_HOME%\webapps

echo Projet Servlet déployé et Tomcat prêt à démarrer.
pause
