#!/bin/bash

stack_number=$1

for i in $(seq 1 $stack_number); do
    #aws cloudformation create-stack --stack-name ec2-test-${i}-1 --template-body file://runec2.yml --parameters ParameterKey=InstanceName,ParameterValue=ec2-test-${i}
    echo $i
done