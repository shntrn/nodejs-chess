pipeline {
    agent any
    stages {
        stage ("Install modules & build") {
            steps {
                nodejs('Node-11') {
                    sh 'npm install phantomjs-prebuilt@2.1.13 --ignore-scripts'
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
    }
}
