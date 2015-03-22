#!/bin/sh
# This runs a container in default mode. Note that this expects that the sieglstefan/introscope-postgres already is started

docker run -d --name introscope-em -e HEAP="2048m" -p 5001:5001 -p 8081:8081 -p 8080:8080 --link introscope-db:db stefansiegl/introscope-em

# use this as example to map management modules
# docker run -d --name introscope-em -v /c/Users/SS/docker/mm:/root/Introscope9.6.0.0/config/modules -p 5001:5001 -p 8081:8081 -p 8080:8080 --link introscope-db:db stefansiegl/introscope-em
