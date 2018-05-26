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
param($VERSION="hdp2.6.5.0-292")
$IMAGE="dongjoon/$VERSION"

$LINK=""
For ($i=1; $i -le 3; $i++) {
    $H="hdn-001-0$i"
    $LINK="$LINK --link=${H}:${H}"
    $CMD="docker run --name=$H -h $H -p 1001${i}:22 -d $IMAGE /root/start.sh"
    Invoke-Expression $CMD
}

$H="hnn-001-01"
$PORT="-p 4040:4040 -p 5050:5050 -p 8088:8088 -p 10000:10000 -p 10010:22 -p 26002:26002 -p 26080:26080 -p 50070:50070"
$CMD="docker run --name=$H -h $H $PORT $LINK -it --rm $IMAGE /root/init-nn.sh"
Invoke-Expression $CMD

For ($i=1; $i -le 3; $i++) {
    $H="hdn-001-0$i"
    $CMD="docker rm -f $H"
    Invoke-Expression $CMD
}