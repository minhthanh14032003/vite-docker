pipeline {
    agent none
    evironment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = 'docker.io/username/image:latest'
        BRANCH_NAME = 'develop'
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Get source from develop branch'
                git branch: BRANCH_NAME, url: 'https://github.com/minhthanh14032003/vite-docker'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Build Docker Image....'
                script {
                  def commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                  sh "docker build -t ${DOCKER_IMAGE}:${commitHash} ."
                  sh "docker tag ${DOCKER_IMAGE}:${commitHash} ${DOCKER_IMAGE:latest}"
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                echo 'Push Docker Image to Docker Hub....'
                script {
                  docker.withRegistry('', DOCKER_CREDENTIALS) {
                    sh "docker push ${DOCKER_IMAGE}:${commitHash}"
                    sh "docker push ${DOCKER_IMAGE:latest}"
                  }
                }
            }
        }
    }
}