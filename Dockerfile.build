FROM golang:1.7.4
MAINTAINER madhu@docker.com

RUN go get github.com/rancher/trash

ENV USER root
WORKDIR /go/

RUN mkdir -p bin src/swarm-exec
COPY . ./src/swarm-exec/

CMD ["/go/src/swarm-exec/compile.sh"]
