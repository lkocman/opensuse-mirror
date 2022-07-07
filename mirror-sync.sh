#!/bin/bash

# https://en.opensuse.org/openSUSE:Mirror_howto

LOCK_FILE=/home/mirror/LOCK-opensuse-custom
EXCLUDE_LIST=/home/mirror/mirror-exclude.lst
MODULE=opensuse-full
DEST=/srv/pub
OPTS="--delete-after --delete-excluded --max-delete=4000 --timeout=1800 -hi"

/usr/bin/withlock $LOCKFILE rsync -rlpt rsync.opensuse.org::$MODULE  $DEST --exclude-from $EXCLUDE_LIST $OPTS
