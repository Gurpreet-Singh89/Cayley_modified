pipeline {
  agent any
  stages {
    stage('Cloning our Git') {
      steps {
        checkout(scm: scm, poll: true)
      }
    }

    stage('Building and publishing our image') {
      steps {
        sh "'"
                          docker.registry('http://gcr.io' , ${REGISTRY_AUTH})
                          docker build -t ${IMAGE} .
                          docker tag ${IMAGE} ${IMAGE}:$BUILD_NUMBER
                          docker push ${IMAGE}:$BUILD_NUMBER
                        "'"
      }
    }

    stage('Cleaning up') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }

  }
  environment {
    REGISTRY_ADDRESS = 'gcr.io/evident-theory-282613/prototype'
    REGISTRY_AUTH = credentials('gcp-cred')
    IMAGE = 'gcr.io/evident-theory-282613/prototype'
    VERSION = ':$BUILD_NUMBER'
  }
}
