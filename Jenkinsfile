pipeline {
  agent any

  environment {
    COMPOSE_PROJECT_NAME = "sooyaa"
    DOCKER_CONTEXT = "jenkins-remote"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/YOUR_USERNAME/YOUR_REPO.git'
      }
    }

    stage('Deploy PostgreSQL') {
      steps {
        sh '''
          docker --context=$DOCKER_CONTEXT compose down || true
          docker --context=$DOCKER_CONTEXT compose pull
          docker --context=$DOCKER_CONTEXT compose up -d
        '''
      }
    }

    stage('Wait for DB to be ready') {
      steps {
        // รอ postgres พร้อม (สามารถเปลี่ยนได้ตามวิธีที่เหมาะกับคุณ)
        sh 'sleep 10'
      }
    }

    stage('Verify DB Setup') {
      steps {
        sh '''
          docker --context=$DOCKER_CONTEXT exec sooyaa-postgres psql -U sooyaa -d sooyaa_db -c "\\dt"
        '''
      }
    }
  }
}
