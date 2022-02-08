#!/bin/bash

stack_number=$1

for i in $stack_number; do
    aws cloudformation create-stack --stack-name ec2-test-${i} --template-body file://runec2.yml --parameters ParameterKey=InstanceName,ParameterValue=ec2-test-${i}
done