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
                script {
                    def shbBackRepo = "shb/shb"
                    def shbBackRepoLatest = "shb/shb-develop"

                    def startDate = new Date()
                    def getVersionScript = "./findDockerImages.bash " + shbBackRepo + " " + shbBackRepoLatest + " $REGISTRY_CRED"
                    def versionBack = sh(script: getVersionScript, returnStdout: true)
                    def endDate = new Date()
//                    def tookTime = TimeCategory.minus(endDate,startDate).toString()
                    echo "*******************************************************************************"
                    echo "****************  SHB Back Version : " + versionBack
//                    echo "*****************  Spent time : " + tookTime


                    def uiRepo = "shb/shb-ui"
                    def uiRepoLatest = "shb/shb-ui-develop"
                    startDate = new Date()
                    getVersionScript = "./findDockerImages.bash " + uiRepo + " " + uiRepoLatest + " $REGISTRY_CRED"
                    def versionUi = sh(script: getVersionScript, returnStdout: true)
                    endDate = new Date()
//                    tookTime = TimeCategory.minus(endDate,startDate).toString()
                    echo "*******************************************************************************"
                    echo "****************  SHB Ui Version : " + versionUi
//                    echo "*****************  Spent time : " + tookTime

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
