pipeline {
    agent none
    stages {
        stage ("Install modules & install") {
            agent {
                label 'master'
            }
            steps {
                nodejs('Node-11') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
        stage ("Creating docker container - front end & push") {
            agent {
                label 'kubernetes'
            }
            steps {
                sh 'git clone -b master https://github.com/shntrn/nodejs-chess'
                sh  'docker build -f Dockerfile.app -t shntrn/chessapp_client .'
                sh  'docker push shntrn/chessapp_client:latest'
            }
        }

        stage ("Creating docker container - backend") {
            agent {
                label 'kubernetes'
            }
            steps {
                sh  'docker build -f Dockerfile.server -t shntrn/chessapp_server .'
                withCredenitials([string(credentialsId: 'docker_hub', variables: 'docker_hub')]) {
                    sh 'docker login -u shntrn -p ${docker_hub}'
                }
                sh  'docker push shntrn/chessapp_server:latest'
            }
        }
        stage ("Deploy client container on Kubernetes") {
            agent {
                label 'kubernetes'
            }
            steps {
                sh  'kubectl apply -f chessapp-client.yaml'
            }
        }
        stage ("Deploy server container on Kubernetes") {
            agent {
                label 'kubernetes'
            }
            steps {
                sh  'kubectl apply -f chessapp-server.yaml'
            }
        }
        stage ("Deploy DB container on Kubernetes") {
            agent {
                label 'kubernetes'
            }
            steps {
                sh  'kubectl apply -f mongo.yaml'
            }
        }
    }
}
