pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
        IMAGE_NAME = 'vineethakondepudi/flipkart'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                dir('frontend') {
            sh 'npm install'
        }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t vineethakondepudi/flipkart:latest -f Dockerfile .'
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

      stage('Run Container') {
    steps {
        script {
            sh """
              docker stop resturent || true
              docker rm resturent || true
              docker run -d -p 8091:80 --name resturent ${IMAGE_NAME}:${IMAGE_TAG}
            """
        }
    }
}


    post {
        always {
            sh 'docker logout'
        }
    }
}

