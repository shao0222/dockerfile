FROM webdevops/php-apache:alpine-php5

ENV TZ Asia/Shanghai

RUN echo 'http://mirrors.aliyun.com/alpine/v3.5/main' > /etc/apk/repositories \
    && echo 'http://mirrors.aliyun.com/alpine/v3.5/community' >> /etc/apk/repositories \
    && apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN apk add --no-cache php5-imap php5-phar geoip libmemcached openssl\
    && apk add --no-cache --virtual .build-deps gcc g++ make libffi-dev openssl-dev geoip-dev php5-dev php5-pear autoconf libmemcached-dev cyrus-sasl-dev \
    && pecl install --onlyreqdeps --nobuild memcached-2.2.0 \
    && cd "$(pecl config-get temp_dir)/memcached" \
    && phpize \
    && ./configure --enable-memcached-igbinary \
    && make && make install
    && cd -
    && pecl install geoip redis mongodb \
    && apk del .build-deps\
    && echo 'extension=geoip.so' > /etc/php5/conf.d/geoip.ini\
    && echo 'extension=memcached.so' > /etc/php5/conf.d/memcached.ini\
    && echo 'extension=redis.so' > /etc/php5/conf.d/redis.ini\
    && echo 'extension=mongodb.so' > /etc/php5/conf.d/mongodb.ini\
    && docker-image-cleanup
