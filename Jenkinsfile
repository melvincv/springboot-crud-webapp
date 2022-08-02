pipeline {
    agent any
    parameters {
        // string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter a tag for the Docker Image')
        booleanParam(name: 'DEPLOY_PROD', defaultValue: false, description: 'Deploy to Production?')
        string(name: 'PROD_IP', defaultValue: '192.168.0.10', description: 'Enter the IP of the instance to deploy on')
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Docker Build and Push') {
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
                        sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"sudo apt install -y p7zip-full\"'
                        sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"if [ ! -e "app" ]; then mkdir app >&2; else echo 'Folder exists'; fi\"'
                        sh 'scp -o StrictHostKeyChecking=no -i ${KEYFILE} deploy.7z $USER@${PROD_IP}:~/app'
                        sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"cd app; 7z x -p${ZIP_PASS} ~/app/deploy.7z\"'
                        sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} $USER@${PROD_IP} \"pwd; ls -l\"'
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