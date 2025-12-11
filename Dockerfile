# Build stage
FROM maven:3.9.6-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Production stage
FROM tomcat:9.0-jdk11-temurin

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from build stage
COPY --from=build /app/target/Hospital_Management_System.war /usr/local/tomcat/webapps/ROOT.war

# Expose port (Render uses PORT environment variable)
EXPOSE 8080

# Set environment variables for database connection (will be overridden by Render)
ENV DB_HOST=localhost
ENV DB_PORT=3306
ENV DB_NAME=hospital_db
ENV DB_USER=root
ENV DB_PASSWORD=password
ENV DB_SSL=false
ENV DB_SSL_MODE=DISABLED

# Start Tomcat
CMD ["catalina.sh", "run"]
