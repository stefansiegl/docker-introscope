FROM jeanblanchard/busybox-java:7

MAINTAINER sieglst@googlemail.com / stefan.siegl@novatec-gmbh.de

WORKDIR /opt/introscope-install

ADD SampleResponseFile.Introscope.txt /opt/introscope-install/SampleResponseFile.Introscope.txt
ADD introscope9.6.0.0otherUnix.jar /opt/introscope-install/introscope9.6.0.0otherUnix.jar
# I learned the hard way that ADDing a tar file will extract it - not what we want here. 
COPY osgiPackages.v9.6.0.0.unix.tar /opt/introscope-install/osgiPackages.v9.6.0.0.unix.tar
ADD eula-osgi/eula.txt /opt/introscope-install/eula-osgi/eula.txt
ADD eula-introscope/ca-eula.txt /opt/introscope-install/eula-introscope/ca-eula.txt
ADD startup.sh /opt/introscope-install/startup.sh
ADD addons /opt/introscope-install/addons

RUN chmod +x startup.sh

# run the installation of the enterprise manager
RUN java -jar introscope9.6.0.0otherUnix.jar -f SampleResponseFile.Introscope.txt

# we expect to have a license file that we can copy to the server. 
ADD license.lic /root/Introscope9.6.0.0/license/license.lic

ENV HEAP_XMX **DEFAULT**

# Port used by Enterprise Manager to listen for incoming connections.
EXPOSE 5001
# Port used by Enterprise Manager to serve web applications.
EXPOSE 8081
# Port on which WebView will listen for HTTP connections. 
EXPOSE 8080

VOLUME /root/Introscope9.6.0.0/data
VOLUME /root/Introscope9.6.0.0/traces

CMD /opt/introscope-install/startup.sh