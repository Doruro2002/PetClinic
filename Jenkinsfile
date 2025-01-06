pipeline {
    agent {
        label 'Saif'
    }
    tools {
        jdk 'jdk-17'
        maven 'maven'
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        SONAR_HOST_URL = 'http://localhost:9000'
        SONAR_AUTH_TOKEN = credentials('token-sonar')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Doruro2002/PetClinic.git'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean install'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    bat """\"${SCANNER_HOME}\\bin\\sonar-scanner.bat\" ^
                    -Dsonar.projectKey=Ems-CRUD ^
                    -Dsonar.sources=. ^
                    -Dsonar.java.binaries=. ^
                    -Dsonar.host.url=${SONAR_HOST_URL} ^
                    -Dsonar.login=${SONAR_AUTH_TOKEN}"""
                }
            }
        }
    }
}
