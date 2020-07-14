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
                sh 'tidy -q -e **/*.html'
                sh '''docker run --rm -i hadolint/hadolint < Dockerfile'''
            }
        }
        stage('Build Docker') {
            steps {
                script {
                    dockerImage = docker.build('${dockerHub}/${dockerImage}')
                    docker.withRegistry('', 'docker-creds') {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes')  {
            steps {
                withAWS(credentials: 'aws-static', region: eksRegion) {
                    sh 'aws eks --region=${eksRegion} update-kubeconfig --name ${eksClusterName}'
                    sh 'kubectl apply -f kubernetes/deploy.yml'
                }
            }
        }
    }
}