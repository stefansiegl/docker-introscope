#!/bin/bash
# This runs a container in default mode. Note that this expects that the sieglstefan/introscope-postgres already is started

docker run -d --name introscope-em --link introscope-db:db stefansiegl/introscope-em:9.6.0.0
