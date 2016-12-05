#!/bin/bash

set -e

cd /go/src/swarm-exec
trash
go vet
go build -tags netgo
cp swarm-exec /go/bin
