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
                    def shbBackRepoLatest = "shb/shb-"+$(BRANCH_NAME)

                    def startDate = new Date()
                    def getVersionScript = "./findDockerImages.bash " + shbBackRepo + " " + shbBackRepoLatest + " $REGISTRY_CRED"
                    def versionBack = sh(script: getVersionScript, returnStdout: true).trim()
                    def endDate = new Date()
                    def tookTime = groovy.time.TimeCategory.minus(endDate,startDate).toString()
                    echo "*******************************************************************************"
                    echo "****************  SHB Back Version : " + versionBack
                    echo "*****************  Spent time : " + tookTime


                    def uiRepo = "shb/shb-ui"
                    def uiRepoLatest = "shb/shb-ui-develop"
                    startDate = new Date()
                    getVersionScript = "./findDockerImages.bash " + uiRepo + " " + uiRepoLatest + " $REGISTRY_CRED"
                    def versionUi = sh(script: getVersionScript, returnStdout: true).trim()
                    endDate = new Date()
                    tookTime = groovy.time.TimeCategory.minus(endDate,startDate).toString()
                    echo "*******************************************************************************"
                    echo "****************  SHB Ui Version : " + versionUi
                    echo "*****************  Spent time : " + tookTime


                    def filename = './chart-shb/charts/shb-back/values.yaml'
                    def data = readYaml file: filename
                    data.image.tag = 'hjkhjkhkj'
                    sh "rm $filename"
                    writeYaml file: filename, data: data

                    sh 'cat ./chart-shb/charts/shb-back/values.yaml'


//                    sh "./replaceVersion.bash " + versionBack +" " + versionUi

//                    def cartVer = "1.1.0.$BUILD_NUMBER"

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
