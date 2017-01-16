# set up base centos
FROM centos:7
ENV container docker
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

# install java you can either copy the version you need or install by specifying version, in the following code
# a specific predetermined version is copied and installed

#ENV JAVA_VERSION 8u92
#ENV JAVA_BUILD_VERSION b14
#RUN yum -y upgrade && \
#    curl -L -k  -H "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-${JAVA_BUILD_VERSION}/jdk-${JAVA_VERSION}-linux-x64.rpm" > /tmp/jdk-linux-x64.rpm && \
ARG JAVA_FILE
COPY jdk-linux-x64.rpm /tmp 
RUN yum -y upgrade && \
    yum -y install /tmp/$JAVA_FILE && \
    yum clean all && rm -rf /tmp/$JAVA_FILE.rpm

# install spark , a specific predetermined version is copied over and installed
ARG SPARK_HOME
ARG SPARK_FILE
RUN mkdir /usr/lib/spark
COPY $SPARK_FILE /usr/lib/spark
RUN cd /usr/lib/spark && tar -xf $SPARK_FILE 
ENV SPARK_HOME=$SPARK_HOME

