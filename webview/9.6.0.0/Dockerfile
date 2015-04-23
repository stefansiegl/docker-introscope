FROM jeanblanchard/busybox-java:7

MAINTAINER sieglst@googlemail.com / stefan.siegl@novatec-gmbh.de

WORKDIR /opt/introscope-install

### For new Introscope version you must change the following variables
ENV INTROSCOPE_VERSION=9.6.0.0
### End for new Introscope version

ENV INTROSCOPE_HOME=/root/Introscope
ENV INTROSCOPE_BIN=introscope${INTROSCOPE_VERSION}otherUnix.jar
ENV INTROSCOPE_OSGI=osgiPackages.v${INTROSCOPE_VERSION}.unix.tar

ADD SampleResponseFile.Introscope.txt /opt/introscope-install/SampleResponseFile.Introscope.txt
ADD $INTROSCOPE_BIN /opt/introscope-install/$INTROSCOPE_BIN
# I learned the hard way that ADDing a tar file will extract it - not what we want here.
COPY $INTROSCOPE_OSGI /opt/introscope-install/$INTROSCOPE_OSGI
ADD eula-osgi/eula.txt /opt/introscope-install/eula-osgi/eula.txt
ADD eula-introscope/ca-eula.txt /opt/introscope-install/eula-introscope/ca-eula.txt
ADD startup.sh /opt/introscope-install/startup.sh

RUN chmod +x startup.sh

# run the installation of the enterprise manager
RUN java -jar $INTROSCOPE_BIN -f SampleResponseFile.Introscope.txt

# Port on which WebView will listen for HTTP connections.
EXPOSE 8080

CMD /opt/introscope-install/startup.sh
