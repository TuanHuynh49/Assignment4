# Stage 1: Build application with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B || true

# Copy source code and build war package
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run with Tomcat
FROM tomcat:10.1-jdk17-temurin

# Remove default Tomcat sample webapps (optional, for clean deployment)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy packaged WAR to webapps
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/Assignment3.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
