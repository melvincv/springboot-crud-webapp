pipeline {
    agent any
    parameters {
        // string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter a tag for the Docker Image')
        string(name: 'PROD_IP', defaultValue: '192.168.0.10', description: 'Enter the IP of the instance to deploy on')
        booleanParam(name: 'DEPLOY_PROD', defaultValue: false, description: 'Deploy to Production?')
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
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
            when { expression { return params.DEPLOY_PROD } }
            steps{
                script {
                        withCredentials([sshUserPrivateKey(credentialsId: 'aws-ec2-ubuntu-singapore', keyFileVariable: 'KEYFILE', usernameVariable: 'USER')]) {
                        sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"echo Logged in\"'
                        sh 'scp -o StrictHostKeyChecking=no -i ${KEYFILE} deploy.sh $USER@${PROD_IP}:.'
                        sh 'scp -o StrictHostKeyChecking=no -i ${KEYFILE} compose.yml $USER@${PROD_IP}:.'
                        sh 'scp -o StrictHostKeyChecking=no -i ${KEYFILE} Dockerfile $USER@${PROD_IP}:.'
                        sh 'scp -o StrictHostKeyChecking=no -i ${KEYFILE} .env $USER@${PROD_IP}:.'
                        sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"sudo bash ./deploy.sh\"'
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