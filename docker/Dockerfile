# Use the official OpenJDK image as the base image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml ./
COPY src ./src

# Run Maven to clean, compile, and package the application
RUN mvn clean package -DskipTests=true

# Copy the resulting JAR file to the app directory
COPY target/myapp.jar ./myapp.jar

# Command to run the application
CMD ["java", "-jar", "myapp.jar"]
