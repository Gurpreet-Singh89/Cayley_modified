pipeline { 
    environment { 
        registry = "gcr.io/evident-theory-282613/prototype" 
        registryCredential = 'gcp-cred' 
        dockerImage = '' 
    }
    
    agent any 
    
    stages { 
        
        stage('Cloning our Git') { 
            steps { 
                git 'https://github.com/GurpreetSingh89/Cayley_modified.git' 
            }
        } 
        
        stage('Building our image') { 
            steps { 
                script { 
                    //sudo chmod 666 /var/run/docker.sock
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        
        stage('Push your image') { 
            steps { 
                script { 
                    docker.registry( 'http://gcr.io', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 
        
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        } 
    }
}
