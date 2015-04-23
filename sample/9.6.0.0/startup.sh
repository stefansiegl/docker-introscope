#!/bin/sh

# we need a special startup script, as we need to set the database within the configuration
# every time we start a container as the linked database could be changed.

# read the environment variable to set the correct IP we expect that the database container is linked.
# we store the original file to be able to apply the transformation again.
if [ ! -f IntroscopeEPAgent-orig.properties ]
	then
		cp /opt/introscope-epagent/epagent/IntroscopeEPAgent.properties IntroscopeEPAgent-orig.properties
fi
cp IntroscopeEPAgent-orig.properties /opt/introscope-epagent/epagent/IntroscopeEPAgent.properties

sed -i s/localhost/${EM_PORT_5001_TCP_ADDR}/g /opt/introscope-epagent/epagent/IntroscopeEPAgent.properties
sed -i s/5001/${EM_PORT_5001_TCP_PORT}/g /opt/introscope-epagent/epagent/IntroscopeEPAgent.properties

# now we correctly set everything and startup the epagent
cd /opt/introscope-epagent/epagent
java -cp lib/EPAgent.jar:lib/IntroscopeServices.jar:lib/Agent.jar:epaplugins/epaMQMonitor/epaMQMonitor.jar:epaplugins/epaMQMonitor:epaplugins/epaMQMonitor/lib/com.ibm.mq.pcf.jar:epaplugins/epaMQMonitor/lib/com.ibm.mq.jar:epaplugins/epaMQMonitor/lib/connector.jar:epaplugins/epaMQMonitor/lib/com.ibm.mqjms.jar com.wily.introscope.api.IntroscopeEPAgent
