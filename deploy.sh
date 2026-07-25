#!/bin/bash

set -e

APPLICATION=$1

WAR_NAME="hello-webapp.war"
WAR_FILE="application/hello-webapp/target/${WAR_NAME}"

if [ ! -f "${WAR_FILE}" ]; then
    echo "ERROR: WAR file not found: ${WAR_FILE}"
    exit 1
fi

case "$APPLICATION" in

Retail)

    TOMCAT_HOME="/opt/tomcat"

    echo "======================================"
    echo "Application : Retail"
    echo "Deploying Locally"
    echo "======================================"

    echo "Removing old deployment..."
    rm -rf "${TOMCAT_HOME}/webapps/hello-webapp"
    rm -f "${TOMCAT_HOME}/webapps/${WAR_NAME}"

    echo "Copying WAR..."
    cp "${WAR_FILE}" "${TOMCAT_HOME}/webapps/"

    echo "Restarting Tomcat..."
    "${TOMCAT_HOME}/bin/shutdown.sh" || true
    sleep 5
    "${TOMCAT_HOME}/bin/startup.sh"

    echo "Retail Deployment Successful."
    ;;

Corporate)

    HOST="3.109.110.41"
    USER="ec2-user"
    TOMCAT_HOME="/opt/tomcat/apache-tomcat-10.1.57"

    echo "======================================"
    echo "Application : Corporate"
    echo "Host        : ${HOST}"
    echo "======================================"

    echo "Checking SSH Connection..."
    sudo -u ec2-user ssh ${USER}@${HOST} "hostname"

    echo "Removing old deployment..."
    sudo -u ec2-user ssh ${USER}@${HOST} << EOF
rm -rf ${TOMCAT_HOME}/webapps/hello-webapp
rm -f ${TOMCAT_HOME}/webapps/${WAR_NAME}
EOF

    echo "Copying WAR..."
    sudo -u ec2-user scp "${WAR_FILE}" ${USER}@${HOST}:${TOMCAT_HOME}/webapps/

    echo "Restarting Tomcat..."
    sudo -u ec2-user ssh ${USER}@${HOST} << EOF
${TOMCAT_HOME}/bin/shutdown.sh || true
sleep 5
${TOMCAT_HOME}/bin/startup.sh
EOF

    echo "Corporate Deployment Successful."
    ;;

*)

    echo "Usage: $0 {Retail|Corporate}"
    exit 1
    ;;

esac

echo "======================================"
echo "Deployment Completed Successfully"
echo "======================================"
