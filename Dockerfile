# tomcat8.5
FROM registry.access.redhat.com/jboss-webserver-3/webserver31-tomcat8-openshift
RUN rm -rf /opt/webserver/*
COPY ./apache-tomcat-8.5.73/ /opt/webserver
USER root
RUN ln -s /deployments /opt/webserver/webapps
RUN rm -rf /opt/rh/rh-maven35/root/user/share/maven/*
COPY ./apache-maven-3.8.4/ /opt/rh/rh-maven35/root/user/share/maven
COPY ./apache-maven-3.8.4/bin /opt/rh/rh-maven35/bin

RUN chown -R jboss:root /opt/webserver && \
    chmod -R a+w /opt/webserver && \
    chmod -R 777 /opt/webserver/bin && \
    chmod -R 777 /opt/webserver && \
    chmod -R 777 /opt/rh/rh-maven35/root/user/share/maven && \
    chmod -R 777 /opt/rh/rh-maven35/root/bin
USER 1002 
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run
