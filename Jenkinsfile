pipeline {
    agent any

    tools {
        jdk 'java-11'
        maven 'maven'
    }

    stages {

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build --no-cache -t kptejaswini/travel-app:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    docker rm -f travel-c8 2>/dev/null || true
                    docker run -d --name travel-c8 -p 9010:8080 kptejaswini/travel-app:latest
                '''
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-hub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push kptejaswini/travel-app:latest'
            }
        }
    }
}
