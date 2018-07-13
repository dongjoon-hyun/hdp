#!/bin/bash
#
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

/usr/sbin/sshd

grep hdn /etc/hosts | awk '{print $1}' | sort | uniq > $HADOOP_HOME/etc/hadoop/slaves
for host in `cat $HADOOP_HOME/etc/hadoop/slaves`; do
    scp /etc/hosts $host:/etc/hosts
    scp $HADOOP_HOME/etc/hadoop/slaves $host:$HADOOP_HOME/etc/hadoop/slaves
done

hdfs namenode -format

hdfs --daemon start namenode
for host in `cat $HADOOP_HOME/etc/hadoop/slaves`; do
    ssh $host hdfs --daemon start datanode
done

yarn --daemon start resourcemanager
for host in `cat $HADOOP_HOME/etc/hadoop/slaves`; do
    ssh $host yarn --daemon start nodemanager
done

/usr/hdp/current/hive-client/bin/schematool -dbType derby -initSchema

cd ~ && /bin/bash
