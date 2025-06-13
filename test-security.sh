#!/bin/bash

echo "🔍 Starting Security Testing Suite..."

# Test 1: Check for secrets using Gitleaks
echo "📝 Test 1: Running Gitleaks scan..."
gitleaks detect --source . --config .gitleaks.toml
if [ $? -eq 0 ]; then
    echo "✅ No secrets found in the codebase"
else
    echo "❌ Secrets found in the codebase"
    exit 1
fi

# Test 2: Check Docker image vulnerabilities
echo "📝 Test 2: Running Trivy scan..."
docker build -t vulnerable-api .
trivy image vulnerable-api --severity CRITICAL,HIGH
if [ $? -eq 0 ]; then
    echo "✅ No critical/high vulnerabilities found in Docker image"
else
    echo "❌ Critical/high vulnerabilities found in Docker image"
    exit 1
fi

# Test 3: Verify environment variables
echo "📝 Test 3: Checking environment variables..."
required_vars=("DB_SERVER" "DB_NAME" "DB_USER" "DB_PASSWORD" "API_KEY" "JWT_SECRET")
missing_vars=0

for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "❌ Missing required environment variable: $var"
        missing_vars=1
    fi
done

if [ $missing_vars -eq 0 ]; then
    echo "✅ All required environment variables are set"
else
    echo "❌ Some environment variables are missing"
    exit 1
fi

# Test 4: Verify .NET version
echo "📝 Test 4: Checking .NET version..."
dotnet_version=$(dotnet --version)
if [[ $dotnet_version == 7.* ]]; then
    echo "✅ Using .NET 7.x"
else
    echo "❌ Not using .NET 7.x (found version $dotnet_version)"
    exit 1
fi

# Test 5: Check container runs as non-root
echo "📝 Test 5: Verifying container runs as non-root..."
docker run --rm vulnerable-api whoami | grep -q "appuser"
if [ $? -eq 0 ]; then
    echo "✅ Container runs as non-root user"
else
    echo "❌ Container is not running as non-root user"
    exit 1
fi

echo "🎉 All security tests completed!" 