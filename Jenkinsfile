pipeline {
    agent any
    
    tools {
        maven "Maven"
    }
    environment {
        IMAGE_NAME = 'dzhirutin/my-repo:puzzle15-1.0'
        }

    stages {
        stage ("build puzzle15 .war") {
            steps {
                sh "mvn --version"
                sh "mvn package"
                sh "mvn compile war:war"
            }
        }
        stage ("make and push docker images") {
            steps { 
                script {
                    echo "Make docker image for DockerHub..."
                    withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'PASS', usernameVariable: 'USER')])  {
                        sh "docker build -t ${IMAGE_NAME} ."
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push ${IMAGE_NAME}"
                    }
                }
            }
        }
        stage("run docker on Prod") {
            steps {
                script {
                      def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"
                      def googleInstance = "root@35.225.28.184"
                    /*def dockerComposeCmd = "docker-compose -f docker-compose.yaml up --detach"*/
                    /*def dockerCmd = 'docker run -d -p 8083:8080 dzhirutin/my-repo:prod-1.0'*/
                     sshagent(['ec2-user-key']) {
                       sh "scp -v -o StrictHostKeyChecking=no server-cmds.sh ${googleInstance}:/root"  
                       sh "scp -v -o StrictHostKeyChecking=no docker-compose.yaml ${googleInstance}:/root"
                       sh "ssh -o StrictHostKeyChecking=no ${googleInstance} ${shellCmd}"
                    }
                 } 
            }
        }
    }
}