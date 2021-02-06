pipeline {
  agent any
  stages {
    stage('stage') {
      steps {
        sh '''
        git clone https://github.com/rohitCodeRed/sabdkosh-devOps-image.git
        pwd
        cd sabdkosh-devOps-image
        ls -al
        cd ..
        pwd
        rm -rf sabdkosh-devOps-image
        node -v
        echo "script is ended.."
        '''
      }
    }
  }
}