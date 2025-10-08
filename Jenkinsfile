pipeline{
    agent { label 'worker' }
    stages{
        stage("code clone"){
            steps{
                git url : "https://github.com/Pulkit011Yadav/Springboot-BankApp.git" , branch: "DevOps"
            }
        }
        stage("docker pull"){
            steps{
                sh "docker pull pulkit011yadav/springboot-bankapp:latest"
            }
        }
        stage("deploy"){
            steps{
                sh "docker compose down || true"
                sh "docker compose up -d --build"
            }
        }
    }
}
