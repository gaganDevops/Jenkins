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
                echo "Application Selected : ${params.APPLICATION}"
            }
        }

        stage('Checkout Application') {
            steps {
                script {

                    def repoUrl = ""

                    switch(params.APPLICATION) {

                        case "Retail":
                            repoUrl = "https://github.com/gaganDevops/HiGagan.git"
                            break

                        case "Corporate":
                            repoUrl = "https://github.com/gaganDevops/corporate.git"
                            break

                        default:
                            error("Invalid Application")
                    }

                    dir("application") {
                        git branch: "main", url: repoUrl
                    }
                }
            }
        }

        stage('Build') {
            steps {
                dir("application/hello-webapp") {
                    sh "mvn clean package"
                }
            }
        }

        stage('Deploy') {
            steps {
                sh "chmod +x scripts/deploy.sh"
                sh "./deploy.sh ${params.APPLICATION}"
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
