pipeline {
    environment {
      branchname =  env.BRANCH_NAME.toLowerCase()
      kubeconfig = getKubeconf(env.branchname)
      registryCredential = 'jenkins_registry'
    }
  
    agent {
      node { label 'AGENT-NODES' }
    }

    options {
      buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
      disableConcurrentBuilds()
      skipDefaultCheckout()
    }
  
    stages {

        stage('CheckOut') {            
            steps { checkout scm }            
        }

      stage('Build') {when { anyOf {  branch 'master'; branch 'main'; branch 'development'; branch 'release'; branch 'release-r2'; } }
        steps {
          withCredentials([ file(credentialsId: "simulador-prova-serap-front-environment-${branchname}", variable: 'ENVS')]) {
            script {
              def environment = sh(script: 'echo $ENVIRON', returnStdout: true).trim()
              sh 'if [ -d "envs" ]; then rm -f envs; fi'
              sh 'mv ${ENVS} .env && . $(realpath .env)'
              imagename1 = "registry.sme.prefeitura.sp.gov.br/${env.branchname}/sme-simulador-prova-serap-front"
              dockerImage1 = docker.build(imagename1, " --build-arg ENVIRONMENT=${environment} -f Dockerfile .")
              docker.withRegistry( 'https://registry.sme.prefeitura.sp.gov.br', registryCredential ) {
                dockerImage1.push()
              }
              sh "docker rmi $imagename1"
            }

          }
        }
      }
        
        stage('Deploy'){
            when { anyOf {  branch 'master'; branch 'main'; branch 'development'; branch 'release'; branch 'homolog';  } }        
            steps {
                script{
                    withCredentials([file(credentialsId: "${kubeconfig}", variable: 'config')]){
                        sh('if [ -f '+"$home"+'/.kube/config ];then rm -f '+"$home"+'/.kube/config; fi')
                        sh('cp $config '+"$home"+'/.kube/config')
                        sh 'kubectl rollout restart deployment/sme-simulador-prova-serap-front -n sme-serap-estudante'
                        sh('rm -f '+"$home"+'/.kube/config')
                    }
                }
            }           
        }    
    }

    post {
      always { 
        sh('if [ -f '+"$home"+'/.kube/config ];then rm -f '+"$home"+'/.kube/config; fi')
        sh('if [ -f .env ];then rm -f .env; fi')
      }
    }
}

def getKubeconf(branchName) {
    if("main".equals(branchName)) { return "config_prd"; }
    else if ("master".equals(branchName)) { return "config_prd"; }
    else if ("homolog".equals(branchName)) { return "config_hom"; }
    else if ("release".equals(branchName)) { return "config_hom"; }
    else if ("development".equals(branchName)) { return "config_dev"; }  
}