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
                script { // https://plugins.jenkins.io/ssh-steps/
                    def remote = [:]
                    remote.name = "node-1"
                    remote.host = "10.000.000.153"
                    remote.allowAnyHosts = true

                    node {
                        withCredentials([sshUserPrivateKey(credentialsId: 'aws-ec2-ubuntu-singapore', keyFileVariable: 'KEYFILE', usernameVariable: 'USER')]) {
                            remote.user = "$USER"
                            remote.identityFile = "$KEYFILE"
                            sshPut remote: remote, from: 'install-docker.sh', into: '.'
                            sshCommand remote: remote, sudo: true, command: "chmod +x install-docker.sh"
                            sshScript remote: remote, script: 'install-docker.sh'
                            sshCommand remote: remote, command: "docker pull melvincv/springbootcrudapp:${IMAGE_TAG}"
                            sshCommand remote: remote, command: "docker run --rm --name springbootapp -d -p 80:8080 melvincv/springbootcrudapp:${IMAGE_TAG}"
                        }
                    }                    
                }
            }
        }
    }
}