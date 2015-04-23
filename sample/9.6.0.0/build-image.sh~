#/bin/sh

introscopeinstallfile="introscope9.6.0.0otherUnix.jar"
osgipackages="osgiPackages.v9.6.0.0.unix.tar"
errors=false

if [ ! -e $introscopeinstallfile ] ; then
	echo "FATAL: File $introscopeinstallfile does not exist. Please provide this file before building the image"
	errors=true
fi

if [ ! -e $osgipackages ] ; then
	echo "FATAL: File $osgipackages does not exist. Please download this from http://opensrcd.ca.com/ips/osgi/introscope_9.6.0.0/"
	errors=true
fi

if [ "$errors" = false ] ; then
	echo "Starting the build"
	sudo docker build -t stefansiegl/introscope-em .
fi
