# docker-pseudo-distributed-cluster

## build image

```
$ cd docker-pseudo-distributed-cluster
$ docker build -t docker-pseudo-distributed-cluster:1.0 .
```

## run container

```
$ docker run --privileged -p 50070:50070 -p 50075:50075 -p 8088:8088 -d --name docker_hadoop docker-pseudo-distributed-cluster:1.0 /sbin/init
```

## attach container

```
$ docker exec -it docker_hadoop /bin/bash
```

In container, to run hadoop execute below commands.

```
# systemctl start sshd
# cd /root/hadoop
# bin/hdfs namenode -format
# sbin/start-dfs.sh
# sbin/start-yarn.sh
```

Then, you can access

- NameNode WebUI: [http://localhost:50070/](http://localhost:50070/)
- Resource Manager WebUI: [http://localhost:8088/](http://localhost:8088/)
