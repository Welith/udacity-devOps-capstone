pipeline {
    environment {
        eksClusterName = 'capstone-Cluster'
        eksRegion = 'us-west-2'
        dockerHub = 'welith95'
        dockerImage = 'capstone'
    }
    agent any
    stages {
        stage('Lint the app index and the Dockerfile') {
            steps {
                sh 'sudo gpasswd -a jenkins docker'
                sh 'tidy -q -e **/*.html'
                sh '''sudo docker run --rm -i hadolint/hadolint < Dockerfile'''
            }
        }
        stage('Build Docker') {
            steps {
                script {
                    sh 'sudo docker build -t ${dockerHub}/${dockerImage} .'
                    withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'docker-credsPassword', usernameVariable: 'docker-credsUsername')]) {
                              sh "sudo docker login -u ${env.docker-credsUsername} -p ${env.docker-credsPassword}"
                              sh 'sudo docker push ${dockerHub}/${dockerImage}'
                            }
                }
            }
        }
        stage('Deploy to Kubernetes')  {
            steps {
                script {
                    withAWS(credentials: 'aws-static', region: eksRegion) {
                        sh 'aws eks --region=${eksRegion} update-kubeconfig --name ${eksClusterName}'
                        sh 'kubectl apply -f kubernetes/deploy.yml'
                    }
                }
            }
        }
    }
}