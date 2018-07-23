#!/bin/sh
set -e

if [ "$SET_CRONJOB" == "1" ] && [ ! -z "$SCRIPT_FILENAME" ] && [ ! -z "$CRON_TIME_SETTING" ]; then
    chmod -Rf 750 /scripts/*; sync;

		crond

    crontab -l | { cat; echo "${CRON_TIME_SETTING} bash /scripts/${SCRIPT_FILENAME} >> /dev/null 2>&1"; } | crontab -
fi

if [ ! -z "$CRON_TAIL" ] 
then
	# crond running in background and log file reading every second by tail to STDOUT
	crond -s /var/spool/cron/crontabs -b -L /var/log/cron/cron.log "$@" && tail -f /var/log/cron/cron.log
else
	# crond running in foreground. log files can be retrive from /var/log/cron mount point
	crond -s /var/spool/cron/crontabs -f -L /var/log/cron/cron.log "$@"
fi