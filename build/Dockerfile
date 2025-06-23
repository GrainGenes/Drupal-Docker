ARG UBUNTU_VERSION=22.04
FROM ubuntu:$UBUNTU_VERSION

# Get build args from the docker-compose.yml file
ARG PHP_VERSION=7.1
ARG DRUPAL_VERSION=7.103
ARG TIMEZONE=America/Los_Angeles

# Set timezone for non-interactive installs
RUN ln -fs /usr/share/zoneinfo/$TIMEZONE /etc/localtime
ENV DEBIAN_FRONTEND=noninteractive

# Install additional dependencies
RUN apt update && apt install -y \
	software-properties-common tzdata apache2 \
	wget nano vim tmux less
RUN dpkg-reconfigure -f noninteractive tzdata

# Install php
RUN add-apt-repository -y ppa:ondrej/php
RUN apt update && apt install -y php${PHP_VERSION}
RUN apt install -y default-mysql-client
add-apt-repository ppa:ondrej/php
RUN apt-get install -y \
  zip \
  unzip \
	ph${PHP_VERSION}-bz2 \
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



# Install drupal
WORKDIR /var/www/html/GG3
RUN wget "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz"
RUN tar --strip-components=1 -xvzf "drupal-${DRUPAL_VERSION}.tar.gz"
RUN rm "drupal-${DRUPAL_VERSION}.tar.gz"

RUN echo 'alias ll="ls -lsa"' >> ~/.bashrc
RUN echo "PS1='[\h \W]\$ '" >> ~/.bashrc

# COPY source/temp/* /var/www/html
# COPY source/settings.php /var/www/html/GG3/sites/default/settings.php

# Start apache
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
