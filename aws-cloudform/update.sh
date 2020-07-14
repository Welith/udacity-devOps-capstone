#!/bin/bash

aws cloudformation update-stack --region=us-west-2 --stack-name $1 --template-body file://$1.yml --parameters file://$1-parameters.json --capabilities CAPABILITY_IAM
