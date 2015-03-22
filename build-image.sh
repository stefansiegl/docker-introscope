#/bin/sh

introscopeinstallfile=`ls *otherUnix.jar`
osgipackages=`ls osgi*.unix.tar`
errors=false

if [ ! -e $introscopeinstallfile ] ; then
	echo "FATAL: File $introscopeinstallfile does not exist. Please provide this file before building the image"
	errors=true
fi

if [ ! -e $osgipackages ] ; then
	echo "FATAL: File $osgipackages does not exist. Please download this from http://opensrcd.ca.com/ips/osgi/introscope_X.Y.0.0/"
	errors=true
fi

if [ "$errors" = false ] ; then
	echo "Starting the build"
	docker build -t stefansiegl/introscope-em .
fi
