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
- IMAP_PROTO
- IMAP_SERVER
- IMAP_PORT
- SMTP_PROTO
- SMTP_SERVER
- SMTP_PORT
- SMTP_HELO_HOST

### HTTPD/prefork tuning

- MPM_START
- MPM_MINSPARE
- MPM_MAXSPARE
- MPM_MAXWORKERS
- MPM_MAXCONNECTIONS


### Example docker-compose.yml

Shoud-be HTTPSified behind a reverse Proxy.

```
roundcube:
  image: actilis/roundcube
  #image: rctest:debian
  restart: on-failure
  ports:
  - "80:80"
  environment:
    - VIRTUAL_HOST=webmail.your-domain
    - HTTPD_SERVERADMIN=mailadmin@your-domain
    - IMAP_PROTO=ssl
    - IMAP_SERVER=mail.your-domain
    - IMAP_PORT=993
    - SMTP_PROTO=tls
    - SMTP_SERVER=smtp.your-domain
    - SMTP_PORT=587
    - DATABASE_HOST=mysqlserver
    - DATABASE_USER=dbuser
    - DATABASE_PASS=dbpass
    - DATABASE_NAME=dbname
```
