pipeline{
   environment{
      registry = 'zarrad/achat'
      registryCredential= 'dockerId'
      dockerImage = ''
   }

   agent any
   stages{
      stage (''){
         steps{
            echo 'Pulling...';
               git branch: 'main',
               url : 'https://github.com/Ahmed-Zarrad/achat',
               credentialsId: '01';
         }
      }


      stage (""){
         steps{
            sh "mvn clean"
         }

      }

      stage (''){
         steps{
            sh "mvn package -Dmaven.test.skip=true"
         }
      }

      stage (''){
         steps{
            sh "mvn test"
         }
      }

      stage (''){
         steps{
         withSonarQubeEnv(installationName: 'sonar'){
            sh "mvn sonar:sonar"
            }
         }
      }

      stage (''){
         steps{
            sh "mvn deploy:deploy-file -DgroupId=tn.esprit.rh
-DartifactId=achat -Dversion=1.0 -DgeneratePom=true -Dpackaging=jar
-DrepositoryId=deploymentRepo
-Durl=http://192.168.1.18:8081/repository/maven-releases/
-Dfile=target/achat-1.0.jar"
         }
      }

      stage(''){
         steps{
            script{
               dockerImage= docker.build registry + ":$BUILD_NUMBER"
            }
         }
      }

      stage(''){
         steps{
            script{
               docker.withRegistry( '', registryCredential){
                  dockerImage.push()
               }
            }
         }
      }

      stage(''){
         steps{
            sh "docker rmi $registry:$BUILD_NUMBER"
         }
      }
}

   post{
      success{
         emailext body: 'Build success', subject: 'Jenkins',
to:'ahmed.zarrad@esprit.tn'
      }
      failure{
         emailext body: 'Build failure', subject: 'Jenkins',
to:'ahmed.zarrad@esprit.tn'
      }
   }
}
