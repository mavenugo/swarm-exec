# swarm-exec
A simple tool to execute a docker command in all the swarm nodes. It uses swarm's global service mode to execute the command in all the nodes and bind-mounts docker cli and docker socket.

## Building
`./build.sh`

## Requirements
- This needs to run on a swarm manager
- Docker 1.12 or higher needs to be running on all of the hosts on your swarm

### docker image
Run the image passing in the different commands.

```
docker service create --mode=global --restart-condition none --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock mavenugo/swarm-exec:1.12.4 docker run --net=host busybox sleep 5000
```

Also, checkout the convenience script swarm-exec.sh
