pipeline {
    agent any
    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter a tag for the Docker Image')
        string(name: 'EC2_HOST', defaultValue: 'null', description: 'Enter the IP of the instance to deploy on')
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
        stage('Deploy to EC2') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'aws-ec2-ubuntu-singapore', keyFileVariable: 'keyfile', usernameVariable: 'USER')]) {
                        sh '''ssh -t -i ${keyfile} $USER@${EC2_HOST} \'curl -fsSL https://get.docker.com -o get-docker.sh\'
                            ssh -t -i ${keyfile} $USER@${EC2_HOST} \'sh get-docker.sh\'
                            ssh -t -i ${keyfile} $USER@${EC2_HOST} \'docker pull melvincv/springbootcrudapp\'
                            ssh -t -i ${keyfile} $USER@${EC2_HOST} \'docker run --name springbootcrudapp -d -p 80:8080 melvincv/springbootcrudapp\''''
                    }
                }
            }
        }
    }
}