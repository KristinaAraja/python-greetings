pipeline {
    agent any
    triggers {
        pollSCM('*/1 * * * *')
    }
    stages {
        stage('build-docker-image') {
            steps {
                buildImage()
            }
        }
        stage('deploy-to-dev') {
            steps {
                deploy("dev")
            }
        }
        stage('tests-on-dev') {
            steps {
                runApiTests("dev")
            }
        }
        stage('deploy-to-stg') {
            steps {
                deploy("stg")
            }
        }
        stage('tests-on-stg') {
            steps {
                runApiTests("stg")
            }
        }
        stage('deploy-to-prod') {
            steps {
                deploy("prod")
            }
        }
        stage('tests-on-prod') {
            steps {
                runApiTests("prod")
            }
        }
    }
}
def buildImage(){
    echo "Building docker image....."
    sh 'docker build -t kristinaaraja/python-greetings-app:latest .'

    echo "Pushing image for docker registry.."
    sh 'docker push kristinaaraja/python-greetings-app:latest'
}

def deploy(String environment){
    echo "Deploying Python microservice to ${environment} environment.."
    sh "docker compose stop greetings-app-${environment}"
    sh "docker compose rm greetings-app-${environment}"
    sh "docker compose up -d greetings-app-${environment}"
}

def runApiTests(String environment){
    echo "Running API tests triggered on ${environment} environment.."
    sh "docker pull kristinaaraja/api-tests:latest"
    sh "docker run --network=host --rm kristinaaraja/api-tests:latest run greetings greetings_${environment}"
}