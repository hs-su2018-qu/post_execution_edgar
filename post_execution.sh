#!/bin/bash

# This file would be responsible to get the name of the 
# only running container, and execute a bash script inside that container.
# Notes:
# 1. There should be just 1 *running* container. 
# 2. if the run.sh script is not found, nothing will be executed. 

# If the container was not running, then the variable will be empty. 

if [ -x "$(command -v docker)" ]; then 
	# Try to fetch the name of a container.
	CONTAINER_NAME=$(sudo docker ps --format {{.Names}})

	echo "The name of the container is : $CONTAINER_NAME"

	if [ -z "$CONTAINER_NAME" ]; then
		echo "No container was running, hence exiting"
	else
		echo "A container was running, if the run.sh is found in the working directory, it will be executed."
		sudo docker exec $CONTAINER_NAME /bin/sh -c 'if [ -f run.sh ]; then (sh run.sh) fi'
		echo "executed the run.sh script"
	fi
else	
	echo "Docker is not installed!"
fi

echo "Executed!"