pipeline {
    agent any
    tools {
    terraform 'terraform 14'
    }
    stages {

    stage('Terraform Apply') {
    steps {
    sh '''
    make dev
    '''
    }
    }

    }
}