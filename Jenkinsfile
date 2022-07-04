// Pipeline within a server hosted in Ec2
// Use Global Slack Notifier
pipeline {
    agent any

    stages {

        stage('Start'){
        when { branch 'qanew' }
            steps{
                echo "Pipeline Started"
            }
        }
        stage('Welcome Slack'){
            steps{
                slackSend channel: '#jenkins', color: 'good', message: "Build no ${env.BUILD_NUMBER}:: Build Started", tokenCredentialId: 'jenkins-integration'
            }
        }

        stage('checkout') {
            steps {
                git branch: 'qanew', credentialsId: 'ea9ebaea-0000-4a7e-800007-000000', url: 'git@gitlab.com:test/test.git'
            }
        }
        stage('git pull'){
            steps{
                sh 'ssh -o StrictHostKeyChecking=no ec2-user@000.000.000     "cd /app/webapi; \
                    git checkout qanew; \
                    git pull origin qanew; \
                " '
            }
        }
        stage('Backend Build') {
            steps {
                sh 'ssh -o StrictHostKeyChecking=no ec2-user@00.000.000.000 "cd /app/webapi; \
                    sudo npm run build:b && npm restart; \
                " '
            }
        }
        stage('Slack Frontend Msg'){
            steps{
                slackSend channel: '#jenkins', color: '#cce087', message: "Build no ${env.BUILD_NUMBER}:: Backend build completed. Do you want to build frontend? Go to the following URL and approve http://jenkins.domainname.com:8080/", tokenCredentialId: 'jenkins-integration'
            }
        }
        stage('Frontend Build'){
            input {
                message "Shall We Build Frontend as Well?"
                ok "Yes Please."
            }
            options {
              timeout(18)   // timeout on this stage
            }
            steps{
                sh 'ssh -o StrictHostKeyChecking=no ec2-user@00.000.000.000 "cd /app/webapi; \
                    sudo npm install && sudo npm run dev; \
                " '
            }
        }
        stage('Slack End Msg'){
            steps{
                slackSend channel: '#jenkins', color: '#439FE0', message: "Build no ${env.BUILD_NUMBER}:: Build Completed, Please check the Status in Jenkins", tokenCredentialId: 'jenkins-integration'
            }
        }
    }
}
