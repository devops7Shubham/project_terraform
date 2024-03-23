pipeline {
    agent any
    environment{
        AWS_ACCESS_KEY_ID=credentials('aws_credentials')
        AWS_SECRET_ACCESS_KEY=credentials('aws_credentials')
    }
    parameters{
        booleanParam(defaultValue: false, description: 'Apply Terraform changes', name: 'APPLY')
        booleanParam(defaultValue: false, description: 'Destroy Terraform changes', name: 'DESTROY')
    }

    stages {
        stage('Git checkout') {
            steps {
                script {
                    checkout([$class: 'GitSCM',
                        branches: [[name: '*/main']], 
                        extensions: [], 
                        userRemoteConfigs: [[url: 'https://github.com/devops7Shubham/project_terraform.git']]
                    ])
                }
            }
        }

        stage("Terraform init") {
            steps {
                script {
                    sh 'terraform init -reconfigure'
                }
            }
        }

        stage("Terraform plan") {
            steps {
                script {
                    sh 'terraform plan'
                }
            }
        }

        stage("Terraform apply or destroy") {
            steps {
                script {
                    if(params.APPLY){
                        sh 'terraform apply -auto-approve'
                    }
                    else if(params.DESTROY){
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}
