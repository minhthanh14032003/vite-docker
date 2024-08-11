pipeline {
  agent any
  environment {
        DOCKER_IMAGE = 'minhthanh14032003/vite-docker'  // Tên Docker image bạn muốn tạo
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')  // Thông tin đăng nhập Docker Hub
  }
  stages {
    stage('Clone...') {
      steps {
        git branch: 'develop', url: 'https://github.com/minhthanh14032003/vite-docker'
      }
    }
    stage('Build Docker Image') {
      steps {
          script {
            String commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()  // Lấy commit hash
            sh "sudo docker build -t ${DOCKER_IMAGE}:${commitHash} ."
            sh "sudo docker tag ${DOCKER_IMAGE}:${commitHash} ${DOCKER_IMAGE}:latest"  // Tag Docker image với 'latest'
          }
      }
    }
    stage('Push Docker Image') {
      steps {
        script {
          String commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()  // Đảm bảo khai báo lại biến commitHash nếu cần
          docker.withRegistry('', DOCKER_CREDENTIALS) {
            sh "docker push ${DOCKER_IMAGE}:${commitHash}"
            sh "docker push ${DOCKER_IMAGE}:latest"
          }
        }
      }
    }
  }
}
