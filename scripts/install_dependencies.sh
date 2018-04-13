#!/bin/bash

yum install -y nodejs npm --enablerepo=epel
npm config set strict-ssl false
npm install