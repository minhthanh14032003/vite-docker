pipeline {
  agent any
  environment {
        DOCKER_IMAGE = 'minhthanh14032003/vite-docker:latest'  // Tên Docker image bạn muốn tạo
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')  // Thông tin đăng nhập Docker Hub
  }
  stages {
    stage ('Clone...') {
      steps {
        git branch: 'develop', url: 'https://github.com/minhthanh14032003/vite-docker'
      }
    }
    stage('Build Docker Image') {
      steps {
          script {
            def commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()  // Lấy commit hash
            sh "docker build -t ${DOCKER_IMAGE}:${commitHash} ."  // Build Docker image
            sh "docker tag ${DOCKER_IMAGE}:${commitHash} ${DOCKER_IMAGE}:latest"  // Tag Docker image với 'latest'
          }
      }
    }
  }
}