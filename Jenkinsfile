pipeline {
    agent any
    parameters {
        // string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter a tag for the Docker Image')
        string(name: 'PROD_IP', defaultValue: '192.168.0.10', description: 'Enter the IP of the instance to deploy on')
        boolean()
    }
    stages {
        stage('Build and Push Image') {
            steps {
                script {
                    docker.withRegistry('', 'docker_hub_login') {
                        def app=docker.build("melvincv/springbootcrudapp")
                        app.push()
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
                    }
                }
            }
        }
    }
}