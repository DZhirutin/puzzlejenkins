pipeline {
    agent any

    tools {
        maven "Maven"
    }

    stages {
        stage ("build puzzle15") {
            steps {
                sh "mvn package"
                sh "mvn compile war:war"
            }
        }
    }
}