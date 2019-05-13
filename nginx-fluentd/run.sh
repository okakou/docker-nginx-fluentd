#!/bin/bash

/etc/init.d/nginx start
/etc/init.d/td-agent start

sleep 5

while ps -p `cat /var/run/nginx.pid` > /dev/null; do
  sleep 5
done
