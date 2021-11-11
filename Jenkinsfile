pipeline {
  agent any

  stages{
    stage('Terraform Init') {
      steps {
        sh '''
          cd roboshop-shell-scripting
          ls
          terraform init
        '''
      }
    }
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }
}