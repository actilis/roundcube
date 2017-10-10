#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

genpasswd() {
    export LC_CTYPE=C  # Quiet tr warnings
    local l=$1
    [ "$l" == "" ] && l=16
    cat /dev/urandom | tr -dc A-Za-z0-9_ | head -c ${l}
}
export DES_KEY=$(genpasswd 24)


# Apache MPM Tuning
export MPM_START=${MPM_START:-5}
export MPM_MINSPARE=${MPM_MINSPARE:-5}
export MPM_MAXSPARE=${MPM_MAXSPARE:-10}
export MPM_MAXWORKERS=${MPM_MAXWORKERS:-150}
export MPM_MAXCONNECTIONS=${MPM_MAXCONNECTIONS:-0}

# Appel à bootstrap.php Créer la base si elle n'existe pas
php /bootstrap.php

# MySQL Service
export DB_DSNW="mysql://${DATABASE_USER}:${DATABASE_PASS}@${DATABASE_HOST}/${DATABASE_NAME}"

exec $@
