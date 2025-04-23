pipeline {
  agent any

  environment {
    COMPOSE_PROJECT_NAME = "sooyaa"
    DOCKER_CONTEXT = "jenkins-remote"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/kitsanaphon1/postgres_BD-latest.git'
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
        // รอให้ DB พร้อม (แบบง่าย)
        sh 'sleep 10'
      }
    }

    stage('Verify Tables') {
      steps {
        sh '''
          docker --context=$DOCKER_CONTEXT exec sooyaa-postgres \
          psql -U sooyaa -d sooyaa_db -c "\\dt"
        '''
      }
    }

    stage('Show Sample Data') {
      steps {
        sh '''
          docker --context=$DOCKER_CONTEXT exec sooyaa-postgres \
          psql -U sooyaa -d sooyaa_db -c "SELECT * FROM users;"
        '''
      }
    }
  }
}
