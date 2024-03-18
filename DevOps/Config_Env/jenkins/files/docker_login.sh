#!/bin/bash

DOCKER_USER=devopsuser62

<<<<<<< HEAD
DOCKER_PASS=`cat /tmp/.passwd`
=======
DOCKER_PASS=CLOUDArchitect@1989
>>>>>>> 7141c9c (Updates)

docker login --username=$DOCKER_USER --password=$DOCKER_PASS $DOCKER_HOST
