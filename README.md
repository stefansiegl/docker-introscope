# Docker for CA Wily Introscope
This project hosts docker (https://www.docker.com/) images build for the APM solution of Computer Asscociates (CA APM).

### Supported components & versions
- Introscope Enterprise Manager (Standalone Mode, MOM Mode, Collector Mode, Cross-cluster viewer Mode)
- Introscope WebView
- Introscope Enterprise Manager database using Postgresql
- An Introscope sample application (small EPAgent) for demonstration purposes

Currently only Introscope version 9.6 is supported as this is the version we are using at the customer project I am currently consulting. But the structure is meant to be extended with additional versions. Please feel free to contribute newer versions.

The current idea is to have single-process containers, thus the enterprise manager database and the web interface are own images. As docker containers are very light-weight, this is no overhead.

## Quick start with docker-compose
1. place the Introscope binaries into the folders. The enterprise manager projects need "introscope9.6.0.0otherUnix.jar" and "osgiPackages.v9.6.0.0.unix.tar".

2. Run "sudo docker-compose -f docker-compose-sample.yml up". This will start a demonstration environment with one enterprise manager, a database, a webview and a small sample application that delivers some metrics.

3. Access the introscope webview at localhost:8080

## Quick start without docker-compose
Without docker-compose you have to build the images and run the containers yourself.

1. Place the introscope dependencies (see Quick start with docker-compose step 1)

2. Manually build all images. You can use the shell script "create-images-9.6.0.0.sh"

3. Start the default database container by ./database/9.6.0.0/run-default-postgres-container.sh

4. Start the enterprise manager container by ./enterprise-manager/9.6.0.0/run-default-em-container.sh

5. Start the sample application container by ./sample/9.6.0.0/run-default-sample-container.sh

6. Start the web view container by ./webview/9.6.0.0/run-default-webview-container.sh

7. Access the introscope webview at localhost:8080

## Using docker-compose

The project already provides many docker-compose definition files. Each definition file describes its use case. If you need to manage a bigger environment docker-compose might be exactly the thing to look for.

## The Enterprise Manager image

### Configuring the Enterprise manager mode
The docker image supports to start an enterprise manager as Standalone, as Collector, as MOM or as CDV. Use the environment variable "CLUSTER_ROLE" and set it to "CDV", "MOM", "Collector" or "Standalone" (with standalone being the default).

### Linking Collectors
For MOMs and CDVs it is necessary to configure the collectors that they are referring to. This is realized by Docker links.

As the enterprise manager also links its database via docker links, collectors being linked need to be differentiated. This is currently realized by having a naming scheme for collector links. For each collector link, the link alias needs to be in the format em[number], where number starts with 1 and is a continuously increasing integer.

Have a look at the docker-compose-CDV file for an example of how to name the linked collectors:

```
cdv:
  build: enterprise-manager/9.6.0.0
  links:
    - cdvdb:db
    - collector1:em1
    - collector2:em2
  environment:
    - HEAP=1024m
    - CLUSTER_ROLE=CDV
```


### Configuring the management module location

There are two ways to manage management modules with this image. The quick approach is to "mount" a local folder that is then used as management module folder. Drawback of this approach is, that the local folder overwrites the management module folder of the enterprise manager. So you need to place the out-of-the-box management modules in this folder as well.

```
docker run -d --name introscope-em --link introscope-db:db -v [localfolder]:/root/Introscope/config/modules stefansiegl/introscope-em:9.6.0.0
```

The second approach allows to add management modules to the existing config/modules folder. The startup script of the container ensures that all files that are within /transfer/modules (in the container) are copied to the config/modules folder. Thus you could keep the management modules you want to integrate locally in a folder and run the container like this (note that the management modules you copied to the container are persisted):

```
docker run -d --name introscope-em --link introscope-db:db -v [localfolder_containing_MM]:/transfer/modules stefansiegl/introscope-em:9.6.0.0
```

### Installing Plugins
The enterprise manager allows to install additional plugins. This image allows this during the build. Simply place your extensions in the folder addons/em and addons/workstation.

### Additional configuration with environment variables
Additional configuration is possible with environment variables. This image currently supports the following:

ENV | description | default | example
---|---|---|---|
HEAP_XMX | sets the xmx heap of the EM. Use typical Java notation. | 1024m | 2048m

Environment variables can be set for example by

```
-e HEAP_XMX="2048m"
```

Topic | description
---|---|
Binaries | Place introscope[version]otherUnix.jar (example: introscope9.6.0.0otherUnix.jar) and osgiPackages.[version].unix.tar (example: osgiPackages.v9.6.0.0.unix.tar) in the folder
Build    | Execute build-image.sh
Run      | Execute run-default-em-container.sh (or use docker-compose - recommended)

## Enterprise Manager database image

This image is built with the idea that the ports are not provided to the open (no -P flag for starting the container). Docker links will allow the enterprise manager to access the database nonetheless.

Data is currently written to the "postgres" schema with the postgres user. As nobody else should use this database I expect this to be fine and it makes it easier for me as I did not have to create users and schematas.

Topic | description
---|---|
Binaries | -
Build    | Execute build-image.sh
Run      | Execute run-default-postgres-container.sh (or use docker-compose - recommended)

## WebView image

Basically this image mirrors the enterprise manager in many ways. I figured that it might be easier to have this as a separate image and not within the enterprise-manager image as this would complicate the scripts.

Topic | description
---|---|
Binaries | Place introscope[version]otherUnix.jar (example: introscope9.6.0.0otherUnix.jar) and osgiPackages.[version].unix.tar (example: osgiPackages.v9.6.0.0.unix.tar) in the folder
Build    | Execute build-image.sh
Run      | Execute run-default-webview-container.sh (or use docker-compose - recommended)

## Sample image

This is really just a very small EPAgent sample application. I included this, as I want to have a sample application for testing purposes. So I thought why not put it here as well.

Topic | description
---|---|
Binaries | Place EPAgent[version]unix.tar (example: EPAgent9.6.0.0unix.tar) in the folder
Build    | Execute build-image.sh
Run      | Execute run-default-sample-container.sh (or use docker-compose - recommended)


## Locking at the data inside the containers (e.g. logs)
If you like you can also map local folders (volumes), but I dont like this approach as this hinders portability, and most of the time it is not even necessary, as docker is great at providing access to them already. What I usually do is to connect to the container with either
```
docker logs [container-name] (to see all log output written to system out)
```

or you can even get our own shell on the container by

```
docker exec -it [container-name] /bin/sh
```


## Legal notice: binaries not included
As Introscope is commercial software I cannot provide fully-built images. Also this project cannot provide the binaries for building the images. But the addition of the binaries is a piece of cake.
