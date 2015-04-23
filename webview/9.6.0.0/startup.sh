#!/bin/sh

# we need a special startup script, as we need to set the enterprise manager the webview is linked to
# we store the original file to be able to apply the transformation again.
if [ ! -f IntroscopeWebView-orig.properties ]
	then
		cp ${INTROSCOPE_HOME}/config/IntroscopeWebView.properties IntroscopeWebView-orig.properties
fi
cp IntroscopeWebView-orig.properties ${INTROSCOPE_HOME}/config/IntroscopeWebView.properties
sed -i s/EM_HOST_MARKER/${EM_PORT_5001_TCP_ADDR}/g ${INTROSCOPE_HOME}/config/IntroscopeWebView.properties
sed -i s/EM_PORT_MARKER/${EM_PORT_5001_TCP_PORT}/g ${INTROSCOPE_HOME}/config/IntroscopeWebView.properties

# now we correctly set everything and startup the enterprise manager.
${INTROSCOPE_HOME}/Introscope_WebView