#!/bin/bash

## 引数
START_CNT=$1
END_CNT=$2
AMI=$3
INSTANCETYPE=$4

## 起動確認するインスタンスネーム
INSTANCENAME=ec2-test-

CHAR_START_CNT=$(expr "$START_CNT" : '\([0-9][0-9]*\)')
if [ "$START_CNT" != "$CHAR_START_CNT" ]; then
    echo "START_CNT変数に数値以外の文字が入っています"
    exit 1
    elif (( $START_CNT == 0 )); then
        START_CNT=1
fi

CHAR_END_CNT=$(expr "$END_CNT" : '\([0-9][0-9]*\)')
if [ "$END_CNT" != "$CHAR_END_CNT" ]; then
    echo "END_CNT変数に数値以外の文字が入っています"
    exit 1
fi

for i in $(seq $START_CNT $END_CNT); do
    EXITING_CNT=`aws ec2 describe-instances --filter "Name=tag:Name,Values=${INSTANCENAME}0${i}" "Name=instance-state-name,Values=running" | jq -r .Reservations[].Instances[].InstanceId | wc -l`
    if (( $EXITING_CNT == 0 )); then
        aws cloudformation create-stack --stack-name ec2-test-0${i} --template-body file://kpi-ec2.yml \
        --parameters ParameterKey=InstanceName,ParameterValue=ec2-test-0${i} \
        ParameterKey=AMIID,ParameterValue=${AMI} \
        ParameterKey=InstanceType,ParameterValue=${INSTANCETYPE} \
        --capabilities CAPABILITY_NAMED_IAM
    else
        echo "インスタンス：${INSTANCENAME}0${i}は既に作成されています。"
    fi
done