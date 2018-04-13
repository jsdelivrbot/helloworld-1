#!/bin/bash -ex

app_home=/opt/sites/helloworld

mkdir $app_home -p


yum -y update
yum install -y nodejs npm --enablerepo=epel
yum -y groupinstall development

cd $app_home

cp -R /tmp/codedeploy-deployment/helloworld.zip $app_home/.

cd $app_home

unzip helloworld

mv helloworld.service /etc/init.d/helloworld
npm config set strict-ssl false
npm install

chown -R ec2-user:ec2-user $app_home


chmod +x /etc/init.d/helloworld
chkconfig helloworld on

rm $app_home/helloworld -rf

