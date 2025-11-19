@echo off
setlocal enabledelayedexpansion

:: -----------------------------
:: Configuration
:: -----------------------------
set APP_NAME=TestFramework
set SRC_DIR=src\test
set WEB_DIR=WebContent
set BUILD_DIR=build
set LIB_DIR=lib
set TOMCAT_WEBAPPS=C:\apache-tomcat-10.1.28\webapps
set SERVLET_API_JAR=lib\jakarta-servlet-api-6.0.0.jar

:: -----------------------------
:: Construction du classpath
:: -----------------------------
set CLASSPATH=
for %%f in (%LIB_DIR%\*.jar) do (
    set CLASSPATH=!CLASSPATH!%%f;
)
set CLASSPATH=!CLASSPATH!%SERVLET_API_JAR%

:: -----------------------------
:: Nettoyage et création des répertoires
:: -----------------------------
if exist %BUILD_DIR% rmdir /s /q %BUILD_DIR%
mkdir %BUILD_DIR%\WEB-INF\classes
mkdir %BUILD_DIR%\WEB-INF\lib

:: -----------------------------
:: Compilation des fichiers Java
:: -----------------------------
echo Compilation des fichiers Java...
dir /s /b %SRC_DIR%\*.java > sources.txt
javac -cp "!CLASSPATH!" -d %BUILD_DIR%\WEB-INF\classes @sources.txt
del sources.txt

:: -----------------------------
:: Copier les fichiers web (web.xml, JSP, etc.)
:: -----------------------------
echo Copie des fichiers web...
xcopy %WEB_DIR% %BUILD_DIR% /E /I /Y

:: -----------------------------
:: Copier les librairies du projet dans WEB-INF/lib
:: -----------------------------
echo Copie des librairies...
copy %LIB_DIR%\*.jar %BUILD_DIR%\WEB-INF\lib\

:: -----------------------------
:: Générer le fichier .war
:: -----------------------------
echo Creation du fichier WAR...
cd %BUILD_DIR%
jar -cvf %APP_NAME%.war *
cd ..

:: -----------------------------
:: Déployer sur Tomcat
:: -----------------------------
echo Deploiement sur Tomcat...
copy %BUILD_DIR%\%APP_NAME%.war %TOMCAT_WEBAPPS%\
echo Deploiement termine : %TOMCAT_WEBAPPS%\%APP_NAME%.war

endlocal
pause
