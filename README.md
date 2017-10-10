# actilis/roundcube Webmail

RoundCube with MySQL storage and few plugins.

## Configuration parameters

The default is to use the user login and password to authenticate against the smtp-server while sending email.

Default values are probably not suitable for your installation... (db, imap & smtp servers)

### Roundcube Config

- DATABASE_HOST
- DATABASE_USER
- DATABASE_PASS
- DATABASE_NAME
- IMAP_SERVER
- IMAP_PORT
- SMTP_SERVER
- SMTP_PORT
- SMTP_HELO_HOST

### HTTPD/prefork tuning

- MPM_START
- MPM_MINSPARE
- MPM_MAXSPARE
- MPM_MAXWORKERS
- MPM_MAXCONNECTIONS

