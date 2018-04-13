#!/bin/bash -x

HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 3 -q -s http://169.254.169.254/latest/meta-data/local-ipv4/`

if [ "$HTTP_CODE" == "200" ]; then
	echo 'running at aws, therefore will load register_with_elb.sh'
    . $(dirname $0)/register_with_elb.sh
    exit 0;
fi