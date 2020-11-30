#!/usr/bin/env groovy

pipeline { 
   
    agent any
    
    options {
        timestamps()
    }
    
   environment { 
        REGISTRY_ADDRESS = "gcr.io/evident-theory-282613/prototype" 
        REGISTRY_AUTH = credentials("gcp-cred") 
        IMAGE = "gcr.io/evident-theory-282613/prototype"
        VERSION = ":$BUILD_NUMBER"
    }
    
    stages { 
       
        stage('Cloning our Git') { 
            steps { 
                git 'https://github.com/GurpreetSingh89/Cayley_modified.git' 
            }
        } 
        
        stage('Building and publishing our image') { 
            when {
              branch 'master'  
            }
            steps { 
                
                 sh """
                  docker.registry('http://gcr.io', ${REGISTRY_AUTH})
                  docker build -t ${IMAGE} .
                  docker tag ${IMAGE} ${IMAGE}:${VERSION}
                  docker push ${IMAGE}:${VERSION}
                """
                
             //   script { 
                    //sudo chmod 666 /var/run/docker.sock
               //     dockerImage = docker.build REGISTRY_ADDRESS + ":$BUILD_NUMBER" 
               // }
            } 
        }
        
        //stage('Push your image') { 
            //steps { 
               // script { 
                    //docker.registry( 'http://gcr.io', REGISTRY_AUTH ) { 
                        //dockerImage.push() 
                    //}
                //} 
            //}
       // } 
              
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        } 
    }
}
