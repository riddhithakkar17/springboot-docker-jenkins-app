# Docker Build Maven Stage
FROM alpine AS build
# Copy folder in docker
WORKDIR /opt/app
COPY ./ /opt/app

RUN apk update && apk add wget
RUN apk update && \
    apk add --upgrade apk-tools && \
    apk upgrade --available --ignore openjdk17 openjdk17-jmods openjdk17-demos openjdk17-doc java-common java-cacerts openjdk17-jre-headless openjdk17-jre openjdk17-jdk && \
    sync

# Install OpenJDK 17
RUN apk --no-cache add openjdk17 --repository=https://dl-cdn.alpinelinux.org/alpine/v3.17/community
RUN wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar -xvf apache-maven-3.6.3-bin.tar.gz
RUN mv apache-maven-3.6.3 /opt/
ENV M2_HOME '/opt/apache-maven-3.6.3'
ENV PATH "$M2_HOME/bin:$PATH" 
RUN mkdir /usr/local/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.10/bin/apache-tomcat-10.1.10.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-10.1.10/* /usr/local/tomcat/
RUN sed -i 's/port="8080"/port="8081"/' /usr/local/tomcat/conf/server.xml

RUN mvn package -DskipTests
RUN cp /opt/app/target/project-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/app.war
ENV PORT 8081
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
