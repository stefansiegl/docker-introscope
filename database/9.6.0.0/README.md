# docker-introscope-postgres
A docker (https://www.docker.com/) image build for the APM solution of Computer Asscociates (CA APM). This project build a docker image for a postgres database with the schema for Introscope 9.6.0.0. It is meant to be used in combination with the docker image docker-introscope-enterprisemanager (https://github.com/stefansiegl/docker-introscope-enterprisemanager).


## Building the image
Fire up docker (or like in my case boot2docker), navigate to the project and execute the 
```
build.sh 
```
file.

## Starting the image
If you just want the easiest solution, simply start the enterprise manager by
```
run-default-postgres-container.sh
```

## Access rights
This image is built with the idea that as the ports are not provided to the open (no -P flag for starting the container), it is ok to have the enterprise manager simply use the postgres user and the postgres schema to write data to.

## Persisting data
The image is configured persist some important folders, so that changes are persisted when you stop the container and start it again. (check the volume definitions in the dockerfile)
If you like you can also map local folders, but I dont like this approach as this hinders portability.

## Locking at the logs
As I said I do not like to map the logfiles to my host. docker is great at providing access to them already. What I usually do is to connect to the container with either
```
docker logs introscope-db (to see all system.out log output)
```
or even better to simply start a shell
```
docker exec -it em bash
```
