FROM alpine:edge
MAINTAINER madhu@docker.com
ARG VERSION
ARG BASE_URL

RUN apk update && apk add ca-certificates wget && update-ca-certificates

# needed in order for go binary to work.
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

ADD bin/swarm-exec /usr/local/bin/

RUN chmod 755 /usr/local/bin/swarm-exec
RUN wget -q https://$BASE_URL.docker.com/builds/Linux/x86_64/docker-$VERSION.tgz && tar -xzf docker-$VERSION.tgz && cp docker/docker /usr/bin

CMD [ "swarm-exec" ]
