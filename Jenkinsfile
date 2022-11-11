pipeline{
   environment{
      registry = 'jasserismail/achat'
      registryCredential= 'dockerID'
      dockerImage = ''
   }

   agent any
   stages{
      stage ('Pulling Git'){
         steps{
            echo 'Pulling...';
               git branch: 'main',
               url : 'https://github.com/jasserismail/Devops',
               credentialsId: 'GitID';
         }
      }


      stage ("maven clean"){
         steps{
            sh "mvn clean"
         }

      }

      stage ('creation livrable'){
         steps{
            sh "mvn package -Dmaven.test.skip=true"
         }
      }

      stage ('maven test'){
         steps{
            sh "mvn test"
         }
      }

      stage ('Sonarqube'){
         steps{
         withSonarQubeEnv('jassersonar'){
            sh "mvn sonar:sonar"
            }
         }
      }

      stage ('nexusdeploy'){
  steps{
		sh " maven deploy "			}
		}

      stage('build image'){
         steps{
            script{
               dockerImage= docker.build registry + ":$BUILD_NUMBER"
            }
         }
      }

      stage('deploiment docker'){
         steps{
            script{
               docker.withRegistry( '', registryCredential){
                  dockerImage.push()
               }
            }
         }
      }

      stage('clean'){
         steps{
            sh "docker rmi $registry:$BUILD_NUMBER"
         }
      }
}

   post{
      success{
         emailext body: 'Build success', subject: 'Jenkins',
to:'jasser.ismail@esprit.tn'
      }
      failure{
         emailext body: 'Build failure', subject: 'Jenkins',
to:'jasser.ismail@esprit.tn'
      }
   }
}
