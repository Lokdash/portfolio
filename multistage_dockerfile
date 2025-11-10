# Стадия сборки
FROM maven:3.8.6-openjdk-11 AS building
WORKDIR /hello
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /hello/boxfuse-sample-java-war-hello
RUN mvn clean package

# Стадия запуска
FROM tomcat:9-jre11
COPY --from=building /hello/boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
