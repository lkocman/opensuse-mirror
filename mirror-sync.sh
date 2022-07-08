#!/bin/bash

set -x

# https://en.opensuse.org/openSUSE:Mirror_howto

LOCK_FILE=/root/LOCK-opensuse-custom
EXCLUDE_LIST=/root/mirror-exclude.lst
MODULE=opensuse-full
DEST=/srv/pub
OPTS="--delete-after --delete-excluded --max-delete=4000 --timeout=1800 -hi"

/usr/bin/withlock $LOCKFILE rsync -rlpt rsync.opensuse.org::$MODULE  $DEST --exclude-from $EXCLUDE_LIST $OPTS
