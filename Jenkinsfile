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
                    echo "========================================"
                    echo "Application Selected : ${params.APPLICATION}"
                    echo "========================================"
                }
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
                            error("Invalid Application Selected")
                    }

                    echo "Repository : ${repoUrl}"

                    git(
                        branch: 'main',
                        url: repoUrl
                    )
                }
            }
        }

        stage('Build') {
            steps {
                dir('hello-webapp') {
                    sh '''
                        pwd
                        ls -ltr
                        mvn clean package
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploy stage will be implemented in the next phase."
            }
        }
    }

    post {

        always {
            echo "Pipeline execution completed."
        }

        success {
            echo "SUCCESS"
        }

        failure {
            echo "FAILURE"
        }
    }
}
