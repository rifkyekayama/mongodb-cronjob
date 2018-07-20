#!/bin/bash

# Run custom scripts
if [[ "$RUN_SCRIPTS" == "1" ]] ; then
  if [ -d "/scripts/" ]; then
    # make scripts executable incase they aren't
    chmod -Rf 750 /scripts/*; sync;
    # run scripts in number order
    for i in `ls /scripts/`; do /scripts/$i ; done
  else
    echo "Can't find script directory"
  fi
fi

if [[ "$SET_CRONJOB" == "1" ] && [ ! -z "$SCRIPT_FILENAME" ] && [ ! -z "$CRON_TIME_SETTING" ]]; then
    chmod -Rf 750 /scripts/*; sync;

    crontab -l | { cat; echo "${CRON_TIME_SETTING} bash /script/${SCRIPT_FILENAME} >> /dev/null 2>&1"; } | crontab -
    crond
fi