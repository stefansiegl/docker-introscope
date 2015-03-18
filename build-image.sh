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

if [ ! -e license.lic ] ; then
	echo "FATAL: Please provide a license.lic file. The EM starts without a license, so if you do not need any, just remove this line and remove the adding of the license in the dockerfile."
	errors=true
fi

if [ "$errors" = false ] ; then
	echo "Starting the build"
	docker build -t stefansiegl/introscope-em:9.6.0.0 .
fi
