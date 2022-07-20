def HOST='18.136.105.231'
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
            withCredentials([sshUserPrivateKey(credentialsId: 'aws-ec2-ubuntu-singapore', keyFileVariable: 'keyfile', usernameVariable: 'USER')]) {
                stage('deploy to ec2') {
                    sh '''#!/bin/bash
                    ssh -i ${keyfile} $USER@${HOST} 
                    sudo su
                    curl -fsSL https://get.docker.com -o get-docker.sh
                    sh get-docker.sh
                    docker pull melvincv/springbootcrudapp
                    docker run --name springbootcrudapp -d -p 80:8080 melvincv/springbootcrudapp'''
                }
            }
        }
    }
}