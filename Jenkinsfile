pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }
  agent {
    label 'rpm'
  }
  environment {
    IMAGE_NAME      = "rpmbuild"
    TEMP_IMAGE_NAME = "rpmbuild6_${BUILD_NUMBER}"
    TAG_NAME        = "el6"
  }
  stages {
    stage('Prepare') {
      steps {
        sh 'docker pull centos:6'
      }
    }
    stage('Build') {
      steps {
        ansiColor('xterm') {
          sh 'FINAL_IMAGE_NAME="${DOCKER_PRIVATE_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}"'
          sh 'docker build --no-cache --squash --compress -t ${TEMP_IMAGE_NAME} .'
        }
      }
    }
    stage('Publish') {
      steps {
        ansiColor('xterm') {
          sh 'docker tag ${TEMP_IMAGE_NAME} ${DOCKER_PRIVATE_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}'
          sh 'docker push ${DOCKER_PRIVATE_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}'
        }
      }
    }
  }
  triggers {
    bitbucketPush()
  }
  post {
    success {
      build job: 'Docker/docker-rpmbuild-centos6/cpp11', wait: false
      build job: 'Docker/docker-rpmbuild-centos6/golang', wait: false
      build job: 'Docker/docker-rpmbuild-centos6/rust', wait: false
      juxtapose event: 'success'
      sh 'figlet "SUCCESS"'
    }
    failure {
      juxtapose event: 'failure'
      sh 'figlet "FAILURE"'
    }
    always {
      sh 'docker rmi  $TEMP_IMAGE_NAME'
    }
  }
}
