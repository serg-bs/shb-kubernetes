pipeline {
    agent any
    parameters {
        string(name: 'SHBBACK_VERSION',
                defaultValue: 'latest',
                description: 'SHB back version'
        )
        string(name: 'UIBACK_VERSION',
                defaultValue: 'latest',
                description: 'SHB ui version'
        )
        string(name: 'AD_VERSION',
                defaultValue: 'latest',
                description: 'SHB adapter version'
        )
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Find docker images') {
            environment {
                REGISTRY_CRED = credentials('docker-registry-shb-deploy-credentials-id')
            }
            steps {
                withCredentials([[$class          : 'UsernamePasswordMultiBinding', credentialsId: 'docker-registry-shb-deploy-credentials-id',
                                  usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {

                   sh  "./findDockerImages.bash shb/shb shb/shb-develop $REGISTRY_CRED"
                    echo '*******************************************************************************'


//                    def ret = sh(script: findScript, returnStdout: true)
                    echo 'hello'
                }
            }

        }

        stage('Run kubectl') {
            steps {
                sh "kubectl get pods"
//                sh "helm init --service-account tiller --client-only"
//                sh "helm upgrade -i " + env.BRANCH_NAME + " --namespace test ./chart-shb"
            }
        }
    }
}
