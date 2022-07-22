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
        stage ('Docker pull: EC2 SSH') {
            steps{
                withCredentials([usernamePassword(credentialsId: 'aws-ec2-ubuntu-singapore', usernameVariable: 'USER', passwordVariable: 'PWD')]){
                    sh "sshpass -p $PWD -v ssh -o StrictHostKeyChecking=no $USER@$PROD_IP \"echo LoggedIN\""
                    echo "I have successfully logged in,Lets Deploy"
                    sh "sshpass -p $PWD -v ssh -o StrictHostKeyChecking=no $USER@$PROD_IP \"docker pull melvincv/springbootcrudapp\"" 
                }
            }
        }
    }
}