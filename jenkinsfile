pipeline {
    agent any
    tools {nodejs "Node"}
    environment {
        CI = 'true'
        API_DIR = './SampleStore'
        DEV_ENV = 'dev'
        PROD_ENV = 'prod'
        TEST_SCRIPT_FILE = 'sample.store.dev.postman_collection.json'        
    }
    stages {
        stage('Preparation') {
            steps{
                git branch: "master",
                url: 'https://github.com/dushaniw/sample-store.git',
                credentialsId: 'dushaniw-git'
            }
        }
        stage('Deploy to Dev') {
            environment{
                RETRY = '80'
            }
            steps {
                echo 'Logging into $DEV_ENV'
                withCredentials([usernamePassword(credentialsId: 'apim_dev', usernameVariable: 'DEV_USERNAME', passwordVariable: 'DEV_PASSWORD')]) {
                    sh 'apictl login $DEV_ENV -u $DEV_USERNAME -p $DEV_PASSWORD -k'                        
                }
                echo 'Deploying to $DEV_ENV'
                sh 'apictl import-api -f $API_DIR -e $DEV_ENV -k --preserve-provider --update --verbose'
            }
        }
        stage('Run Tests') {
            steps {
                echo 'Running tests in $DEV_ENV'
                sh 'newman run $API_DIR/$TEST_SCRIPT_FILE --insecure' 
            }
        }
        stage('Deploy to Production') {
            environment{
                RETRY = '60'
            }
            steps {
                sh 'echo "Logging into $PROD_ENV"'
                withCredentials([usernamePassword(credentialsId: 'apim_prod', usernameVariable: 'PROD_USERNAME', passwordVariable: 'PROD_PASSWORD')]) {
                    sh 'apictl login $PROD_ENV -u $PROD_USERNAME -p $PROD_PASSWORD -k'                        
                }
                echo 'Deploying to Production'
                sh 'apictl import-api -f $API_DIR -e $PROD_ENV -k --preserve-provider --update --verbose'
            }
        }
    }
    post {
        cleanup {
            deleteDir()
            dir("${workspace}@tmp") {
                deleteDir()
            }
            dir("${workspace}@script") {
                deleteDir()
            }
        }
    }
}