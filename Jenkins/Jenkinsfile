pipeline {
  agent any

  tools {
    jdk 'JDK21'
    maven 'M3'
  }
  environment {
    // 환경변수 지정
    REGION = 'ap-northeast-2'
    DOCKER_IMAGE_NAME = "spring-petclinic"
    DOCKER_API_VERSION = '1.43'
    COMPOSE_API_VERSION = '1.43'

    // Credentials
    DOCKERHUB_CRED = credentials('dockerCredentials')
  }

  stages {
    stage('Git Clone') {
      steps {
        git url: 'https://github.com/tmddbs1977/spring-petclinic.git', 
        branch: 'main'
      }
    }
    stage('Maven Build') {
      steps {
        echo 'Maven Build'
        sh 'mvn clean package -Dmaven.test.failure.ignore=true'
      }
    }
            
    stage('Docker Build && Push') {
      steps {
        sh '''          
          docker build -t ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} .
          docker tag ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} tmddbs1977/${DOCKER_IMAGE_NAME}:latest
          echo ${DOCKERHUB_CRED_PSW} | docker login -u ${DOCKERHUB_CRED_USR} --password-stdin
          docker push tmddbs1977/${DOCKER_IMAGE_NAME}:latest
        '''
      }
      post {
        always {
          sh '''
          docker rmi -f ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}
          docker rmi -f tmddbs1977/${DOCKER_IMAGE_NAME}:latest
          '''
        }
      }
    }
    stage('Upload s3') {
      steps {
        echo "Upload to S3"
          dir("${env.WORKSPACE}") {
              sh 'zip -r scripts.zip ./scripts appspec.yml'
              withAWS(region:"${REGION}"){
                  s3Upload(file:"scripts.zip", bucket:"user02-codedeploy-bucket")
              }
              sh 'rm -rf ./scripts.zip'
          }
      }
    }

    // CodeDeploy 애플리케이션은 미리 AWS 콘솔에서 생성.
    stage('Codedeploy workload') {
      steps {
          echo "Update/Create code-deploy group"
          sh """
          # 기존 배포 그룹이 있으면 업데이트, 없으면 생성
          aws deploy create-deployment-group \
          --application-name user02-code-deploy \
          --auto-scaling-groups user02-app-asg \
          --deployment-group-name user02-code-deploy-group \
          --deployment-config-name CodeDeployDefault.OneAtATime \
          --service-role-arn arn:aws:iam::491085389788:role/user02-codedeploy-service-role \
          || aws deploy update-deployment-group \
          --application-name user02-code-deploy \
          --auto-scaling-groups user02-app-asg \
          --current-deployment-group-name user02-code-deploy-group \
          --service-role-arn arn:aws:iam::491085389788:role/user02-codedeploy-service-role
          """
          
          echo "Executing deployment"
          sh """
          aws deploy create-deployment \
          --application-name user02-code-deploy \
          --deployment-config-name CodeDeployDefault.OneAtATime \
          --deployment-group-name user02-code-deploy-group \
          --s3-location bucket=user02-codedeploy-bucket,bundleType=zip,key=scripts.zip
          """
          sleep(10)
      }
    }    
  }
}
