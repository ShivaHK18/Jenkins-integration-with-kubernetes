pipeline {
    agent any
    
    tools {
        maven 'maven'
    }

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        DOCKER_IMAGE_NAME = 'shivaraja385/webkube'     
    }

    stages {

      stage('Checkout') {
          steps {
              script {
                    git branch: 'main', credentialsId: 'github-credentials', url: 'https://github.com/ShivaHK18/Jenkins-integration-with-kubernetes.git'
              }
          }
      }

      stage('Build') {
          steps {
              script {
                  // Clean and package the application using Maven
                  sh 'mvn clean package'
              }
          }
      }  

      stage('Build Docker Image') {
          steps {
              script {
                  // Build Docker image
                  sh "docker build -t ${DOCKER_IMAGE_NAME}:latest ."
              }
          }
      }

      stage('Push Docker Image') {
          steps {
              script {
                  // Login to DockerHub
                  withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                  sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                  }
                    
                  // Push Docker image to DockerHub
                  sh "docker push ${DOCKER_IMAGE_NAME}:latest"
              }
          }
      }

      stage('Deploy to Kubernetes') {
          steps {
            script {
                kubernetesDeploy(configs: "Jenkins-integration-with-kubernetes/deploymentservice.yml", kubeconfigId: "kubernetes")
            }
          }        	
      }
	}
}
