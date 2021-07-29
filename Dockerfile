FROM php:7.3-apache

RUN apt-get update --fix-missing &&\
	apt-get install -y \
		wget \
		libzip-dev \
		libjpeg-dev \
    		libpng-dev \
		libwebp-dev \
    		libfreetype6-dev &&\
	docker-php-ext-install zip &&\
	docker-php-ext-install mysqli &&\
	docker-php-ext-configure gd --with-webp-dir=/usr/include/webp --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-freetype-dir=/usr/include/freetype2 &&\
	docker-php-ext-install gd

RUN a2enmod rewrite &&\
	cd /tmp &&\
	wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz &&\
	tar -xvzf ioncube_loaders_lin_x86-64.tar.gz &&\
	mkdir /usr/local/ioncube &&\
	cp ioncube/ioncube_loader_lin_7.3.so /usr/local/ioncube/ &&\
	echo Zend_extension=/usr/local/ioncube/ioncube_loader_lin_7.3.so > /usr/local/etc/php/conf.d/ioncube.ini &&\
	rm /tmp/* -rf

RUN wget --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" https://moguta.ru/get-install-file -O index.php &&\
	chown www-data:www-data index.php
