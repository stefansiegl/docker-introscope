#/bin/sh

introscopeinstallfile="EPAgent9.6.0.0unix.tar"
errors=false

if [ ! -e $introscopeinstallfile ] ; then
	echo "FATAL: File $introscopeinstallfile does not exist. Please provide this file before building the image"
	errors=true
fi

if [ "$errors" = false ] ; then
	echo "Starting the build"
	sudo docker build -t stefansiegl/introscope-sample .
fi
