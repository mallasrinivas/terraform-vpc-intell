pipeline {
    agent any

    environment {
        Docker_registry_credentials = credentials('docker_hub_credentials')
        DOCKER_IMAGE               = 'image'
        git_repor ='https://github.com/Sameer-8080/Website-PRT-ORG'

    }
    stages {
        stage('Clone repository') {
            steps {
                git branch: 'main', url: git_repor
            }
        }
        stage('Docker Login'){
            steps {
                withCredentails([usernamePassword(credentialsId: "Docker_registry_credentials",usrename:'Docker-name',password:'docker_password'])
                sh "docker login -u ${Docker_registry_credentials_USR} -p ${Docker_registry_credentials_PSW}"
            }
            }
        stage('build'){
            steps {
                script{
                    dokcerImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }
        }
    }
}