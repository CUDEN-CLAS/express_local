#!/bin/bash
# selenium - this script starts and stops Xvfb
#
# chkconfig:   - 85 15
# description: Xvfb
# processname: Xvfb
# pidfile:    /var/log/Xvfb/Xvfb.pid

# Source function library.
. /etc/rc.d/init.d/functions

#selenium_dir=/usr/lib/selenium
log_dir=/var/log/Xvfb
error_log=$log_dir/Xvfb_error.log
std_log=$log_dir/Xvfb_std.log
pid_file=/var/log/selenium/Xvfb.pid
java=/usr/bin/java
xvfb=$( which Xvfb )
user=screener

start() {
    if test -f $pid_file
    then
        PID=`cat $pid_file`
        if  ps --pid $PID &gt;/dev/null;
            then
                echo "Xvfb is already running: $PID"
                exit 0
            else
                echo "Removing stale pid file: $pid_file"
        fi
    fi

    echo -n "Starting Xvfb..."
    su $user -c "$xvfb :99 -ac -screen 0 1280x1024x24 -nolisten tcp &gt;$std_log 2&gt;$error_log &amp;"

    if [ $? == "0" ]; then
        success
    else
        failure
    fi
    echo
    ps  -C Xvfb -o pid,cmd | grep Xvfb  | awk {'print $1 '} &gt; $pid_file
}

stop() {
    if test -f $pid_file
    then
        echo -n "Stopping Xvfb..."
        PID=`cat $pid_file`
        su $user -c "kill -15 $PID"
        if kill -9 $PID ;
                then
                        sleep 2
                        test -f $pid_file &amp;&amp; rm -f $pid_file
                        success
                else
                        echo "Xvfb could not be stopped..."
                        failure
                fi
    else
            echo "Xvfb is not running."
            failure
    fi
    echo
}

status() {
    if test -f $pid_file
    then
        PID=`cat $pid_file`
        if  ps --pid $PID &gt;/dev/null ;
        then
            echo "Xvfb is running...$PID"
        else
            echo "Xvfb isn't running..."
        fi
    else
            echo "Xvfb isn't running..."
    fi
}

case "$1" in
    start)
        $1
        ;;
    stop)
        $1
        ;;
    restart)
        stop
        start
        ;;
    status)
        $1
        ;;
    *)
        echo "Usage: $SELF start|stop|restart|status"
        exit 1
    ;;
esac
