#!/bin/bash

set -e

APPLICATION=$1

WAR_NAME="hello-webapp.war"
WAR_FILE="application/hello-webapp/target/${WAR_NAME}"

case "$APPLICATION" in

Retail)

    HOST="15.206.243.220"
    USER="ec2-user"
    TOMCAT_HOME="/opt/tomcat"

    ;;

Corporate)

    HOST="3.109.110.41"
    USER="ec2-user"
    TOMCAT_HOME="/opt/tomcat/apache-tomcat-10.1.57"

    ;;

*)

    echo "Invalid Application"
    exit 1

    ;;

esac

echo "======================================"
echo "Application : $APPLICATION"
echo "Host        : $HOST"
echo "======================================"

echo "Checking SSH Connection..."

ssh ${USER}@${HOST} "hostname"

echo "Removing old deployment..."

ssh ${USER}@${HOST} << EOF

rm -rf ${TOMCAT_HOME}/webapps/hello-webapp
rm -f ${TOMCAT_HOME}/webapps/${WAR_NAME}

EOF

echo "Copying WAR..."

scp ${WAR_FILE} ${USER}@${HOST}:${TOMCAT_HOME}/webapps/

echo "Deployment Successful."
