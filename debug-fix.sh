#!/bin/bash
# Fix debug port conflict
echo "Killing any Java processes..."
pkill -f "java.*laptopshop"
pkill -f "spring-boot"

echo "Cleaning Maven target..."
./mvnw clean

echo "Starting application without debug mode..."
./mvnw spring-boot:run
