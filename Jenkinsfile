pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                script {
                    app=docker.build("melvincv/springbootcrudapp")
                }
            }
        }
        stage('Deploy Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com','docker_hub_login'){
                        app.push("latest")
                    }
                }
            }
        }
    }
}