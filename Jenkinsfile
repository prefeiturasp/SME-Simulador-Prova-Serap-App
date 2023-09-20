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
            steps { 
              checkout scm 
              script {
                APP_VERSION = sh(returnStdout: true, script: "cat pubspec.yaml | grep version: | awk '{print \$2}'") .trim()
                sh("echo ${APP_VERSION}")
                sh("echo ${BUILD_NUMBER}")
              }
            }            
        }

      stage('Build Dev') {when { anyOf {  branch 'develop'; } }
        steps {
          withCredentials([ file(credentialsId: "simulador-prova-serap-front-environment-${branchname}", variable: 'ENVS')]) {
            script {
              sh 'if [ -d "envs" ]; then rm -f envs; fi'
              sh 'cp ${ENVS} .env'
              sh 'if [ -d "envs" ]; then rm -f envs; fi'
              imagename1 = "registry.sme.prefeitura.sp.gov.br/${env.branchname}/sme-simulador-prova-serap-front"
              dockerImage1 = docker.build(imagename1, " --build-arg ENVIRONMENT=development --build-arg APP_VERSION=${APP_VERSION} --build-arg BUILD_NUMBER=${BUILD_NUMBER} -f Dockerfile .")
              docker.withRegistry( 'https://registry.sme.prefeitura.sp.gov.br', registryCredential ) {
              dockerImage1.push()
              }
              sh "docker rmi $imagename1"
            }
          }
        }
      }

      stage('Build Hom') {when { anyOf {  branch 'release'; } }
        steps {
          withCredentials([ file(credentialsId: "simulador-prova-serap-front-environment-${branchname}", variable: 'ENVS')]) {
            script {
              sh 'if [ -d "envs" ]; then rm -f envs; fi'
              sh 'cp ${ENVS} .env'
              sh 'if [ -d "envs" ]; then rm -f envs; fi'
              imagename1 = "registry.sme.prefeitura.sp.gov.br/${env.branchname}/sme-simulador-prova-serap-front"
              dockerImage1 = docker.build(imagename1, " --build-arg ENVIRONMENT=staging --build-arg APP_VERSION=${APP_VERSION} --build-arg BUILD_NUMBER=${BUILD_NUMBER} -f Dockerfile .")
              docker.withRegistry( 'https://registry.sme.prefeitura.sp.gov.br', registryCredential ) {
              dockerImage1.push()
              }
              sh "docker rmi $imagename1"
            }
          }
        }
      }

        stage('Build Prod') {when { anyOf {  branch 'master'; } }
        steps {
          withCredentials([ file(credentialsId: "simulador-prova-serap-front-environment-${branchname}", variable: 'ENVS')]) {
            script {
              sh 'if [ -d "envs" ]; then rm -f envs; fi'
              sh 'cp ${ENVS} .env'
              sh 'if [ -d "envs" ]; then rm -f envs; fi'
              imagename1 = "registry.sme.prefeitura.sp.gov.br/${env.branchname}/sme-simulador-prova-serap-front"
              dockerImage1 = docker.build(imagename1, " --build-arg ENVIRONMENT=production --build-arg APP_VERSION=${APP_VERSION} --build-arg BUILD_NUMBER=${BUILD_NUMBER} -f Dockerfile .")
              docker.withRegistry( 'https://registry.sme.prefeitura.sp.gov.br', registryCredential ) {
              dockerImage1.push()
              }
              sh "docker rmi $imagename1"
            }
          }
        }
      }
        
        stage('Deploy'){
            when { anyOf {  branch 'master'; branch 'main'; branch 'develop'; branch 'release'; branch 'homolog';  } }        
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
        sh 'if [ -d "envs" ]; then rm -f envs; fi'
        sh('if [ -f .env ];then rm -f .env; fi')
      }
    }
}

def getKubeconf(branchName) {
    if("main".equals(branchName)) { return "config_prd"; }
    else if ("master".equals(branchName)) { return "config_prd"; }
    else if ("homolog".equals(branchName)) { return "config_hom"; }
    else if ("release".equals(branchName)) { return "config_hom"; }
    else if ("develop".equals(branchName)) { return "config_dev"; }  
}
