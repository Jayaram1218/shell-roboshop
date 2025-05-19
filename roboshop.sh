#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"

SG_ID="sg-09c5879652d3b90ca"

INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")  

ZONE_ID="Z07063993EURP4DSS6BCF"
DOMAIN_NAME="daws1217.site"

for instance in ${INSTANCES[@]}

do
    
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-09c5879652d3b90ca --tags-specifications "ResourceType=instance, Tags=[{ Key=Name, value=$instance}]" --query "Instances[0].InstanceId" --output text)

     if[ $instance !="fronend" ]

     then

     IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)

     else

         IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instance IP address is:: $IP

done
