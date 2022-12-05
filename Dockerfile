# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER "prakash" 
COPY ./target/webapp.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
