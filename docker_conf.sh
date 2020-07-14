#!/bin/bash

docker build --tag valentinburk/$1:$2 .
echo "Image successfully built and tagged with valentinburk/$1:$2. Pushing to hub"

docker login
echo "Logged in successfully"

docker push valentinburk/$1:$2
echo "Pushed successfully"