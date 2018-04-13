#!/bin/bash -x

HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 3 -q -s http://169.254.169.254/latest/meta-data/local-ipv4/`

if [ "$HTTP_CODE" == "200" ]; then
	echo 'running at aws, therefore will use /opt/sites/tomcat-api'
    TOMCAT_HOME=/opt/sites/tomcat-api
    . $(dirname $0)/deregister_from_elb.sh
    exit 0;
else
	echo 'running on-premises, therefore will use /var/sites/tomcat-api'
	TOMCAT_HOME=/var/sites/tomcat-api
	exit 0;
fi