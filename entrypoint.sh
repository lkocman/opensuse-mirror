#!/bin/sh

# Start cron daemon.
cron

# Start application.
nginx -g 'daemon off;'
