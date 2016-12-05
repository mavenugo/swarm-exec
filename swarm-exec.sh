#!/bin/sh

set -e


###
### This is an example script on how one can use the swarm-exec service to execute arbitrary docker commands.
### The service creation parameters here are highly opinionated, such as `--restart-condition none`.
### This setting for example doesnt restart the task after a single execution of the passed docker command.
### TODO : Make this script configurable that can take in parameters to feed into these service parameters.
### Till that time, change the service create options to address your requirements.
###

### Example : swarm-exec.sh docker run --net=host --name=myhostcontainer busybox sleep 50000
### This will run a busybox container in all the swarm hosts in host network

OUTPUT="$(docker service create --mode=global --restart-condition none --mount type=bind,source=/usr/bin/docker,target=/usr/bin/docker --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock mavenugo/swarm-exec:v0.1 $@)"
echo "Your command : \"$@\" is successfully executed in the swarm cluster"
echo "Note: your docker command is executed as a swarm global service. When a new node is added to the cluster or after an upgrade, your command will be automatically executed on the new node. If you want to clean up the service, pls remove it using : "
echo "docker service rm $OUTPUT"
