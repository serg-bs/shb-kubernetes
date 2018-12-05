node {
    stage('Run kubectl') {
        sh "kubectl get pods"
        sh "helm init --service-account tiller"
        sh "helm upgrade -i "+env.BRANCH_NAME+" --namespace test ./chart-shb"
    }
}