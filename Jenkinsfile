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
                deploy("DEV")
            }
        }
        stage('tests-on-dev') {
            steps {
                runApiTests("DEV")
            }
        }
        stage('deploy-to-stg') {
            steps {
                deploy("STG")
            }
        }
        stage('tests-on-stg') {
            steps {
                runApiTests("STG")
            }
        }
        stage('deploy-to-prod') {
            steps {
                deploy("PRD")
            }
        }
        stage('tests-on-prod') {
            steps {
                runApiTests("PRD")
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
    String lowercaseEnv = environment.toLowerCase()
    sh "docker compose stop greetings-app-${lowercaseEnv}"
    sh "docker compose rm greetings-app-${lowercaseEnv}"
    sh "docker compose up -d greetings-app-${lowercaseEnv}"
}

def runApiTests(String environment){
    echo "Running API tests triggered on ${environment} environment.."
    String lowercaseEnv = environment.toLowerCase()
    sh "docker pull kristinaaraja/api-tests:latest"
    sh "docker run --network=host --rm kristinaaraja/api-tests:latest run greetings greetings_${lowercaseEnv}"
}