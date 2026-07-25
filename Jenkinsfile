pipeline {

    agent any

    parameters {
        choice(
            name: 'APPLICATION',
            choices: ['Retail', 'Corporate'],
            description: 'Select Application'
        )
    }

    stages {

        stage('Initialize') {
            steps {
                script {
                    echo "====================================="
                    echo "Application Selected : ${params.APPLICATION}"
                    echo "====================================="
                }
            }
        }

        stage('Checkout') {
            steps {
                script {

                    def repoUrl

                    if (params.APPLICATION == "Retail") {
                        repoUrl = "https://github.com/gaganDevops/HiGagan.git"
                    } else {
                        repoUrl = "https://github.com/gaganDevops/corporate.git"
                    }

                    echo "Checking out repository:"
                    echo "${repoUrl}"

                    git branch: 'main', url: repoUrl
                }
            }
        }

        stage('Build') {
            steps {
                script {

                    if (params.APPLICATION == "Retail") {

                        dir('hello-webapp') {
                            sh 'mvn clean package'
                        }

                    } else {

                        sh 'mvn clean package'

                    }

                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deployment script will be added tomorrow."
            }
        }
    }

    post {

        success {
            echo "====================================="
            echo "Pipeline Executed Successfully"
            echo "====================================="
        }

        failure {
            echo "====================================="
            echo "Pipeline Execution Failed"
            echo "====================================="
        }

    }

}
