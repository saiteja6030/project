 FROM tomcat:8.0
 MAINTAINER saiteja
 /*COPY ./webapp.war /usr/local/tomcat/webapps*/
 COPY target/*.war /usr/local/tomcat/webapps/webapp.war
 COPY ./tomcat-users.xml  /usr/local/tomcat/conf/
 CMD ["catalina.sh","run"]
