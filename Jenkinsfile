node {
    stage('Run kubectl') {
        sh "kubectl get pods"
        sh "helm init --service-account tiller --client-only"
        sh "ls -l"
        sh "helm upgrade -i "+env.BRANCH_NAME+" --namespace test ./chart-shb"
    }
}