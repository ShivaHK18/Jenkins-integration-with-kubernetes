FROM tomcat:9-jre9 
MAINTAINER shivarajsoori@gmail.com
COPY ./target/netflix.war /usr/local/tomcat/webapps
