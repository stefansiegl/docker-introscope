#!/bin/sh

# we need a special startup script, as we need to set the database within the configuration
# every time we start a container as the linked database could be changed.

# read the environment variable to set the correct IP we expect that the database container is linked.
# we store the original file to be able to apply the transformation again.
if [ ! -f tess-db-cfg-orig.xml ]
	then
		cp /root/Introscope9.6.0.0/config/tess-db-cfg.xml tess-db-cfg-orig.xml
fi
cp tess-db-cfg-orig.xml /root/Introscope9.6.0.0/config/tess-db-cfg.xml
sed -i s/DATABASE_URL/${DB_PORT_5432_TCP_ADDR}/g /root/Introscope9.6.0.0/config/tess-db-cfg.xml

# install addons
if [ -d /opt/introscope-install/addons/em ] ; then
	cp /opt/introscope-install/addons/em/* /root/Introscope9.6.0.0/product/enterprisemanager/plugins
fi
if [ -d /opt/introscope-install/addons/workstation ] ; then
	cp /opt/introscope-install/addons/workstation/* /root/Introscope9.6.0.0/ws-plugins
fi

# copy management modules from linked volume
if [ -d /transfer/modules ] ; then
	cp /transfer/modules/*.jar /root/Introscope9.6.0.0/config/modules
fi

# copy provided license
if [ -d /transfer/license ] ; then
	cp /transfer/license/* /root/Introscope9.6.0.0/license
fi

# now we correctly set everything and startup the enterprise manager.
/root/Introscope9.6.0.0/Introscope_Enterprise_Manager