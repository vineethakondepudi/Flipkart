pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
        IMAGE_NAME = 'vineethakondepudi/flipkart'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build React App') {
            steps {
                dir('frontend') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                sh """
                docker stop flipkart-container || true
                docker rm flipkart-container || true
                docker run -d --name flipkart-container -p 3000:80 ${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }
    }  // <-- closes stages

    post {
        always {
            sh 'docker logout'
        }
    }
}
