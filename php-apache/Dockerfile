FROM webdevops/php-apache:alpine-php5

ENV TZ Asia/Shanghai

COPY conf/ /opt/docker/

RUN go-replace --mode=replace --regex -s '^\s*https?://.*?/'  -r "http://mirrors.aliyun.com/" -- /etc/apk/repositories \
    && apk update \
    && apk add tzdata \
    && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apk add php5-imap php5-phar libmemcached openssl\
    && apk add --virtual .build-deps gcc g++ make libffi-dev openssl-dev  php5-dev php5-pear autoconf libmemcached-dev cyrus-sasl-dev \
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
    && docker-service disable postfix ssh syslog \
    && /opt/docker/bin/bootstrap.sh \
    && docker-image-cleanup

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so
