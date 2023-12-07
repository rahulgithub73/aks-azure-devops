FROM eclipse-temurin:21-jre-alpine

# Create User
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy Jar
COPY target/*.jar /tmp/app.jar
EXPOSE 8080
EXPOSE 8081

# Health Check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q -O - http://localhost:8081/actuator/health || exit 1

CMD ["java", "-jar", "/tmp/app.jar"]
