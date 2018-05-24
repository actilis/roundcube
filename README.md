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

An example docker-compose.yml is given to test this image.

Please tune the server-names in cas you don't have a mailbox on our servers.

The mysql-root password in the docker-compose.yml is "secret", don't leave it as it is.
The docker-compose.yml runs a PMA container to see the dabatase, for dev and upgrade purposes. 
It may be not necessary for you.
