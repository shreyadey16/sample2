FROM openjdk:8
WORKDIR /home/ec2-user/webapp
COPY target/webapp-0.0.2.war webapp-0.0.2.war
COPY pom.xml pom.xml
COPY maven-entrypoint.sh maven-entrypoint.sh
RUN chmod +x maven-entrypoint.sh
ENTRYPOINT ["./maven-entrypoint.sh"]
