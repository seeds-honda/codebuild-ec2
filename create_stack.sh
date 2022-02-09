#!/bin/bash

START_CNT=$1
END_CNT=$2

for i in $(seq $START_CNT $END_CNT); do
    aws cloudformation create-stack --stack-name ec2-test-${i} --template-body file://runec2.yml --parameters ParameterKey=InstanceName,ParameterValue=ec2-test-${i}
done