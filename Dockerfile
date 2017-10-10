FROM actilis/httpd-php:latest

MAINTAINER Francois MICAUX <dok-images@actilis.net> 

LABEL Vendor="Actilis" \
      License=GPLv2 \
      Version=2017.10

EXPOSE 80

ENV RC_VERSION 1.3.1
ENV RC_URL=https://github.com/roundcube/roundcubemail/releases/download/${RC_VERSION}/roundcubemail-${RC_VERSION}-complete.tar.gz

WORKDIR /var/www/html

# Install Pear modules & Code from Git
RUN rm -rf /var/www/html/* \
 && curl -SL ${RC_URL} | tar -C /var/www/html -xz --strip-components 1 \
 && mkdir -p /var/www/html/plugins/thunderbird_labels \
 && rm -rf installer \
 && mv composer.json-dist composer.json 

# Plugins : Stable
RUN composer -n require \
  johndoh/contextmenu \
  weird-birds/thunderbird_labels \
  cor/message_highlight \
  prodrigestivill/gravatar

# Plugins : Kolab
RUN composer -n require  kolab/libcalendaring kolab/calendar 

# Plugins : dev / unstable
#RUN composer -n require melanie2/jquery_mobile melanie2/mobile melanie2/infinitescroll 
#RUN composer -n require takika/rc_smime
#RUN composer -n require stwa/google-addressbook sblaisot/automatic_addressbook 

# Configuration
COPY files/entrypoint.sh             /
COPY files/bootstrap.php             /
COPY files/mpm_prefork.conf          /etc/httpd/conf.d/mpm-prefork.conf
COPY files/defaults.inc.php          /var/www/html/config/defaults.inc.php
COPY files/config.inc.php            /var/www/html/config/config.inc.php

# Permissions
RUN  chown -R root:root /var/www/html && \
     chown -R apache:apache /var/www/html/{temp,logs} && \
     chgrp           apache /var/www/html/config/{defaults,config}.inc.php

WORKDIR /var/www/html/logs

# Don't Keep Entrypoint from apache-php because of parameters (env-vars)
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "/usr/sbin/httpd", "-D", "FOREGROUND", "-k", "start" ]
