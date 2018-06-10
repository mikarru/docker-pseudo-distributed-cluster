# docker-pseudo-distributed-cluster

## build image

```
$ cd docker-pseudo-distributed-cluster
$ docker build docker-pseudo-distributed-cluster:1.0 .
```

## run container

```
$ docker run --privileged -d --name docker_hadoop docker-pseudo-distributed-cluster:1.0 /sbin/init
```

## attach container

```
$ docker exec -it docker_hadoop /bin/bash
```

In container, to run hadoop

```
# systemctl start sshd
# cd /root/hadoop
# bin/hdfs namenode -format
# sbin/start-dfs.sh
```
