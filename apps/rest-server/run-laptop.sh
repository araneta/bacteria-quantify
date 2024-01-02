#!/usr/bin/env bash

export PATH="$HOME/apps/go1.20/bin:$PATH"

go env -w GOPATH=$PWD


cd src
#run
go version
go env
go mod tidy

go run di.go wire_gen.go main.go 
#go run main.go 
#go build

#

#build debug
#go build main.go

#@build release linux 
#go build -ldflags "-s -w"

#@build release win
#env GOOS=windows GOARCH=amd64 go build -ldflags "-s -w" -o "../../dist/goder.exe"
