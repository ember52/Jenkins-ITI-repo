pipeline {
    agent { label 'aws-ec2-slave' }
    
    parameters {
        choice(
            name: 'ACTION',
            choices: ['build', 'destroy'],
            description: 'Select the action (build or destroy)'
        )
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'prod'],
            description: 'Select the environment (dev or prod)'
        )
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ember52/Jenkins-ITI-repo'
            }
        }
        
        stage('Navigate to Terraform Code Directory') {
            steps {
                script {
                    dir('Terraform_code') {
                        sh 'ls -la' // Example command to list files in Terraform_code directory
                        sh "terraform init"
                    }
                }
            }
        }
        
        stage('Validate Workspace Existence') {
            steps {
                script {
                    dir('Terraform_code') {
                        def workspaceStatus = sh(script: "terraform workspace list | grep ${params.ENVIRONMENT}", returnStatus: true)

                        if (workspaceStatus != 0) {
                            echo "Workspace '${params.ENVIRONMENT}' does not exist. Creating..."
                            sh "terraform workspace new ${params.ENVIRONMENT}"
                        }
                    }
                }
            }
        }
        
        stage('Select Workspace and Apply') {
            steps {
                script {
                    def tfvarsFile

                    // Determine the tfvars file based on selected environment
                    switch(params.ENVIRONMENT) {
                        case 'dev':
                            tfvarsFile = 'dev.tfvars'
                            break
                        case 'prod':
                            tfvarsFile = 'prod.tfvars'
                            break
                        default:
                            error "Invalid environment selected"
                    }

                    // Select Terraform workspace and run Terraform commands with selected tfvars file
                    dir('Terraform_code') {
                        sh "terraform workspace select ${params.ENVIRONMENT}"
                        sh "terraform init"
                        
                        // Perform actions based on selected action
                        switch(params.ACTION) {
                            case 'build':
                                sh "terraform plan -var-file=${tfvarsFile}"
                                sh "terraform apply -auto-approve -var-file=${tfvarsFile}"
                                break
                            case 'destroy':
                                sh "terraform destroy -var-file=${tfvarsFile}"
                                break
                            default:
                                error "Invalid action selected"
                        }
                    }
                }
            }
        }
    }
}
