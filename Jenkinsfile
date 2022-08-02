pipeline {
    agent any
    parameters {
        // string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter a tag for the Docker Image')
        booleanParam(name: 'DOCKER_BUILD', defaultValue: false, description: 'Build and Push to Docker Hub?')
        booleanParam(name: 'DEPLOY_PROD', defaultValue: false, description: 'Deploy to Production?')
        string(name: 'PROD_IP', defaultValue: '192.168.0.10', description: 'Enter the IP of the instance to deploy on')
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Docker Build and Push') {
            when { expression { return params.DOCKER_BUILD } }
            steps {
                script {
                    docker.withRegistry('', 'docker_hub_login') {
                        def app=docker.build("melvincv/springbootcrudapp")
                        app.push()
                    }
                }
            }
        }
    } 
    post {
        unstable {
            echo 'Pipeline is unstable.'
        }
        success {
            echo 'Pipeline Succeeded!'
            archiveArtifacts artifacts: '**/target/*.jar', followSymlinks: false
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}