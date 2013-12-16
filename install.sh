#!/usr/bin/env bash

yum -y install supervisor

groupadd storm
useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm

wget http://public-repo-1.hortonworks.com/HDP-LABS/Projects/Storm/0.9.0.1/storm-0.9.0.1.tar.gz

tar -zxf storm-0.9.0.1.tar.gz -C /usr/share
chown -R storm:storm /usr/share/storm-0.9.0.1
ln -s /usr/share/storm-0.9.0.1 /usr/share/storm
ln -s /usr/share/storm/bin/storm /usr/bin/storm
mkdir /etc/storm
chown storm:storm /etc/storm
ln -s /usr/share/storm/conf/storm.yaml /etc/storm/storm.yaml
mkdir /var/log/storm
chown storm:storm /var/log/storm

printf '
storm.zookeeper.servers:
 - "localhost"
nimbus.host: "localhost"
drpc.servers:
 - "localhost"
storm.local.dir: "/home/storm"
logviewer.port: 8081
storm.messaging.transport: "backtype.storm.messaging.netty.Context"
storm.messaging.netty.buffer_size: 16384
storm.messaging.netty.max_retries: 10
storm.messaging.netty.min_wait_ms: 1000
storm.messaging.netty.max_wait_ms: 5000' >> /etc/storm/storm.yaml

sed -i 's/${storm.home}\/logs/\/var\/log\/storm/g' /usr/share/storm/logback/cluster.xml

printf '
[program:storm-nimbus]
command=storm nimbus
directory=/home/storm
autorestart=true
user=storm

[program:storm-supervisor]
command=storm supervisor
directory=/home/storm
autorestart=true
user=storm

[program:storm-ui]
command=storm ui
directory=/home/storm
autorestart=true
user=storm

[program:storm-logviewer]
command=storm logviewer
directory=/home/storm
autorestart=true
user=storm

[program:storm-drpc]
command=storm drpc
directory=/home/storm
autorestart=true
user=storm' >> /etc/supervisord.conf

service supervisord start
chkconfig supervisord on

# Run this line to submit a WordCount topology for testing
# Sleep to allow the storm cluster time to start
#wget http://public-repo-1.hortonworks.com/HDP-LABS/Projects/Storm/0.9.0.1/storm-starter-0.0.1-storm-0.9.0.1.jar
#sleep 10
#storm jar storm-starter-0.0.1-storm-0.9.0.1.jar storm.starter.WordCountTopology WordCount -c nimbus.host=sandbox.hortonworks.com
