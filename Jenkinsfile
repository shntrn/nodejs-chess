pipeline {
    agent any
    stages {
        stage ("Install modules & build") {
            steps {
                nodejs('Node-11') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
    }
}