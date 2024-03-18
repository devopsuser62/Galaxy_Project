FROM centos:centos7.9.2009

MAINTAINER El-Xander Kingsley

WORKDIR /tmp

RUN yum update -y

RUN yum install curl wget vim tree -y

RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz

RUN tar -xfz apache*.tar.gz

RUN useradd -m -s /bin/bash -G wheel tomcat

#RUN setfacl -d -m g:tomcat:r-x /opt

RUN ln -s /tmp/apache-tomcat-9.0.73/bin/startup.sh  /usr/local/bin/tomcatup

RUN ln -s /tmp/apache-tomcat-9.0.73/bin/shutdown.sh  /usr/local/bin/tomcatdown

RUN rm -f /tmp/apache-tomcat-9.0.73/webapps/manager/META-INF/context.xml

RUN rm -f /tmp/apache-tomcat-9.0.73/webapps/host-manager/META-INF/context.xml

COPY context.xml  /tmp/apache-tomcat-9.0.73/webapps/host-manager/META-INF/context.xml

COPY context.xml /tmp/apache-tomcat-9.0.73/webapps/manager/META-INF/context.xml

COPY tomcat-users.xml  /tmp/apache-tomcat-9.0.73/conf/

RUN wget -O /tmp/apache-tomcat-9.0.73/webapps/  https://github.com/devopsuser62/Galaxy_Project/blob/main/target/GalaxyX.war

#COPY GalaxyX.war  /opt/apache-tomcat-9.0.73/webapps/

RUN tomcatdown

RUN tomcatup

RUN yum -y install java-11*


ENV JAVA_HOME=/usr/lib/jvm//usr/lib/jvm/java-11-openjdk-11.0.18.0.10-3.el7.x86_64/bin

ENV PATH=$PATH:$JAVA_HOME


EXPOSE 8080

CMD ["/bin/sh"]
