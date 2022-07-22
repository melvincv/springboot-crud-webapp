pipeline {
    agent any
    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter a tag for the Docker Image')
        string(name: 'EC2_HOST', defaultValue: '18.142.227.13', description: 'Enter the IP of the instance to deploy on')
    }
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
                        app.push("$IMAGE_TAG")
                    }
                }
            }
        }
    }
}