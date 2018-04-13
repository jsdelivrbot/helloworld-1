#!/bin/bash

app_home=/opt/sites/helloworld

mkdir $app_home -p
chown ec2-user:ec2-user $app_home

yum -y update
yum install -y nodejs npm --enablerepo=epel
yum -y groupinstall development

cd $app_home/helloworld
npm config set strict-ssl false
npm install