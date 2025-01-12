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
        DOCKER_CREDENTIAL_ID = 'docker-token'
    }
    stages {
        stage('Checkout Code') {
            steps {
                echo '##########################\nGetting code from GitHub\n#########################'
                git branch: 'main', url: 'https://github.com/Doruro2002/PetClinic.git'
            }
        }
        // stage('Compile') {
        //     steps {
        //         echo '##########################\nCompilation de code\n#########################'
        //         bat 'mvn compile'
        //     }
        // }
        // stage('Unit Test') {
        //     steps {
        //         echo '##########################\nUnit Test Check\n#########################'
        //         bat 'mvn test -DskipTests=true'
        //     }
        // }
        // stage('OWASP Dependency Check') {
        //     steps {
        //         echo '##########################\nOWASP D-Check Stage\n#########################'
        //         dependencyCheck additionalArguments: '--scan target/', odcInstallation: 'Dependency Check'
        //         dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
        //     }
        // }
        // stage('SonarQube Analysis') {
        //     steps {
        //         echo '##########################\nSonarQube Analysis Stage\n#########################'
        //         withSonarQubeEnv('sonar-server') {
        //             bat """\"${SCANNER_HOME}\\bin\\sonar-scanner.bat\" ^
        //             -Dsonar.projectKey=Ems-CRUD ^
        //             -Dsonar.sources=. ^
        //             -Dsonar.java.binaries=. ^
        //             -Dsonar.host.url=${SONAR_HOST_URL} ^
        //             -Dsonar.login=${SONAR_AUTH_TOKEN}"""
        //         }
        //     }
        // }
        // stage('Build') {
        //     steps {
        //         echo '##########################\nBuild Stage \n#########################'
        //         bat 'mvn clean install'
        //     }
        // }
        stage('Build and Tag Docker Image') {
            steps {
                echo '##########################\nBuild and Tag Docker Image Stage\n#########################'
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIAL_ID) {
                        bat "docker build -t petclinic-image:tag -f Dockerfile ."
                    }
                }
            }
        }
        stage('Trivy Image Scan') {
            steps {
                echo '##########################\nTrivy Image Scan Stage\n#########################'
                bat "trivy image petclinic-image:tag > trivy-report.txt"
                echo 'Trivy scan completed. Report saved as trivy-report.txt'
            }
        }
        stage('Push Docker Image') {
            steps {
                echo '##########################\nPush Docker Image Stage\n#########################'
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIAL_ID) {
                        bat "docker push saifhamdi/petclinic-image:latest"
                    }
                }
            }
        }
    }
}
