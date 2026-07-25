pipeline {

    agent any

    parameters {
        choice(
            name: 'APPLICATION',
            choices: ['Retail', 'Corporate'],
            description: 'Select Application'
        )
    }

    environment {
        REPO_URL = ""
        SERVER_IP = ""
        TOMCAT_HOME = ""
    }

    stages {

        stage('Initialize') {
            steps {
                script {

                    if (params.APPLICATION == "Retail") {

                        env.REPO_URL = "https://github.com/gaganDevops/HiGagan.git"
                        env.SERVER_IP = "15.206.243.220"
                        env.TOMCAT_HOME = "/opt/tomcat"

                    } else {

                        env.REPO_URL = "https://github.com/gaganDevops/corporate.git"
                        env.SERVER_IP = "3.109.110.41"
                        env.TOMCAT_HOME = "/opt/tomcat/apache-tomcat-10.1.57"

                    }

                    echo "Application : ${params.APPLICATION}"
                    echo "Repository  : ${env.REPO_URL}"
                    echo "Server      : ${env.SERVER_IP}"
                    echo "Tomcat Home : ${env.TOMCAT_HOME}"
                }
            }
        }

        stage('Checkout') {
            steps {

                git branch: 'main',
                    url: "${env.REPO_URL}"

            }
        }

        stage('Build') {
            steps {

                sh 'mvn clean package'

            }
        }

        stage('Deploy') {
            steps {

                sh "./scripts/deploy.sh ${params.APPLICATION}"

            }
        }
    }

    post {

        success {
            echo "Deployment Successful"
        }

        failure {
            echo "Deployment Failed"
        }

    }

}
