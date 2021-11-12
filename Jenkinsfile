pipeline {
  agent {
    node {label 'Workstation-1'}
  }
  parameters {
    choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Pick an action')
  }

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
      when {
        environment name: 'ACTION', value: 'apply'
      }
      steps {
        sh '''
          cd roboshop-shell-scripting
          terraform apply -auto-approve
        '''
      }
    }


    stage('Terraform Destroy') {
      when {
        environment name: 'ACTION', value: 'destroy'
      }
      steps {
        sh '''
          cd roboshop-shell-scripting
          terraform destroy -auto-approve
        '''
      }
    }
  }
}