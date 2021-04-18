pipeline {
    agent any
    tools {
    terraform 'terraform14'
    }
    stages {

    stage('Terraform Apply') {
    steps {
    sh '''
    make dev-init
    make dev-apply
    '''
    }
    }

    }
}