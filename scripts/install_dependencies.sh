#!/bin/bash

app_home=/opt/sites/helloworld

mkdir $app_home -p


yum -y update
yum install -y nodejs npm --enablerepo=epel
yum -y groupinstall development

cd $app_home

git clone https://github.com/warpedcodemonkey/helloworld.git

cd $app_home/helloworld


npm config set strict-ssl false
npm install

chown -R ec2-user:ec2-user $app_home


cat <<EOF > /etc/init.d/helloworld
#!/bin/sh
### BEGIN INIT INFO
# Provides:          HelloWorldApp
# Required-Start:    \$local_fs \$network \$named \$time \$syslog
# Required-Stop:     \$local_fs \$network \$named \$time \$syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       Hello World App
### END INIT INFO


start() {
  cd /opt/sites/helloworld/helloworld
  ./helloworld-start.sh
  echo 'Service started' >&2
}

stop() {
  kill -9 $(ps -ef | awk '/[n]ode index.js/{print $2}')
  echo 'Service stopped' >&2
}


case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  retart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
esac
EOF

chmod +x /etc/init.d/helloworld
chkconfig helloworld on

