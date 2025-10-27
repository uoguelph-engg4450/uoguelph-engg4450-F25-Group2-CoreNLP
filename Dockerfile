# Base image with Java 11
FROM openjdk:11

# Prevents prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory inside container
WORKDIR /CoreNLPDOCKER

# Install git, maven, curl
RUN apt update && apt install -y git maven curl

# Clone your fork and check out your branch directly
RUN git clone --single-branch --branch dockerCreation https://github.com/JonathanButterworth/CoreNLP.git . && \
    mvn clean package -DskipTests

# Download English model (add more if needed)
RUN mkdir models && \
    curl -o models/english-models.jar https://downloads.cs.stanford.edu/nlp/software/stanford-english-corenlp-2020-11-17-models.jar

# COPY THE MISSING DEMO FILES to target/classes (THIS IS THE FIX)
RUN cp -r src/edu/stanford/nlp/pipeline/demo target/classes/edu/stanford/nlp/pipeline/

# Expose CoreNLP server port
EXPOSE 9000

# Command to start CoreNLP server
CMD ["java", "-mx4g", "-cp", "target/classes:target/*:models/*", "edu.stanford.nlp.pipeline.StanfordCoreNLPServer", "-port", "9000", "-timeout", "15000"]