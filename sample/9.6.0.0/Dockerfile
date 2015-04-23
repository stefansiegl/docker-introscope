FROM jeanblanchard/busybox-java:7

MAINTAINER sieglst@googlemail.com / stefan.siegl@novatec-gmbh.de

### For new Introscope version you must change the following variables
ENV INTROSCOPE_VERSION=9.6.0.0
### End for new Introscope version

WORKDIR /opt/install

ADD EPAgent${INTROSCOPE_VERSION}unix.tar /opt/introscope-epagent
ADD IntroscopeEPAgent.properties /opt/introscope-epagent/epagent/
ADD readFilesytemSpace.sh /opt/introscope-epagent/epagent/epaplugins/readFilesytemSpace.sh
ADD startup.sh /opt/install/startup.sh

RUN chmod +x startup.sh
RUN chmod +x /opt/introscope-epagent/epagent/epaplugins/readFilesytemSpace.sh

CMD /opt/install/startup.sh
