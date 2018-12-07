FROM webdevops/php-apache:alpine-php5

ENV TZ Asia/Shanghai

RUN sed -r -i "s#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g" /etc/apk/repositories \
    && apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN apk add --no-cache php5-imap php5-phar libmemcached openssl\
    && apk add --no-cache --virtual .build-deps gcc g++ make libffi-dev openssl-dev  php5-dev php5-pear autoconf libmemcached-dev cyrus-sasl-dev \
    && pecl install --onlyreqdeps --nobuild memcached-2.2.0 \
    && pecl install redis mongodb igbinary \
    && cd "$(pecl config-get temp_dir)/memcached" \
    && phpize \
    && ./configure --enable-memcached-igbinary \
    && make && make install \
    && cd - \
    && apk del .build-deps\
    && echo 'extension=memcached.so' > /etc/php5/conf.d/memcached.ini\
    && echo 'extension=redis.so' > /etc/php5/conf.d/redis.ini\
    && echo 'extension=mongodb.so' > /etc/php5/conf.d/mongodb.ini\
    && echo 'extension=igbinary.so' > /etc/php5/conf.d/igbinary.ini\
    && docker-service disable postfix \
    && docker-image-cleanup
