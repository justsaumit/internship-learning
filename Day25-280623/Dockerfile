# node base image
FROM node:18 AS builder
# Setup build directory
WORKDIR /app
COPY . .
# Install the node dependencies and then build the website
RUN npm install && npm run build

# Alpine Linux production image
FROM alpine:3.18
# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  openrc \
  curl \
  nginx \
  php81 \
  php81-ctype \
  php81-curl \
  php81-dom \
  php81-fpm \
  php81-gd \
  php81-intl \
  php81-mbstring \
  php81-mysqli \
  php81-opcache \
  php81-openssl \
  php81-phar \
  php81-session \
  php81-xml \
  php81-xmlreader \
  supervisor

# Configure nginx - http
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
# Configure nginx - default server
COPY docker/nginx/conf.d /etc/nginx/conf.d/

# Configure PHP-FPM
COPY docker/php/fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY docker/php/php.ini /etc/php81/conf.d/custom.ini

# Configure supervisord
COPY docker/nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
COPY --from=builder /app/build .
RUN ls /var/www/html
COPY tle_opm_calc /var/www/html/tle_opm_calc
RUN ls /var/www/html
RUN ls /var/www/html/tle_opm_calc

# info.php for checking if php and php-fpm and other modules are properly configured
RUN echo "<?php \
phpinfo(); \
phpinfo(INFO_MODULES); \
?>" >> info.php

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx
# Switch to use a non-root user from here on
USER nobody

# Expose the port nginx is reachable on
EXPOSE 80

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/test.php
