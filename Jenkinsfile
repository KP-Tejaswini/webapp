pipeline {
    agent any

    tools {
        jdk 'java-11'
        maven 'maven'
    }

    stages {

        stage('Code Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Code Package') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t kptejaswini/project-1 .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    docker rm -f c8 2>/dev/null || true
                    docker run -d --name c8 -p 9008:8080 kptejaswini/project-1
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
                sh 'docker push kptejaswini/project-1'
            }
        }
    }
}
