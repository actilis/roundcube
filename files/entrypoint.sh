#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x


genpasswd() {
    export LC_CTYPE=C  # Quiet tr warnings
    local l=$1
    [ "$l" == "" ] && l=16
    cat /dev/urandom | tr -dc A-Za-z0-9_ | head -c ${l}
}

# Session Lifetime (minutes)
export SESSION_LIFETIME=${SESSION_LIFETIME:-30}

# Database
export DATABASE_HOST=${DATABASE_HOST:-db}
export DATABASE_USER=${DATABASE_USER:-root}
export DATABASE_PASS=${DATABASE_PASS:-secret}
export DATABASE_NAME=${DATABASE_NAME:-roundcube}

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

# Roundcube vars
export DES_KEY=$(genpasswd 24)

# MySQL Service
export DB_DSNW="mysql://${DATABASE_USER}:${DATABASE_PASS}@${DATABASE_HOST}/${DATABASE_NAME}"

# Make rouncube config from template
sed \
    -e "s,_IMAP_PROTO_,${IMAP_PROTO}," \
    -e "s,_IMAP_SERVER_,${IMAP_SERVER}," \
    -e "s,_IMAP_PORT_,${IMAP_PORT}," \
    -e "s,_SMTP_PROTO_,${SMTP_PROTO}," \
    -e "s,_SMTP_SERVER_,${SMTP_SERVER}," \
    -e "s,_SMTP_PORT_,${SMTP_PORT}," \
    -e "s,_SMTP_HELO_HOST_,${SMTP_HELO_HOST}," \
    -e "s,_DES_KEY_,${DES_KEY}," \
    -e "s,_DB_DSNW_,${DB_DSNW}," \
    -e "s,_SESSION_LIFETIME_,${SESSION_LIFETIME}," \
  /var/www/html/config/config.inc.tmpl > /var/www/html/config/config.inc.php

rm -f /var/www/html/config/config.inc.tmpl

# Permissions
#chown -R root:root /var/www/html
#chmod -R 755       /var/www/html 
chown -R www-data:www-data /var/www/html/config
chown -R www-data:www-data /var/www/html/temp
chown -R www-data:www-data /var/www/html/logs
chown    root.www-data   /var/www/html/config/{defaults,config}.inc.php 
chmod    440             /var/www/html/config/{defaults,config}.inc.php

# Appel à bootstrap.php Créer la base si elle n'existe pas
sleep 5 &&  php /bootstrap.php

[ "$DEBUG" == 'true' ] && exec /bin/bash
exec $@
