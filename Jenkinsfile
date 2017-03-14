node {
  stage('build') {
    checkout scm
    sh "docker build --no-cache --tag=thomasnordquist/docker-android-build-environment ."
  }
}
