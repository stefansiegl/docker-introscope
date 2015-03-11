# docker-introscope-enterprise manager
A docker (https://www.docker.com/) image build for the APM solution of Computer Asscociates (CA APM). This project build a docker image for an Introscope enterprise manager in version 9.6.0.0. It is meant to be used in combination with the docker image docker-introscope-postgres (https://github.com/stefansiegl/docker-introscope-postgres), which provides the database for the enterprise manager.

Note that due to licensing reasons, it is not possible to package the installation files and the license in this image. Please read the usage which file you have to put where.

## Necessary configuration prior to building
The docker image needs the installation files from CA Wily Introscope. Simply copy the files:
- introscope9.6.0.0otherUnix.jar (installer of the enterprise manager)
- osgiPackages.v9.6.0.0.unix.tar (osgi packages that you can download from http://opensrcd.ca.com/ips/osgi/introscope_9.6.0.0/)
- license.lic (I noticed that the enterprise manager can start without a license, but you are expected to put one here)

It goes without saying that you need docker installed. If you are on Windows (like me) or Mac, you can use boot2docker - I works perfectly for me.

## Building the image
Fire up docker (or like in my case boot2docker), navigate to the project and execute the 
```
build.sh
```
file.

## Starting the image
If you just want the easiest solution, simply start the enterprise manager by
```
run-default-em-container.sh
```
This image is expected to be connected to a container of stefansiegl/introscope-postgres:9.6.0.0 that will provide the database for the enterprise manager. Furthermore, the image expects that a docker link --link is setup with the logical name being set to "db". 
```
docker run -d --name introscope-em --link introscope-db:db stefansiegl/introscope-em:9.6.0.0
```

## Persisting data
The image is configured persist some important folders, so that changes are persisted when you stop the container and start it again. (check the volume definitions in the dockerfile)
If you like you can also map local folders, but I dont like this approach as this hinders portability. (just have a look inside the Dockerfile and bind the folders that you need)

## Locking at the logs
As I said I do not like to map the logfiles to my host. docker is great at providing access to them already. What I usually do is to connect to the container with either
```
docker logs em (to see all system.out log output)
```
or even better to simply start a shell
```
docker exec -it em bash
```

## Default values
Check the checked-in response file for the default settings the introscope enterprise manager is installed with and adapt it to your needs. 
Please note that the database settings are set in a way that this image is interoperable with stefansiegl/introscope-postgres, so be careful when changing this. Especially note that the file write DATABASE_URL for the database. This string is replaced during startup of the enterprise manager and substituted by the linked stefansiegl/introscope-postgres container.
