pipeline {
    timeout(60) {
        timestamps {
            node {
                checkout scm

                stage('Flutter Doctor') {
                    steps {
                        echo "Running Flutter doctor"
                        sh "flutter doctor"
                    }
                }

                stage('Test') {
                    steps {
                        echo "Running tests"
                        sh "flutter test"
                    }
                }
            }
        }
    }
}