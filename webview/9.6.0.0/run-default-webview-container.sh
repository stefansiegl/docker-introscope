#!/bin/sh
# This runs a container in default mode. Note that this expects that the sieglstefan/introscope-em already is started

docker run -d --name introscope-webview -p 8080:8080 --link introscope-em:em stefansiegl/introscope-webview

