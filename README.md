# Analytics Backend (Java / Spring Boot) - Simplified scaffold

This is a simplified scaffold for the Website Analytics backend using:
- Java 17 / Spring Boot 3
- MySQL
- Redis (optional)
- Docker Compose for local run

## Quick run with Docker Compose
1. Ensure Docker Desktop is running.
2. From project root run:
   docker-compose up --build

3. App will be available at http://localhost:8080

## Endpoints
- POST /api/auth/register  -> returns apiKey
- POST /api/analytics/collect  -> requires header X-API-KEY
- GET /api/analytics/event-summary -> requires header X-API-KEY

Note: This is a scaffold to help you finish the assessment quickly. It uses simple approaches and is meant for development/testing only.
