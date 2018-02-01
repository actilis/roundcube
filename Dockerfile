FROM actilis/httpd-php:latest

MAINTAINER Francois MICAUX <dok-images@actilis.net> 

LABEL Vendor="Actilis" \
      License="GPLv3" \
      Version="2018.1"

EXPOSE 80

ENV RC_VERSION=1.3.4
ENV RC_URL=https://github.com/roundcube/roundcubemail/releases/download/${RC_VERSION}/roundcubemail-${RC_VERSION}-complete.tar.gz

WORKDIR /var/www/html

# Install Git & Composer 
RUN dnf -y install git composer 

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

# Carddav, but no CalDAV... (http://www.roundcubeforum.net/index.php/topic,24189.0.html)
# NEEDS PHP<7 # RUN composer -n require roundcube/carddav

# Plugins : dev / unstable
#RUN composer -n require melanie2/jquery_mobile melanie2/mobile melanie2/infinitescroll 
#RUN composer -n require takika/rc_smime
#RUN composer -n require stwa/google-addressbook sblaisot/automatic_addressbook 

# Configuration
COPY files/entrypoint.sh             /
COPY files/bootstrap.php             /
COPY files/defaults.inc.php          /var/www/html/config/defaults.inc.php
COPY files/config.inc.tmpl           /var/www/html/config/config.inc.tmpl
# NEEDS PHP<7 # COPY files/carddav-config.inc.php    /var/www/html/plugins/carddav/config.inc.php

# Permissions
RUN  chown -R root:root /var/www/html && \
     chmod -R 755       /var/www/html && \
     chown -R apache:apache /var/www/html/{temp,logs} 

WORKDIR /var/www/html/logs

# Entrypoint will call CMD from from httpd-php after taking care of parameters (env-vars)
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/httpd-entrypoint.sh"]
