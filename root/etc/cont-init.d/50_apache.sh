#!/bin/bash
sed -i "s#/var/www#/config/www#g" /etc/apache2/httpd.conf 
sed -i "s/Listen 80/#Listen 80/g" /etc/apache2/httpd.conf
sed -i "s/User apache/User abc/g" /etc/apache2/httpd.conf
sed -i "s/Group apache/Group abc/g" /etc/apache2/httpd.conf

if ! grep -q 'Include /config/apache/ports.conf' /etc/apache2/httpd.conf ; then
    echo "Include /config/apache/ports.conf" >> /etc/apache2/httpd.conf
fi

if ! grep -q 'Listen 80' /etc/apache2/ports.conf ; then
    echo "Listen 80" >> /etc/apache2/ports.conf
fi

if ! grep -q 'IncludeOptional /config/apache/site-confs' /etc/apache2/httpd.conf ; then
    echo "IncludeOptional /config/apache/site-confs" >> /etc/apache2/httpd.conf
fi