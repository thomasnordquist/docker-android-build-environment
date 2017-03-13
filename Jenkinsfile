node {
  stage('build') {
    checkout scm
    sh "docker build --tag=thomasnordquist/docker-android-build-environment ."
  }
}
