#!/bin/bash

# -----------------------------
# Configuration
# -----------------------------
APP_NAME="TestFramework"
SRC_DIR="src/test"                 # sources Java du projet test
WEB_DIR="WebContent"
BUILD_DIR="build"
LIB_DIR="lib"                      # contiendra les JARs nécessaires à la compilation (ex: mon-framework.jar)
TOMCAT_WEBAPPS="/home/miaritsoa/ITU/webDynamique/apache-tomcat-10.1.28/webapps"
SERVLET_API_JAR="lib/jakarta-servlet-api-6.0.0.jar"  # pour compilation seulement

# -----------------------------
# Construction du classpath
# -----------------------------
CLASSPATH=$(find ${LIB_DIR} -name "*.jar" | tr '\n' ':')
CLASSPATH="${CLASSPATH}${SERVLET_API_JAR}"

# -----------------------------
# Nettoyage et création des répertoires
# -----------------------------
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}/WEB-INF/classes
mkdir -p ${BUILD_DIR}/WEB-INF/lib

# -----------------------------
# Compilation des fichiers Java
# -----------------------------
find ${SRC_DIR} -name "*.java" > sources.txt
javac -cp "${CLASSPATH}" -d ${BUILD_DIR}/WEB-INF/classes @sources.txt
rm sources.txt

# -----------------------------
# Copier les fichiers web (web.xml, JSP, etc.)
# -----------------------------
cp -r ${WEB_DIR}/* ${BUILD_DIR}/

# -----------------------------
# Copier les librairies du projet (ex: framework.jar) dans WEB-INF/lib
# -----------------------------
for jar in ${LIB_DIR}/*.jar; do
    cp "$jar" ${BUILD_DIR}/WEB-INF/lib/
done

# -----------------------------
# Générer le fichier .war
# -----------------------------
cd ${BUILD_DIR}
jar -cvf ${APP_NAME}.war *
cd ..

# -----------------------------
# Déployer sur Tomcat
# -----------------------------
cp ${BUILD_DIR}/${APP_NAME}.war ${TOMCAT_WEBAPPS}/
echo "Déploiement terminé : ${TOMCAT_WEBAPPS}/${APP_NAME}.war"
