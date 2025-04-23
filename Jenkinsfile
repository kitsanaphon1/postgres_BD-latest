pipeline {
  agent any

  environment {
    COMPOSE_PROJECT_NAME = "sooyaa"
    DOCKER_CONTEXT = "jenkins-remote"
    DEPLOY_MODE = "up" // เปลี่ยนเป็น "down" เพื่อ stop service และลบ volume
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/kitsanaphon1/postgres_BD-latest.git'
      }
    }

    stage('Handle Deploy Mode') {
      steps {
        script {
          if (env.DEPLOY_MODE == 'up') {
            sh '''
              echo "🧹 Cleanup old containers & volumes"
              docker --context=$DOCKER_CONTEXT compose down -v || true

              echo "⬇️ Pulling images"
              docker --context=$DOCKER_CONTEXT compose pull

              echo "🚀 Starting PostgreSQL with docker-compose up"
              docker --context=$DOCKER_CONTEXT compose up -d
            '''
          } else if (env.DEPLOY_MODE == 'down') {
            sh '''
              echo "🛑 Stopping and removing PostgreSQL containers + volumes"
              docker --context=$DOCKER_CONTEXT compose down -v || true
            '''
          } else {
            error "Invalid DEPLOY_MODE: ${env.DEPLOY_MODE} (must be 'up' or 'down')"
          }
        }
      }
    }

    stage('Wait for DB (if up)') {
      when {
        expression { return env.DEPLOY_MODE == 'up' }
      }
      steps {
        sh '''
          echo "⏳ Waiting for PostgreSQL to be ready..."
          for i in {1..10}; do
            if docker --context=$DOCKER_CONTEXT exec sooyaa-postgres pg_isready -U sooyaa; then
              echo "✅ PostgreSQL is ready"
              break
            fi
            sleep 3
          done
        '''
      }
    }
  }
}
