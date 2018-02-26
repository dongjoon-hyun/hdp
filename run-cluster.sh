#!/usr/bin/env bash
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

VERSION=${1%/}
IMAGE=dongjoon/${VERSION:-hdp2.6.4.0-91}

LINK=""
for i in {1..3}
do
    HOST=hdn-001-0$i
    LINK="$LINK --link=$HOST:$HOST"
    docker run --name=$HOST -h $HOST -p 1001$i:22 -d $IMAGE /root/start.sh
done

HOST=hnn-001-01
PORT="-p 4040:4040 -p 5050:5050 -p 8088:8088 -p 10000:10000 -p 10010:22 -p 26002:26002 -p 26080:26080 -p 50070:50070"
docker run --name=$HOST -h $HOST $PORT $LINK -it --rm -v $SPARK_HOME:/spark $IMAGE /root/init-nn.sh

for i in {1..3}
do
    docker rm -f hdn-001-0$i
done
