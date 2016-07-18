FROM lsiobase/alpine
MAINTAINER Sparklyballs <sparklyballs@linuxserver.io>

# Install packages
RUN \
apk add --no-cache \
        apache2-proxy \
        apache2-ssl \
        apache2-utils \
        fcgi \
	php5 \
        php5-fpm \
        php5-curl \
        php5-cli \
        openssl

# add local files
COPY root/ /

# enable apache mods
RUN \
mv /defaults/envvars /etc/apache2/envvars && \
mv /defaults/php5-fpm.conf /etc/apache2/conf.d/ && \
sed -i "s#listen = 127.0.0.1:9000#listen = /var/run/php5-fpm.sock#g" /etc/php5/php-fpm.conf && \
sed -i "s#user = nobody#user = abc#g" /etc/php5/php-fpm.conf && \
sed -i "s#group = nobody#group = abc#g" /etc/php5/php-fpm.conf && \
cp /etc/apache2/httpd.conf /defaults/apache2.conf && \
mkdir -p /run/apache2/ && \
touch /run/apache2/httpd.pid && \
chown -R abc:abc /run/apache2/httpd.pid && \
mkdir -p /config/www/modules/ && \
mkdir -p /config/www/logs/ && \
mkdir -p /config/www/localhost/htdocs && \
cp /var/www/modules/* /config/www/modules/ && \
mv /etc/apache2/conf.d/proxy.conf /etc/apache2/conf.d/proxy.bak && \
cp /defaults/index.html /config/www/localhost/htdocs

# expose ports
EXPOSE 80 443

# set volumes
VOLUME /config
