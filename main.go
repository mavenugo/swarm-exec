package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

const (
	defaultHost = "unix:///var/run/docker.sock"
)

var (
	host = defaultHost
)

func main() {
	/*
		once := flag.Bool("once", false, "Execute this command only once in the cluster")
	*/
	flag.Usage = printUsage
	flag.Parse()

	args := flag.Args()
	if len(args) == 0 {
		printUsage()
		os.Exit(1)
	}

	idx := 0
	if strings.EqualFold(args[0], "docker") {
		idx = 1
	}

	if len(args) <= idx {
		printUsage()
		os.Exit(1)
	}

	cmd := exec.Command("/usr/bin/docker", args[idx:]...)
	out, _ := cmd.CombinedOutput()
	fmt.Printf("%s\n", out)
}

func printUsage() {
	fmt.Println("Usage : swarm-exec DOCKER-COMMAND")
	flag.PrintDefaults()
}
