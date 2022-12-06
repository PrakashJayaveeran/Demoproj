# Pull base image 
From tomcat:latest

# Maintainer 
MAINTAINER "prakash" 
COPY ./Devops/Conf/target/webapp.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
