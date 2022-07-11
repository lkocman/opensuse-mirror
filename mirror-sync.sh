#!/bin/bash

set -x

# https://en.opensuse.org/openSUSE:Mirror_howto

LOCK_FILE=/root/LOCK-opensuse-custom
EXCLUDE_LIST=/root/mirror-exclude.lst

# Public
#RSYNC_SERVER="rsync.opensuse.org"
#Stage
RSYNC_SERVER="stage.opensuse.org"

# You can override default module by passing variable to Dockerfile
# e.g mirror_module=opensuse-hotstuff-30gb
# List of modules
# https://github.com/openSUSE/opensuse-hotstuff/tree/main/etc/rsyncd.d

#MIRROR_MODULE=opensuse-full # ENV set in Dockerfile
DEST=/srv/pub
OPTS="--delete-after --delete-excluded --max-delete=4000 --timeout=1800 -hi"

/usr/bin/withlock $LOCK_FILE rsync -rlpt $RSYNC_SERVER::$MIRROR_MODULE  $DEST --exclude-from $EXCLUDE_LIST $OPTS
