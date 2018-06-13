FROM centos:7.5.1804

# utility(optional)
RUN yum install -y which less wget file tree

# ssh
RUN yum install -y openssh openssh-server openssh-clients
RUN ssh-keygen -q -N "" -f /root/.ssh/id_rsa \
  && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
  && chmod 0600 /root/.ssh/authorized_keys
ADD ssh_config /root/.ssh/config
RUN chown root:root /root/.ssh/config \
  && chmod 600 /root/.ssh/config
#RUN systemctl enable sshd \
#  && systemctl start sshd

# java
WORKDIR /tmp
RUN curl -LOs http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.rpm -H 'Cookie: oraclelicense=accept-securebackup-cookie' \
  && rpm -i jdk-8u172-linux-x64.rpm

# intall hadoop
WORKDIR /root
RUN curl -LOs http://www-us.apache.org/dist/hadoop/common/hadoop-2.8.4/hadoop-2.8.4.tar.gz \
  && tar zxf hadoop-2.8.4.tar.gz \
  && mv hadoop-2.8.4 hadoop
ADD core-site.xml /root/hadoop/etc/hadoop/core-site.xml
ADD hdfs-site.xml /root/hadoop/etc/hadoop/hdfs-site.xml
ADD mapred-site.xml /root/hadoop/etc/hadoop/mapred-site.xml
ADD yarn-site.xml /root/hadoop/etc/hadoop/yarn-site.xml
RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/java/jdk1.8.0_172-amd64:' /root/hadoop/etc/hadoop/hadoop-env.sh


# run hadoop
WORKDIR /root/hadoop
#RUN bin/hdfs namenode -format \
#  && sbin/start-dfs.sh

# NameNode WebUI port, DataNode WebUI port
EXPOSE 50070 50075

# ResouseManager WebUI port
EXPOSE 8088
