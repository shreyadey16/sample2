pipeline {
    agent {label 'agent' }
	tools {
	    maven "maven"
	 	}
	 environment {
        CI = 'true'
        registry = 'docker-services-training/shreya/'
    }
	
	stages {
	    stage('Git CheckOut') {
		    steps {
			  git branch: 'main', url: 'https://github.com/shreyadey16/sample2.git'
			}
		}
         stage('Build') {
             steps {
                 script {
                     sh "mvn -B -Dmaven.test.skip=true clean package"
                     stash name: "artifact"
                 }                               
             } 
         }

        
        stage('SonarQube Analysis'){
            steps{
                script{
                    withSonarQubeEnv('sonar'){
                        sh 'ls'
                        sh 'mvn sonar:sonar -DskipTests'
                    }
                }
            }
        }
        stage('Build the image') { 
            steps { 
                script {
                    unstash name:"artifact"
                    docker.withTool('docker') {
                        docker.withRegistry('https://artifactory.dagility.com', 'shreya-registry'){
                            docker.build(registry + "maven:latest").push()
                        }
                    }
                } 
            }
         }
	}
}
