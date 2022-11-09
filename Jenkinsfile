pipeline{
   environment{
      registry = 'jasser/achat'
      registryCredential= 'dockerId'
      dockerImage = ''
   }

   agent any
   stages{
      stage ('Pulling Git'){
         steps{
            echo 'Pulling...';
               git branch: 'main',
               url : 'https://github.com/Ahmed-Zarrad/achat',
               credentialsId: '01';
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
         withSonarQubeEnv(installationName: 'sonar'){
            sh "mvn sonar:sonar"
            }
         }
      }

      stage ('nexusdeploy'){
  steps{
			nexusArtifactUploader artifacts: [[artifactId: 'achat', classifier: 'debug', file: 'target/achat-1.0.jar', type: 'jar']], credentialsId: 'nexus', groupId: 'tn.esprit.rh', nexusUrl: '192.168.1.18:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-releases', version: '1.0'
			}
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
