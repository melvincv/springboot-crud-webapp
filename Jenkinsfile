pipeline {
    agent any
    parameters {
        // string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter a tag for the Docker Image')
        booleanParam(name: 'DOCKER_BUILD', defaultValue: false, description: 'Build and Push to Docker Hub?')
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('test') {
            steps {
                catchError(message: 'Test Stage fails? Pipeline continues...') {
                    sh './test-db.sh'
                }
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
            echo 'Pipeline is unstable...'
        }
        success {
            echo 'Pipeline Succeeded! Archiving artifacts...'
            archiveArtifacts artifacts: '**/target/*.jar', followSymlinks: false
        }
        failure {
            echo 'Pipeline failed...'
        }
    }
}