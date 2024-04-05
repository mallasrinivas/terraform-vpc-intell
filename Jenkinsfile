pipeline {
    agent any
    environment {
        DOCKER_IMAGE               = 'demoapp'
        CONTAINER_NAME = 'my-container'
        git_repor ='https://github.com/Sameer-8080/Website-PRT-ORG'
     }
    stages {
         stage('Preparation') {
            steps {
                // Clean the workspace
                deleteDir()
            }
        }
         stage('Fetch Source Code') {
            steps {
                node('web-server') {
                    git branch: 'main', url: git_repor
                    echo "Code cloned successfully"
                }
            }
        }
        
        stage('Docker Login'){
            steps {
                node('web-server') {
                withCredentials([string(credentialsId: 'docker_password', variable: 'docker_password')]) {
                 sh "docker login -u mallasrinivas -p ${docker_password}"
              }
                }
            }
        
        }
        
        stage("Docker build and run container"){
            steps{
                node('web-server') {
                    script {
                        docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").run('-p 80:80 --name ' + CONTAINER_NAME)
                    }
                }
                echo "Docker build and run successfully on master branch"
            }
            }
            
     }
}