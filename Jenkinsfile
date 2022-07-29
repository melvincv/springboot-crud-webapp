pipeline {
    agent any
    parameters {
        // string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter a tag for the Docker Image')
        string(name: 'PROD_IP', defaultValue: '18.142.227.13', description: 'Enter the IP of the instance to deploy on')
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
                        app.push("latest")
                    }
                }
            }
        }
        stage ('Deploy to EC2') {
            steps{
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'aws-ec2-ubuntu-singapore', keyFileVariable: 'KEYFILE', usernameVariable: 'USER')]) {
                    sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"echo Logged in\"'
                    sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"docker pull melvincv/springbootcrudapp\"'
                    sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"docker container prune\"'
                    sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"docker run -d -p 80:8080 melvincv/springbootcrudapp\"'
                    }
                }
            }
        }
    }
}