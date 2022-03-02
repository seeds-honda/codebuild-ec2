#!/bin/bash

START_CNT=$1
END_CNT=$2
AMI=$3

CHAR_START_CNT=$(expr "$START_CNT" : '\([0-9][0-9]*\)')
if [ "$START_CNT" != "$CHAR_START_CNT" ]; then
    echo "START_CNT変数に数値以外の文字が入っています"
    exit 1
fi

CHAR_END_CNT=$(expr "$END_CNT" : '\([0-9][0-9]*\)')
if [ "$END_CNT" != "$CHAR_END_CNT" ]; then
    echo "END_CNT変数に数値以外の文字が入っています"
    exit 1
fi

for i in $(seq $START_CNT $END_CNT); do
    aws cloudformation create-stack --stack-name ec2-test-${i} --template-body file://kpi_ec2.yml --parameters ParameterKey=AMI_ID,ParameterValue=${$3} ParameterKey=InstanceName,ParameterValue=ec2-test-${i}
done