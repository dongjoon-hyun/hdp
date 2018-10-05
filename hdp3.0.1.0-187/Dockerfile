# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM dongjoon/ubuntu16.04-jdk8
MAINTAINER Dongjoon Hyun <dongjoon@apache.org>

# HDP 3.0.1
RUN \
  wget http://public-repo-1.hortonworks.com/HDP/ubuntu16/3.x/updates/3.0.1.0/hdp.list -O /etc/apt/sources.list.d/hdp.list && \
  apt-get update && \
  apt-get clean

RUN apt-get install -y --allow-unauthenticated hadoop-3-0-1* hive-3-0-1* spark2-3-0-1* vim git

ENV HADOOP_HOME /usr/hdp/3.0.1.0-187/hadoop

RUN \
  echo 'HADOOP_HOME="/usr/hdp/3.0.1.0-187/hadoop"' >> /etc/environment && \
  echo 'HADOOP_COMMON_HOME="/usr/hdp/3.0.1.0-187/hadoop"' >> /etc/environment && \
  echo 'HADOOP_HDFS_HOME="/usr/hdp/3.0.1.0-187/hadoop"' >> /etc/environment && \
  echo 'HADOOP_MAPRED_HOME="/usr/hdp/3.0.1.0-187/hadoop"' >> /etc/environment && \
  echo 'HADOOP_YARN_HOME="/usr/hdp/3.0.1.0-187/hadoop-yarn"' >> /etc/environment && \
  echo 'HADOOP_CONF_DIR="/usr/hdp/3.0.1.0-187/hadoop/etc/hadoop"' >> /etc/environment
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HADOOP_HOME-yarn/bin:$HADOOP_HOME-yarn/sbin:$HADOOP_HOME-hdfs/bin:$HADOOP_HOME-hdfs/sbin

COPY core-site.xml $HADOOP_HOME/etc/hadoop/
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/
COPY mapred-site.xml $HADOOP_HOME/etc/hadoop/
COPY yarn-site.xml $HADOOP_HOME/etc/hadoop/
RUN sed -i.bak '/<configuration>/a\\n<property>\n<name>hive.metastore.schema.verification</name>\n<value>false</value>\n</property>\n' /etc/hive/conf/hive-site.xml
RUN cp /etc/hive/conf/hive-site.xml /etc/spark2/conf/

COPY init-service.sh /root/

EXPOSE 22 4040 7077 8088 9864-9871
