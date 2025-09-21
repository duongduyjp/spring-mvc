#!/bin/bash

echo "🧹 Cleaning debug ports..."

# Kill processes on common debug ports
for port in 52341 52844 5005 8000; do
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null; then
        echo "Killing process on port $port"
        lsof -ti :$port | xargs kill -9 2>/dev/null || true
    fi
done

echo "✅ Ports cleaned!"
echo "🚀 Starting Spring Boot in debug mode..."

# Start with random JMX port to avoid conflicts
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dcom.sun.management.jmxremote.port=0 -Dcom.sun.management.jmxremote.rmi.port=0"


