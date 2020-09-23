 FROM tomcat:8.0
 MAINTAINER saiteja
 COPY target/*.war /usr/local/tomcat/webapps/webapp.war
 COPY ./tomcat-users.xml  /usr/local/tomcat/conf/
 CMD ["catalina.sh","run"]
