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
          echo "🔄 Stopping and removing old containers with volume..."
          docker --context=$DOCKER_CONTEXT compose down -v || true

          echo "⬇️ Pulling latest images..."
          docker --context=$DOCKER_CONTEXT compose pull

          echo "🚀 Starting fresh container..."
          docker --context=$DOCKER_CONTEXT compose up -d
        '''
      }
    }

    stage('Wait for DB to be ready') {
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

    stage('Verify Tables') {
      steps {
        sh '''
          echo "📋 Listing tables..."
          docker --context=$DOCKER_CONTEXT exec sooyaa-postgres \
          psql -U sooyaa -d sooyaa_db -c "\\dt"
        '''
      }
    }

    stage('Show Sample Data') {
      steps {
        sh '''
          echo "📄 Displaying data from users table..."
          docker --context=$DOCKER_CONTEXT exec sooyaa-postgres \
          psql -U sooyaa -d sooyaa_db -c "SELECT * FROM users;"
        '''
      }
    }
  }
}
