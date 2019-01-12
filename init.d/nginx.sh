#!/bin/bash
#
# chkconfig: - 85 15
# description: nginx startup script for the Nginx HTTP Server

EXEC=/usr/sbin/nginx
PIDFILE=/var/run/nginx.pid

case "$1" in
start)
    if [ -f $PIDFILE ]
    then
        echo "$PIDFILE exists, process is already running or crashed."
    else
        echo "Starting Nginx server..."
        $EXEC
        echo "Nginx is running..."
    fi
    ;;
stop)
    if [ ! -f $PIDFILE ]
    then
        echo "$PIDFILE not exists, process is not running."
    else
        PID=$(cat $PIDFILE)
        echo "Stopping Nginx server..."
        $EXEC -s quit
        while [ -x $PIDFILE ]
        do
            echo "Waiting for Nginx to shutdown..."
            sleep 1
        done
        echo "Nginx stopped"
    fi
    ;;
reload)
    if [ ! -f $PIDFILE ]
    then
        echo "$PIDFILE not exists, process is not running."
    else
        echo "Reloading Nginx server..."
        $EXEC -s reload
        echo "Nginx Reloaded"
    fi
    ;;
restart|force-reload)
    ${0} stop
    sleep 1
    ${0} start
    ;;
*)
    echo "Usage: /etc/init.d/redis {start|stop|reload|restart|force-reload}" >&2
    exit 1
    ;;
esac