# Use the official OpenJDK image as the base image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Install Maven and any required dependencies
RUN apt-get update && apt-get install -y \
    maven \
    && rm -rf /var/lib/apt/lists/*
    
# Copy the Maven project files to the container
COPY pom.xml ./
COPY src ./src

# Run Maven to clean, compile, and package the application
RUN mvn clean package -DskipTests=true

# Copy the resulting JAR file to the app directory
COPY target/spring-petclinic-3.4.0-SNAPSHOT.jar ./spring-petclinic-3.4.0-SNAPSHOT.jar

# Command to run the application
CMD ["java", "-jar", "spring-petclinic-3.4.0-SNAPSHOT.jar"]
