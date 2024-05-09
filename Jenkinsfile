pipeline {
    agent {
        label 'private-ec2-slave'
    }
    environment {
        DOCKER_IMAGE = 'nodejs_app'
        RDS_HOSTNAME = credentials('rds_hostname')
        RDS_USERNAME = credentials('rds_username')
        RDS_PASSWORD = credentials('rds_password')
        RDS_PORT = credentials('rds_port')
        REDIS_HOSTNAME = credentials('redis_hostname')
        REDIS_PORT = credentials('redis_port')
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'rds_redis', url: 'https://github.com/mahmoud254/jenkins_nodejs_example.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 3000:3000 --env RDS_HOSTNAME --env RDS_USERNAME --env RDS_PASSWORD --env RDS_PORT --env REDIS_HOSTNAME --env REDIS_PORT $DOCKER_IMAGE'
            }
        }
    }
}
