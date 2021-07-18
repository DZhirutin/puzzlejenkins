#!/usr/bin/env bash

export IMAGE=$1
docker ps --filter status=running -q | xargs docker rm -f
docker-compose -f docker-compose.yaml up --detach
echo "success"
