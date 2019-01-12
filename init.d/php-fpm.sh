#!/bin/bash
#
# chkconfig: - 85 15
# description: php-fpm startup script for the php-fp EXEC

EXEC=/usr/local/sbin/php-fpm
CONFIGFILE=/usr/local/etc/php-fpm.conf
PIDFILE=/usr/local/var/run/$php-fpm.pid

case "$1" in
start)
    if [ -f $PIDFILE ]
    then
        echo "$PIDFILE exists, process is already running or crashed."
    else
        echo "Starting php-fpm..."
        $EXEC -y $CONFIGFILE
        echo "php-fpm is running..."
    fi
    ;;
stop)
    if [ ! -f $PIDFILE ]
    then
        echo "$PIDFILE exists, process is not running."
    else
        echo "Stopping php-fpm..."
        kill -INT `cat $PIDFILE`
        while [ -x $PIDFILE ]
        do
            echo "Waiting for php-fpm to shutdown..."
            sleep 1
        done
        echo "php-fpm stopped"
    fi
    ;;
reload)
    if [ ! -f $PIDFILE ]
    then
        echo "$PIDFILE not exists, process is not running."
    else
        echo "Reloading php-fpm server..."
        $EXEC -s kill -USR2 `cat $PIDFILE`
        echo "php-fpm Reloaded"
    fi
    ;;
restart|force-reload)
    ${0} stop
    sleep 2
    ${0} start
    ;;
*)
    echo "Usage: /etc/init.d/php-fpm {start|stop|reload|restart|force-reload}" >&2
    exit 1
    ;;
esac