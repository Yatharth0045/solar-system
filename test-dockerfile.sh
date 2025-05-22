#!/bin/bash

# Exit on any error
set -e

echo "🚀 Starting Dockerfile tests..."

# Build the image
echo "📦 Building Docker image..."
docker build -t solar-system-app .

# Install container-structure-test if not already installed
if ! command -v container-structure-test &> /dev/null; then
    echo "📥 Installing container-structure-test..."
    curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-darwin-amd64
    chmod +x container-structure-test-darwin-amd64
    sudo mv container-structure-test-darwin-amd64 /usr/local/bin/container-structure-test
fi

# Run the structure tests
echo "🧪 Running container structure tests..."
container-structure-test test --image solar-system-app --config dockerfile.test.yaml

# Run the container and test the health check
echo "💓 Testing container health check..."
docker run -d --name solar-system-test -p 3000:3000 solar-system-app
sleep 10  # Wait for container to start

# Check if container is healthy
HEALTH_STATUS=$(docker inspect --format='{{.State.Health.Status}}' solar-system-test)
if [ "$HEALTH_STATUS" = "healthy" ]; then
    echo "✅ Container health check passed!"
else
    echo "❌ Container health check failed!"
    docker logs solar-system-test
    exit 1
fi

# Cleanup
docker stop solar-system-test
docker rm solar-system-test

echo "✨ All tests completed successfully!" 