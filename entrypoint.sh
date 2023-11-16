#!/bin/sh

# Start cron daemon for daily refreshes
cron

# Initial sync if dir is empty, mirror-sync is using withlock to keep just one process
[ "$(ls -A /srv/pub/opensuse)" ] && echo "Skipping sync tree is not empty." || (/root/mirror-sync.sh &)

# Start application.
exec "/usr/sbin/nginx -g 'daemon off;'"
