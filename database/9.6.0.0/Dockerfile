FROM postgres

MAINTAINER sieglst@googlemail.com / stefan.siegl@novatec-gmbh.de

# As defined in https://github.com/docker-library/docs/tree/master/postgres
# we can extend postgres image by
# If you would like to do additional initialization in an image derived from this one, 
# add a *.sh script under /docker-entrypoint-initdb.d (creating the directory if necessary).
# After the entrypoint calls initdb to create the default postgres user and database, 
# it will source any *.sh script found in that directory to do further initialization 
# before starting the service. If you need to execute SQL commands as part of your 
# initialization, the use of Postgres'' single user mode is highly recommended.

COPY scripts/ scripts/

COPY createInstallDatabasesForIntroscope.sh createInstallDatabasesForIntroscope.sh

# This script creates our initialization and moves this file to the initdb.d folder
# we do this during docker build as we use quite some linux shell commands, and as some of us
# use windows, we do want to use the same way of building.
RUN chmod +x createInstallDatabasesForIntroscope.sh
RUN ./createInstallDatabasesForIntroscope.sh
