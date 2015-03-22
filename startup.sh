#!/bin/sh


# we need a special startup script, as we need to set the database within the configuration
# every time we start a container as the linked database could be changed.

# read the environment variable to set the correct IP we expect that the database container is linked.
# we store the original file to be able to apply the transformation again.
if [ ! -f tess-db-cfg-orig.xml ]
	then
		cp $INTROSCOPE_HOME/config/tess-db-cfg.xml tess-db-cfg-orig.xml
fi
cp tess-db-cfg-orig.xml $INTROSCOPE_HOME/config/tess-db-cfg.xml
sed -i s/DATABASE_URL/${DB_PORT_5432_TCP_ADDR}/g $INTROSCOPE_HOME/config/tess-db-cfg.xml

# install addons
if [ -d /opt/introscope-install/addons/em ] ; then
	cp /opt/introscope-install/addons/em/* $INTROSCOPE_HOME/product/enterprisemanager/plugins
fi
if [ -d /opt/introscope-install/addons/workstation ] ; then
	cp /opt/introscope-install/addons/workstation/* $INTROSCOPE_HOME/ws-plugins
fi

# copy management modules from linked volume
if [ -d /transfer/modules ] ; then
	cp /transfer/modules/*.jar $INTROSCOPE_HOME/config/modules
fi

# copy provided license
if [ -d /transfer/license ] ; then
	cp /transfer/license/* $INTROSCOPE_HOME/license
fi

# configure the heap
if [ "${HEAP_XMX}" == "**DEFAULT**" ] ; then
	unset HEAP_XMX
fi
if [ -n "${HEAP_XMX}" ] ; then
	sed -i s/Xmx1024m/Xmx${HEAP_XMX}/g $INTROSCOPE_HOME/Introscope_Enterprise_Manager.lax
fi



# now we correctly set everything and startup the enterprise manager.
$INTROSCOPE_HOME/Introscope_Enterprise_Manager
