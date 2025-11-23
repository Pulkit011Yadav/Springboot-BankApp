pipeline{
    agent {label 'dev'}
    environment {
        TAG = "latest"
    }
    stages{
        stage("code clone"){
            steps{
                git url : "https://github.com/Pulkit011Yadav/Springboot-BankApp.git" , branch: "DevOps"
            }
        }
        stage("load env"){
            steps{
                script{
                    def props = readProperties file: '.env'
                    env.DUSER = props.DUSER
                    env.IMAGE = props.IMAGE
                }
            }
        }
        stage("docker build"){
            steps{
                sh "docker build -t ${IMAGE}:${TAG} ."
            }
        }
        stage("push to DockerHUB"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub_creds', usernameVariable: 'U', passwordVariable: 'P')]) {
                    sh "echo \"$P\" | docker login -u \"$U\" --password-stdin"
                    sh "docker tag ${IMAGE}:${TAG} $U/${IMAGE}:${TAG}"
                    sh "docker push $U/${IMAGE}:${TAG}"
                    sh "docker logout"
                }
            }
        }
        stage("docker pull"){
            steps{
                sh "docker pull ${DUSER}/${IMAGE}:${TAG}"
            }
        }
        stage("deploy"){
            steps{
                sh "docker compose down || true"
                sh "docker compose up -d --force-recreate"
            }
        }
    }
}
