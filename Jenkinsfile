pipeline {
  agent any
  environment {
        DOCKER_IMAGE = 'minhthanh14032003/vite-docker'  // Tên Docker image bạn muốn tạo
        DOCKER_CREDENTIALS = credentials('dockerhubCredentials')  // Thông tin đăng nhập Docker Hub
        DISCORD_WEBHOOK_URL = 'https://discord.com/api/webhooks/1272226738130386978/M9xIb-3URXdg7bv7XlKbN5iHJ4P351mhs-RGSvaWR9hU5WMESnfz51jsx8Oxafz03fnE'
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
          String commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
          withDockerRegistry(credentialsId: 'dockerhubCredentials', url: 'https://index.docker.io/v1/') {
            sh "docker push ${DOCKER_IMAGE}:${commitHash}"
            sh "docker push ${DOCKER_IMAGE}:latest"
          }
        }
      }
    }
    stage('Notify Discord') {
      steps {
        script {
          String commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
          def payload = """
          {
            "content": "New image has been pushed to Docker Hub: ${DOCKER_IMAGE}:${commitHash}"
          }
          """
          sh "curl -X POST -H 'Content-Type: application/json' -d '${payload}' ${DISCORD_WEBHOOK_URL}"
        }
      }
    }
  }
  post {
        success {
      echo 'Pipeline completed successfully!'
        }
        failure {
      echo 'Pipeline failed.'
      script {
        def message = 'Pipeline failed. Please check the Jenkins logs for more details.'
        def payload = """{
                    "content": "${message}"
                }"""
        sh """curl -H "Content-Type: application/json" -X POST -d '${payload}' ${DISCORD_WEBHOOK_URL}"""
      }
        }
  }
}
