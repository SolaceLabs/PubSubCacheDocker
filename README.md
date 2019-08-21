# SolCache for Docker

This repository contains the scripts required to create a Docker image that runs [PubSub+ Cache](https://docs.solace.com/Solace-PubSub-Cache/PubSub-Cache-Overview.htm).

## Preparation

See the instructions on [Installing PubSub+ Cache](https://docs.solace.com/Solace-PubSub-Cache/Installing-PubSub-Cache.htm) for obtaining the PubSub+ Cache software. This is provided in the form of a zipped tar file. Copy the tar file to the build-dir subdirectory.

This also requires the PubSub+ C Language client. Download the Linux 2.6 x64 from the [Solace Downloads Page](https://solace.com/downloads/) and copy it to the build-dir subdirectory.

Edit the config/config.txt file, entering the connection information to a PubSub+ broker that has been configured to use PubSub+ Cache. This file was copied from the sample config file included with PubSub+ Cache version 1.0.6, and it has been modified to send logging output to stdout rather than syslog.

## Building the image

There are two ways to build the image.

### Modifying the Dockerfile

Edit the Dockerfile and change the lines containing CACHE_FILENAME and SOLCLIENT_FILENAME to match the 
filenames you downloaded. Then run the ```build``` script.

### Using Build Args

The other way to build the image is to run

```
export DOCKER_CONTENT_TRUST=1
docker build -t solcache:latest --file=Dockerfile --build-arg CACHE_FILENAME=SolaceCache_Linux26-x86_64_opt_1.0.6.tar.gz --build-arg SOLCLIENT_FILENAME=solclient_Linux26-x86_64_opt_7.11.08.tar.tz build-dir```

## Running the image

To run the image, run the ```run``` script. It will start the container and run it in the forground. Press ctrl-C to stop the container.

The config file is made available to the container using a mounted volume, it is not built into the image.

## Security Considerations

The following security best practices were observed in writing the Dockerfile:

* It is based on an official trusted base image, Centos 7.
* The build script uses the DOCKER_CONTENT_TRUST environment variable.
* A user is created in the container, and the executable is owned and run by that user.
* The Dockerfile does not use the ADD command to fetch remote files.
* No secrets are stored in the image or the Dockerfile.

