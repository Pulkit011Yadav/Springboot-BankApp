#____________________________________Stage 1____________________________________
#Base image
FROM maven:3.8.3-openjdk-17 as builder 

# Add maintainer, so that new user will understand who had written this Dockerfile
LABEL maintainer="Pulkit Yadav<pulkityadav242@gmail.com>"

# Add labels 
LABEL app=bankapp

# Set working directory
WORKDIR /src

# Copy source code from local to container
COPY . /src

# Build application and skip test cases
RUN mvn clean install -DskipTests=true
#____________________________________Stage 2_____________________________________
# small image
FROM eclipse-temurin:17-jre-alpine as deployer

# Copy build from stage 1 (builder)
COPY --from=builder /src/target/*.jar /src/app/bankapp.jar

# Expose application port 
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/src/app/bankapp.jar"]
