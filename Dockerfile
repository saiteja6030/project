 FROM tomcat:8.0
 MAINTAINER saiteja
 COPY ./webapp.war /usr/local/tomcat/webapps
 COPY ./tomcat-users.xml  /usr/local/tomcat/conf/
 CMD ["catalina.sh","run"]
