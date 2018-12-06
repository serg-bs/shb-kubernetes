pipeline{
  agent any
  parameters {
    string(name: 'SHBBACK_VERSION',
    defaultvalue: 'latest',
    description: 'SHB back version'
    )
  }
  stages{
    stage('Clone repository') {
          checkout scm
    }

    stage('Run kubectl') {
       sh "kubectl get pods"
       sh "helm init --service-account tiller --client-only"
       sh "helm upgrade -i "+env.BRANCH_NAME+" --namespace test ./chart-shb"
    }
  }
}
