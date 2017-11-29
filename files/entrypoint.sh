#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x


genpasswd() {
    export LC_CTYPE=C  # Quiet tr warnings
    local l=$1
    [ "$l" == "" ] && l=16
    cat /dev/urandom | tr -dc A-Za-z0-9_ | head -c ${l}
}

# Database
export DATABASE_HOST=${DATABASE_HOST:-db}
export DATABASE_USER=${DATABASE_USER:-root}
export DATABASE_NAME=${DATABASE_NAME:-roundcube}
# (bad) default is root password of the DB linked container
export DATABASE_PASS=${DATABASE_PASS:-${DB_ENV_MYSQL_ROOT_PASSWORD}}

# Default IMAP/SMTP values
export IMAP_SERVER=${IMAP_SERVER:-imap}
export IMAP_PORT=${IMAP_PORT:-143}
export SMTP_SERVER=${SMTP_SERVER:-smtp}
export SMTP_PORT=${SMTP_SERVER:-25}
export SMTP_HELO_HOST=${SMTP_SERVER:-smtp.localdomain}

# Apache MPM Tuning defaults
export MPM_START=${MPM_START:-5}
export MPM_MINSPARE=${MPM_MINSPARE:-5}
export MPM_MAXSPARE=${MPM_MAXSPARE:-10}
export MPM_MAXWORKERS=${MPM_MAXWORKERS:-150}
export MPM_MAXCONNECTIONS=${MPM_MAXCONNECTIONS:-0}

# Appel à bootstrap.php Créer la base si elle n'existe pas
php /bootstrap.php

# Roundcube vars
export DES_KEY=$(genpasswd 24)

# MySQL Service
export DB_DSNW="mysql://${DATABASE_USER}:${DATABASE_PASS}@${DATABASE_HOST}/${DATABASE_NAME}"

echo $@
exec $@
