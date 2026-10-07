FROM tomcat:latest

RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps

COPY target/webapp-1.0.war /usr/local/tomcat/webapps/webapp.war

EXPOSE 8080

