#!/usr/bin/env bash

export PATH="$HOME/apps/go1.20/bin:$PATH"

go env -w GOPATH=$PWD


cd src
#run
#go run main.go
#go build

#

#build debug
#go build main.go

#@build release linux 
go build -ldflags "-s -w" -o "../../dist/surat"

#@build release win
#env GOOS=windows GOARCH=amd64 go build -ldflags "-s -w" -o "../../dist/goder.exe"

#sudo apt-get install gcc-mingw-w64-i686 and sudo apt-get install gcc-mingw-w64-x86-64
#env GOOS=windows GOARCH=386 CGO_ENABLED=1 CC=i686-w64-mingw32-gcc go build -o "../../dist/surat.exe"
#env GOOS=windows GOARCH=386 CC=i686-w64-mingw32-gcc go build -o "../../dist/goder.exe"
