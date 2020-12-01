#!/usr/bin/env groovy

pipeline { 

      environment { 
        REGISTRY_ADDRESS = "gcr.io/evident-theory-282613/prototype" 
        REGISTRY_AUTH = credentials("gcp-cred") 
        IMAGE = "gcr.io/evident-theory-282613/prototype"
        VERSION = ":$BUILD_NUMBER"
    }

    agent any

    stages { 

        stage('Cloning our Git') { 
            steps { 
                  sh """
                git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
                git fetch --all
              """
                  git branch: 'master',
                      //credentialsId: 'my_cred_id',
                      url: 'https://github.com/GurpreetSingh89/Cayley_modified.git'

                  sh "ls -lat"
                git 'https://github.com/GurpreetSingh89/Cayley_modified.git' 
            }
        } 

        stage('Building and publishing our image') { 
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
