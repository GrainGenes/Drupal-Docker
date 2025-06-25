ARG UBUNTU_VERSION=22.04
FROM ubuntu:$UBUNTU_VERSION

ENV DEBIAN_FRONTEND=noninteractive

# Get build args from the docker-compose.yml file
ARG PHP_VERSION=8.4
ARG DRUPAL_VERSION=7.103
ARG TIMEZONE=America/Los_Angeles

# Set timezone for non-interactive installs
RUN ln -fs /usr/share/zoneinfo/$TIMEZONE /etc/localtime

RUN apt update
RUN apt install -y software-properties-common
RUN apt install gnupg
RUN apt-get install ca-certificates

# Install php
RUN add-apt-repository -y ppa:ondrej/php
RUN apt update && apt install -y php${PHP_VERSION}
RUN apt install -y default-mysql-client
RUN add-apt-repository ppa:ondrej/php

# Install additional dependencies
RUN apt update && apt install -y \
	software-properties-common tzdata apache2 \
	wget nano vim tmux less
RUN dpkg-reconfigure -f noninteractive tzdata


RUN apt-get install -y \
  zip \
  unzip \
	php${PHP_VERSION}-bz2 \
	php${PHP_VERSION}-cgi \
	php${PHP_VERSION}-cli \
	php${PHP_VERSION}-common \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-dev \
	php${PHP_VERSION}-enchant \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-gd \
	php${PHP_VERSION}-gmp \
	php${PHP_VERSION}-imap \
	php${PHP_VERSION}-interbase \
	php${PHP_VERSION}-intl \
	php${PHP_VERSION}-ldap \
	php${PHP_VERSION}-mbstring \
	php${PHP_VERSION}-mysql \
	php${PHP_VERSION}-opcache \
	php${PHP_VERSION}-pgsql \
	php${PHP_VERSION}-pspell \
	php${PHP_VERSION}-readline \
	php${PHP_VERSION}-snmp \
	php${PHP_VERSION}-tidy \
	php${PHP_VERSION}-xmlrpc \
	php${PHP_VERSION}-xsl \
	php${PHP_VERSION}-zip \
	apache2 \
	libapache2-mod-php${PHP_VERSION} \
	libapache2-mod-perl2 \
  git \ 
  composer \
  vim \
  curl \
  wget
	
# RUN 'a2enmod rewrite'


RUN echo 'alias ll="ls -lsa"' >> ~/.bashrc
RUN echo "PS1='[\h \W]\$ '" >> ~/.bashrc

# Install drupal
WORKDIR /var/www/html/GG3
RUN wget "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz"
RUN tar --strip-components=1 -xvzf "drupal-${DRUPAL_VERSION}.tar.gz"
RUN rm "drupal-${DRUPAL_VERSION}.tar.gz"

# RUN mkdir /var/www/html/sites/default
# WORKDIR /var/www/html/GG3/sites/default


# these haven't been working in here so doing them in the OS after it's fire upd
# docker cp source/settings.php graingenes_drupal:/var/www/html/GG3/sites/default
# docker cp drupal_prvt_files/ graingenes_drupal:/data/drupal_prvt_files
# docker cp -a source/ graingenes_drupal:/var/www/html/GG3/sites
# docker cp -a source/apache/source/apache/000-default.conf graingenes_drupal:/etc/apache2/sites-available/000-default.conf

# Start apache
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
# CMD ["sleep","3600"]