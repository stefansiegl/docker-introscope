#!/bin/bash
# This runs a container in default mode. Note that this expects that the sieglstefan/introscope-postgres already is started

docker run -d --name introscope-em -p 5001:5001 -p 8081:8081 -p 8080:8080 --link introscope-db:db stefansiegl/introscope-em:9.6.0.0