#!/bin/bash

# Display the command line of the init process
cat /proc/1/cmdline

# Edit the crontab file to add the cron job
echo "*/2 * * * * /bin/bash -c 'date | tee /tmp/date_log'" | crontab -

