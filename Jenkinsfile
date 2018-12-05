node {
    stage('Run kubectl') {
        sh "kubectl get pods"
        sh "helm init --service-account tiller --tiller-namespace tiller-test-world"
        sh "helm upgrade -i "+env.BRANCH_NAME+" --namespace test ./chart-shb"
    }
}