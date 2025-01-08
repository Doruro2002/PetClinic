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
                echo '##########################\nGetting code from GitHub\n#########################'
                git branch: 'main', url: 'https://github.com/Doruro2002/PetClinic.git'
            }
        }
        stage('Compile') {
            steps {
                echo '##########################\nGetting code from GitHub\n#########################'
                bat 'mvn compile'
            }
        }
        stage('Unit Test') {
            steps {
                echo '##########################\nGetting code from GitHub\n#########################'
                bat 'mvn test -DskipTests=true'
            }
        }
        stage('Build') {
            steps {
                echo '##########################\nGetting code from GitHub\n#########################'
                bat 'mvn clean install'
            }
        }
        stage('OWASP Dependency Check') {
            steps {
                echo '##########################\nGetting code from GitHub\n#########################'
                dependencyCheck additionalArguments: '--scan target/', odcInstallation: 'Dependency Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo '##########################\nGetting code from GitHub\n#########################'
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
